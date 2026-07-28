import UIKit
import FirebaseFirestore

class LearnContainerViewController: UIViewController {
    
    let quizListVC = QuizListViewController()
    let techWordsVC = CategoryViewController()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [
            "▶ \(NSLocalizedString("quiz_tab_button", comment: ""))",
            "📁 Tech Words"
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
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = EditorTheme.editorBackground
        applyEditorTheme()
        setPageView()
        setupLeftNavBarButton()
        checkIsDescription()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateRemoveAdsButtonVisibility),
            name: PurchaseManager.adFreeStatusChangedNotification,
            object: nil
        )
    }
    
    // MARK: - Theme
    
    private func applyEditorTheme() {
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: EditorFonts.mono(size: EditorFonts.Size.small),
            .foregroundColor: EditorTheme.textInactive
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: EditorFonts.monoSemibold(size: EditorFonts.Size.small),
            .foregroundColor: EditorTheme.textDefault
        ]
        
        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        segmentedControl.backgroundColor = EditorTheme.sidebarBackground
        segmentedControl.selectedSegmentTintColor = EditorTheme.tabBarBackground
        
        if #available(iOS 13.0, *) {
            segmentedControl.layer.borderWidth = 1
            segmentedControl.layer.borderColor = EditorTheme.border.cgColor
        }
    }
    
    // MARK: - Layout
    
    func setPageView() {
        view.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.backgroundColor = EditorTheme.editorBackground
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 12),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
    }
    
    // MARK: - Remove Ads (Paywall)

    private func setupLeftNavBarButton() {
        updateRemoveAdsButtonVisibility()
    }

    /// 広告オフ未購入のときだけ「広告オフ」導線を出す
    @objc private func updateRemoveAdsButtonVisibility() {
        guard !PurchaseManager.shared.isAdFree else {
            navigationItem.leftBarButtonItem = nil
            return
        }
        let removeAdsButton = UIBarButtonItem(
            image: UIImage(systemName: "nosign"),
            style: .plain,
            target: self,
            action: #selector(showRemoveAds)
        )
        removeAdsButton.tintColor = EditorTheme.accentPrimary
        navigationItem.leftBarButtonItem = removeAdsButton
    }

    @objc private func showRemoveAds() {
        let removeAdsVC = RemoveAdsViewController(source: .learnNav)
        if #available(iOS 15.0, *) {
            if let sheet = removeAdsVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }
        }
        present(removeAdsVC, animated: true)
    }

    // MARK: - Helper Functions

    func checkIsDescription() {
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedFirstTimeOnboarding")
        if !hasCompletedOnboarding {
            setDiscrptionView()
        }
    }
    
    // MARK: - Actions
    
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
