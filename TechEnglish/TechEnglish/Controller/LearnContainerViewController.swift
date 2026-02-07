import UIKit
import FirebaseFirestore

class LearnContainerViewController: UIViewController {
    
    let quizListVC = QuizListViewController()
    let techWordsVC = CategoryViewController()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [
            NSLocalizedString("quiz_tab_button", comment: ""),
            "Tech Words"
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
        quizListVC,
        techWordsVC
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageView()
        setDescriptionButton()
        checkIsDescription() // 説明ダイアログが必要か確認
    }
    
    // MARK: - Layout
    func setPageView(){
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
    
    func setDescriptionButton() {
        let descriptionButton = UIButton(type: .system)
        descriptionButton.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        descriptionButton.tintColor = AppColors.appMainColor
        // QuickMemoからの遷移は1ページ目を初期表示に設定
        let data = ["discriptNumber": 1]
        NotificationCenter.default.post(name: Notification.Name("addDescription"), object: nil, userInfo: data)
        print("send data \(data)")
        descriptionButton.addTarget(self, action: #selector(setDiscrptionView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: descriptionButton)
    }
    
    //MARK: - Helper Functions
    /// 初回ダウンロード時のみオンボーディングを自動表示する
    func checkIsDescription() {
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedFirstTimeOnboarding")
        if !hasCompletedOnboarding {
            setDiscrptionView()
        }
    }
    
    // MARK: - objc
    @objc private func segmentChanged() {
        let index = segmentedControl.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = (index == 0) ? .reverse : .forward
        pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true, completion: nil)
    }
    
    @objc func setDiscrptionView() {
        let vc = DescriptionViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}

extension LearnContainerViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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
