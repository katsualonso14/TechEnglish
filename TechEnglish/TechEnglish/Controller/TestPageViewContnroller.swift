import UIKit

class TopTabContainerViewController: UIViewController {
    
    private let pageViewController: UIPageViewController
    private let viewControllers: [UIViewController]
    private var currentIndex: Int = 0
    
    init() {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.viewControllers = [WordSeedViewController(), CustomWordsViewController(), SavedDocsController()]
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSegmentedControl()
        setupPageViewController()
    }

    private func setupSegmentedControl() {
        let segmentedControl = UISegmentedControl(items: ["Tab1", "Tab2", "Tab3"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)

        navigationItem.titleView = segmentedControl
    }

    private func setupPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.view.frame = view.bounds
        pageViewController.didMove(toParent: self)
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = index >= currentIndex ? .forward : .reverse
        pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true, completion: nil)
        currentIndex = index
    }
}

extension TopTabContainerViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pvc: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index > 0 else { return nil }
        return viewControllers[index - 1]
    }

    func pageViewController(_ pvc: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index < viewControllers.count - 1 else { return nil }
        return viewControllers[index + 1]
    }

    func pageViewController(_ pvc: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleVC = pvc.viewControllers?.first, let index = viewControllers.firstIndex(of: visibleVC) {
            currentIndex = index
            (navigationItem.titleView as? UISegmentedControl)?.selectedSegmentIndex = index
        }
    }
}
