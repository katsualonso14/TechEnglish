import UIKit
import GoogleMobileAds
import UserMessagingPlatform
import AppTrackingTransparency
import AdSupport

class MainTabBarController: UITabBarController, BannerViewDelegate, UITabBarControllerDelegate {
    
    var bannerView: BannerView!
    let requestParameters = UMPRequestParameters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupTab()
//        setupBanner()
    }
    
    //MARK: -Layout
    //タブバーの表示
    func setupTab() {
        self.tabBar.tintColor = AppColors.appMainColor
        view.backgroundColor = .systemGray6
        
        let learnVC = LearnContainerViewController()
        learnVC.tabBarItem.image = UIImage(systemName: "book.closed")
        learnVC.tabBarItem.title = NSLocalizedString("learn_tab_button", comment: "")
        let nv1 = UINavigationController(rootViewController: learnVC)
        
        let myCardsVC = MyCardsViewController()
        myCardsVC.tabBarItem.image = UIImage(systemName: "tag")
        myCardsVC.tabBarItem.title = "My Cards"
        let nv2 = UINavigationController(rootViewController: myCardsVC)
        
        let remindVC = RemindListController()
        remindVC.tabBarItem.image = UIImage(systemName: "bell")
        remindVC.tabBarItem.title = NSLocalizedString("remind_tab_button", comment: "")
        let nv3 = UINavigationController(rootViewController: remindVC)
        
        setViewControllers([nv1, nv2, nv3], animated: false)
    }
    
    //MARK: -Admob
    func setupBanner() {
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = currentOrientationAnchoredAdaptiveBanner(width: viewWidth)
        bannerView = BannerView(adSize: adaptiveSize)
        
        bannerView.delegate = self
        bannerView.adUnitID = MyAds.bannerID
        bannerView.rootViewController = self
        bannerView.load(Request())
        
        // set main thread
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.addBannerViewToView(self.bannerView)
        }
    }
    
    // Setting ads x and y
    func addBannerViewToView(_ bannerView: BannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        
        let tabBarY = self.tabBar.frame.origin.y
        
        NSLayoutConstraint.activate([
            bannerView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: tabBarY),
            bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: -TabBarControllerDelegate
    // タブバー選択時にモーダル表示
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is DummyViewController {
            showModal()
            return false // 選択しない
        }
        return true
    }
    
    // MARK: - objc
    @objc func showModal() {
        // MyCardの場所をサーチ
        if let myCardsVC = self.viewControllers?.first(where: {
            ($0 as? UINavigationController)?.viewControllers.first is MyCardsViewController
        }) as? UINavigationController,
           let targetVC = myCardsVC.viewControllers.first as? MyCardsViewController {
            
            let inputVC = MyCardsInputViewController()
            inputVC.delegate = targetVC // delegateにMyCardsViewControllerを設定
            if #available(iOS 15.0, *) {
                if let sheet = inputVC.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.prefersGrabberVisible = true
                }
            }
            present(inputVC, animated: true)
        }
    }

}
