import UIKit
import GoogleMobileAds

protocol MyCardsInputDelegate: AnyObject {
    func didSaveMyCards(frontText: String, backText: String)
    func didSaveEditMyCards(frontText: String, backText: String, index: Int)
    func saveEditFilterdMyCards()
}

class MyCardsInputViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let headerView = UIView()
    private let headerLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    
    let frontLabel = UILabel()
    let backLabel = UILabel()
    let myWordsField = UITextField()
    let myWordsTextView = PlaceholderTextView()
    let setenceTextView = PlaceholderTextView()
    let saveButton = EditorButton()
    let separator = UIView()
    var editMode = false
    var currentIndex: Int = 0
    
    weak var delegate: MyCardsInputDelegate?
    var interstitialAd: InterstitialAd?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyEditorTheme()
        setupHeader()
        setupFrontLabel()
        setupMyWordTextView()
        setupSeparator()
        setupBackLabel()
        setupSentenceTextView()
        saveButtonSetup()
        loadInterstitialAd()
    }
    
    // MARK: - Theme
    
    private func applyEditorTheme() {
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = EditorTheme.editorBackground
    }
    
    // MARK: - Setup
    
    private func setupHeader() {
        headerView.backgroundColor = EditorTheme.tabBarBackground
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        headerLabel.text = editMode ? "// Edit Card" : "// New Card"
        headerLabel.font = EditorFonts.mono(size: EditorFonts.Size.body)
        headerLabel.textColor = EditorTheme.comment
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = EditorTheme.textInactive
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            
            closeButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupMyWordTextView() {
        myWordsTextView.placeholder = NSLocalizedString("word_placeholder", comment: "")
        view.addSubview(myWordsTextView)
        myWordsTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            myWordsTextView.topAnchor.constraint(equalTo: frontLabel.bottomAnchor, constant: 8),
            myWordsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myWordsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myWordsTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupSentenceTextView() {
        setenceTextView.placeholder = NSLocalizedString("memo_placeholder", comment: "")
        view.addSubview(setenceTextView)
        setenceTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            setenceTextView.topAnchor.constraint(equalTo: backLabel.bottomAnchor, constant: 8),
            setenceTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setenceTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setenceTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func saveButtonSetup() {
        saveButton.style = .primary
        saveButton.setTitle("$ \(NSLocalizedString("save", comment: ""))", for: .normal)
        saveButton.titleLabel?.font = EditorFonts.monoSemibold(size: EditorFonts.Size.body)
        saveButton.layer.cornerRadius = 6
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: setenceTextView.bottomAnchor, constant: 24),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
    }

    func setupSeparator() {
        separator.backgroundColor = EditorTheme.border
        separator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator)

        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: myWordsTextView.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupFrontLabel() {
        frontLabel.text = "let word = // \(NSLocalizedString("front_label", comment: ""))"
        frontLabel.font = EditorFonts.mono(size: EditorFonts.Size.small)
        frontLabel.textColor = EditorTheme.keyword
        frontLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(frontLabel)
        
        NSLayoutConstraint.activate([
            frontLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            frontLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func setupBackLabel() {
        backLabel.text = "let memo = // \(NSLocalizedString("back_label", comment: ""))"
        backLabel.font = EditorFonts.mono(size: EditorFonts.Size.small)
        backLabel.textColor = EditorTheme.keyword
        backLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backLabel)
        
        NSLayoutConstraint.activate([
            backLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            backLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    // MARK: - Actions
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    @objc func saveTapped() {
        let frontText = myWordsTextView.text ?? ""
        let backText = setenceTextView.text ?? ""
        
        if frontText.isEmpty {
            showEditorAlert(
                title: "// Error",
                message: NSLocalizedString("word_seeds_error_message", comment: "")
            )
            return
        }
        
        if editMode {
            delegate?.didSaveEditMyCards(frontText: frontText, backText: backText, index: currentIndex)
            delegate?.saveEditFilterdMyCards()
            dismiss(animated: true, completion: nil)
        } else {
            delegate?.didSaveMyCards(frontText: frontText, backText: backText)
            delegate?.saveEditFilterdMyCards()
            
            let willShowAd = showInterstitialAdIfAvailable()
            if !willShowAd {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func showEditorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = .dark
        alert.view.tintColor = EditorTheme.accentPrimary
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
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
    
    func showInterstitialAdIfAvailable() -> Bool {
        // 1日2回までの制限をチェック
//        guard canShowInterstitialAd() else {
//            return false
//        }
        
        guard let interstitialAd = interstitialAd else {
            // 広告が読み込まれていない場合は、表示しない
            return false
        }
        
        // 表示回数をカウント
        incrementInterstitialAdCount()
        
        interstitialAd.present(from: self)
        // 広告を表示した後、オブジェクトをnilにして再利用を防ぐ
        self.interstitialAd = nil
        return true
    }
    
    // MARK: - Interstitial Ad Limit (1日2回まで)
    private func canShowInterstitialAd() -> Bool {
        let today = getTodayString()
        let lastDate = UserDefaults.standard.string(forKey: "myCardInterstitialLastDate") ?? ""
        let count = UserDefaults.standard.integer(forKey: "myCardInterstitialCount")
        
        // 日付が変わった場合はリセット
        if lastDate != today {
            UserDefaults.standard.set(today, forKey: "myCardInterstitialLastDate")
            UserDefaults.standard.set(0, forKey: "myCardInterstitialCount")
            return true
        }
        
        // 同じ日で2回未満の場合のみ表示可能
        return count < 2
    }
    
    private func incrementInterstitialAdCount() {
        let today = getTodayString()
        let lastDate = UserDefaults.standard.string(forKey: "myCardInterstitialLastDate") ?? ""
        let currentCount = UserDefaults.standard.integer(forKey: "myCardInterstitialCount")
        
        if lastDate == today {
            UserDefaults.standard.set(currentCount + 1, forKey: "myCardInterstitialCount")
        } else {
            UserDefaults.standard.set(today, forKey: "myCardInterstitialLastDate")
            UserDefaults.standard.set(1, forKey: "myCardInterstitialCount")
        }
    }
    
    private func getTodayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}

// MARK: - GADFullScreenContentDelegate
extension MyCardsInputViewController: FullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        // 広告が閉じられた後、次の広告を読み込む
        loadInterstitialAd()
        // 広告が閉じられた後にbottomSheetを閉じる
        dismiss(animated: true, completion: nil)
    }
    
    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Failed to present interstitial ad: \(error.localizedDescription)")
        // エラーが発生した場合も、次の広告を読み込む
        loadInterstitialAd()
        // エラーが発生した場合も、bottomSheetを閉じる
        dismiss(animated: true, completion: nil)
    }
}
