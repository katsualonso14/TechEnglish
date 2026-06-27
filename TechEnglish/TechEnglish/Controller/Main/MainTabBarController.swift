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
        applyEditorTheme()
        setupTab()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showDailyWordIfNeeded()
    }
    
    // MARK: - Theme
    
    private func applyEditorTheme() {
        overrideUserInterfaceStyle = .dark
        EditorTheme.applyToTabBar(tabBar)
        view.backgroundColor = EditorTheme.editorBackground
    }
    
    // MARK: - Layout
    
    func setupTab() {
        let learnVC = LearnContainerViewController()
        learnVC.tabBarItem.image = UIImage(systemName: "terminal")
        learnVC.tabBarItem.selectedImage = UIImage(systemName: "terminal.fill")
        learnVC.tabBarItem.title = NSLocalizedString("learn_tab_button", comment: "")
        let nv1 = UINavigationController(rootViewController: learnVC)
        EditorTheme.applyToNavigationBar(nv1.navigationBar)
        
        let myCardsVC = MyCardsViewController()
        myCardsVC.tabBarItem.image = UIImage(systemName: "doc.text")
        myCardsVC.tabBarItem.selectedImage = UIImage(systemName: "doc.text.fill")
        myCardsVC.tabBarItem.title = "My Cards"
        let nv2 = UINavigationController(rootViewController: myCardsVC)
        EditorTheme.applyToNavigationBar(nv2.navigationBar)
        
        let remindVC = RemindListController()
        remindVC.tabBarItem.image = UIImage(systemName: "clock.arrow.circlepath")
        remindVC.tabBarItem.selectedImage = UIImage(systemName: "clock.arrow.circlepath")
        remindVC.tabBarItem.title = NSLocalizedString("remind_tab_button", comment: "")
        let nv3 = UINavigationController(rootViewController: remindVC)
        EditorTheme.applyToNavigationBar(nv3.navigationBar)
        
        setViewControllers([nv1, nv2, nv3], animated: false)
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
    
    // MARK: - Daily Word
    private func showDailyWordIfNeeded() {
        guard DailyWordManager.shared.shouldShowDailyWord() else {
            return
        }
        
        guard let wordData = DailyWordManager.shared.getRandomWord() else {
            return
        }
        
        let dailyWordVC = DailyWordViewController()
        dailyWordVC.wordData = wordData
        
        if #available(iOS 15.0, *) {
            if let sheet = dailyWordVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.selectedDetentIdentifier = .medium
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.present(dailyWordVC, animated: true) {
                DailyWordManager.shared.markAsShown()
            }
        }
    }

}
