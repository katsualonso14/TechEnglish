import UIKit
import GoogleMobileAds
import UserMessagingPlatform
import AppTrackingTransparency
import AdSupport

class MainTabBarController: UITabBarController, BannerViewDelegate {
    
    var bannerView: BannerView!
    let requestParameters = UMPRequestParameters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
        setupBanner()
    }
    
    //MARK: -Layout
    //タブバーの表示
    func setupTab() {
        self.tabBar.tintColor = AppColors.appMainColor
        view.backgroundColor = .systemGray6
        
        let phrasesVC = QuickMemoViewController()
        phrasesVC.tabBarItem.image = UIImage(systemName: "pencil.and.scribble")
        phrasesVC.tabBarItem.title = "単語のタネ"
        let nv1 = UINavigationController(rootViewController: phrasesVC)
        
        let phraseStoreVC = PhraseStoreViewController()
        phraseStoreVC.tabBarItem.image = UIImage(systemName: "pencil.and.outline")
        phraseStoreVC.tabBarItem.title = "カスタム単語帳"
        let nv2 = UINavigationController(rootViewController: phraseStoreVC)
        
        let categoryViewController = CategoryViewController()
        categoryViewController.tabBarItem.image = UIImage(systemName: "character.book.closed")
        categoryViewController.tabBarItem.title = "Tech Words"
        let nv3 = UINavigationController(rootViewController: categoryViewController)
        
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
    

}
