import UIKit
import FirebaseFirestore

class RecordContainerViewController: UIViewController {
    
    let remindVC = RemindListController()
    let recordVC = RecordViewController()

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [
            NSLocalizedString("remind_tab_button", comment: ""),
            NSLocalizedString("record_tab_button", comment: "")
        ])
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.dataSource = self
        vc.delegate = self
        return vc
    }()
    
    private lazy var viewControllers: [UIViewController] = [
        remindVC,
        recordVC
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNabRightButton()
        setupSavedDocsButton()
        // 上部セグメント
        view.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // PageViewController埋め込み
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 初期表示
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
    }
    
    // MARK: - Layout
    func setupNabRightButton() {
        let feedbackButton = UIBarButtonItem(
            image: UIImage(systemName: "bubble.left.and.bubble.right"),
            style: .plain,
            target: self,
            action: #selector(openFeedbackModal)
        )
        let deleteButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(openAllNotifDeleteAleart)
        )
        
        feedbackButton.tintColor = AppColors.appMainColor
        deleteButton.tintColor = AppColors.appMainColor
        navigationItem.rightBarButtonItems = [feedbackButton, deleteButton]
    }
        
    func setupSavedDocsButton() {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.tintColor = AppColors.appMainColor
        button.addTarget(self, action: #selector(transitionToSavedDocs), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    // Store feedback to Firestore
    func saveFeedbackToFirestore(feedback: String) {
        let db = Firestore.firestore()
        db.collection("feedbacks").addDocument(data: [
            "feedback": feedback,
            "timestamp": Timestamp(date: Date())
        ]) { error in
            if let error = error {
                print("Error saving feedback: \(error.localizedDescription)")
            } else {
                print("Feedback successfully saved!")
            }
        }
    }
    
    //MARK: Delete Notification
    //全ての通知を削除する処理
    func showDeleteAllDoneAlert() {
        //全ての通知を削除しましたのダイアログ表示
        let alert = UIAlertController(
            title: NSLocalizedString("delete_all_notif_finish_title", comment: ""),
            message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // RemidListから全データ削除
    func deleteAllRemindList() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        
        UserDefaults.standard.set([], forKey: "remindItems")
        remindVC.remindItems.removeAll()
        remindVC.tableView.reloadData()
    }
    
    // MARK: - objc
    @objc func openFeedbackModal() {
        let alert = UIAlertController(title: "Feedback",
                                      message: NSLocalizedString("feedback_massage", comment: ""),
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Feedback"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            if let feedback = alert.textFields?.first?.text , !feedback.isEmpty {
                // Save feedback to Firestore
                self.saveFeedbackToFirestore(feedback: feedback)
            } else {
                // Show error message
                let errorAlert = UIAlertController(title: "Error", message: "Please enter feedback.", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func transitionToSavedDocs() {
        let savedDocsVC = SavedDocsController()
        navigationController?.pushViewController(savedDocsVC, animated: true)
    }

    @objc private func segmentChanged() {
        let index = segmentedControl.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = (index == 0) ? .reverse : .forward
        pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true, completion: nil)
    }
    
    // 全てのリマインドを削除
    @objc func openAllNotifDeleteAleart(){
        let alert = UIAlertController(title: NSLocalizedString("delete_all_remind_title", comment: ""),
                                      message: NSLocalizedString("delete_all_remind_message", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive, handler: { [self] _ in
            deleteAllRemindList()
            showDeleteAllDoneAlert()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension RecordContainerViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index > 0 else { return nil }
        return viewControllers[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index < viewControllers.count - 1 else { return nil }
        return viewControllers[index + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentVC = pageViewController.viewControllers?.first,
           let index = viewControllers.firstIndex(of: currentVC) {
            segmentedControl.selectedSegmentIndex = index
        }
    }
}
