import UIKit
import GoogleMobileAds

class MyCardsViewController: UIViewController, MyCardsInputDelegate {
    // ... 既存のコード ...
    
    // MARK: - Interstitial Ad
    private var interstitialAd: InterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Cards"
        setView()
        setTableView()
        setupSearchController()
        setupRightNavBarButton()
        loadInterstitialAd() // 広告を先読み
    }
    
    // MARK: - Interstitial Ad
    func loadInterstitialAd() {
        let request = Request()
        InterstitialAd.load(with: MyAds.interstitialTestID, request: request) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load interstitial ad: \(error.localizedDescription)")
                return
            }
            self.interstitialAd = ad
            self.interstitialAd?.fullScreenContentDelegate = self
        }
    }
    
    // メモ追加モーダル表示
    @objc func openAddMyCardModal() {
        let inputVC = MyCardsInputViewController()
        inputVC.delegate = self
        inputVC.interstitialAd = interstitialAd // 広告を渡す
        if #available(iOS 15.0, *) {
            if let sheet = inputVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
            }
        }
        present(inputVC, animated: true)
    }
    
    // メモの編集処理
    func openEditMyCard(editingCard: MyCard, index: Int) {
        let modal = MyCardsInputViewController()
        modal.delegate = self
        modal.editMode = true
        modal.currentIndex = index
        modal.myWordsTextView.text = editingCard.word
        modal.setenceTextView.text = editingCard.sentence
        modal.interstitialAd = interstitialAd // 広告を渡す
        present(modal, animated: true)
    }
}

// MARK: - GADFullScreenContentDelegate
extension MyCardsViewController: FullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        // 広告が閉じられた後、次の広告を読み込む
        loadInterstitialAd()
    }
    
    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Failed to present interstitial ad: \(error.localizedDescription)")
        // エラーが発生した場合も、次の広告を読み込む
        loadInterstitialAd()
    }
}
