import UIKit
import GoogleMobileAds

class QuizViewController: UIViewController {
    let questionLabel = UILabel()
    let buttons: [UIButton] = (0..<4).map { _ in UIButton(type: .system) }
    typealias Quiz = (question: String, choices: [String], correctIndex: Int, explanation: String)
    var questions: [Quiz] = []
    var currentQuestionIndex = 0
    var navTitle = ""
    
    // MARK: - Interstitial Ad
    private var interstitialAd: InterstitialAd?
    
    // MARK: - Initializer
    init(questions: [Quiz], navTitle: String) {
        self.questions = questions
        self.navTitle = navTitle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        showQuestion()
        setupResetButton()
        loadInterstitialAd()
    }

    // MARK: - Setup UI
    func setupViews() {
        questionLabel.font = UIFont.boldSystemFont(ofSize: 24)
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center

        view.addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // カードのUI設定
        let row1 = UIStackView(arrangedSubviews: [buttons[0], buttons[1]])
        let row2 = UIStackView(arrangedSubviews: [buttons[2], buttons[3]])

        [row1, row2].forEach { row in
            row.axis = .horizontal
            row.spacing = 16
            row.distribution = .fillEqually
        }

        let gridStack = UIStackView(arrangedSubviews: [row1, row2])
        gridStack.axis = .vertical
        gridStack.spacing = 16
        gridStack.distribution = .fillEqually

        view.addSubview(gridStack)
        gridStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gridStack.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            gridStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            gridStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            gridStack.heightAnchor.constraint(equalToConstant: 250)
        ])


        for (i, button) in buttons.enumerated() {
            button.tag = i
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = AppColors.appMainColor
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        }

    }
    
    // MARK: - Reset Button
    func setupResetButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("quiz_reset", comment: ""),
            style: .plain,
            target: self,
            action: #selector(resetQuiz)
        )
        navigationItem.rightBarButtonItem?.tintColor = AppColors.appMainColor
    }

    // MARK: - Show Question
    func showQuestion() {
        guard currentQuestionIndex < questions.count else {
            questionLabel.text = "Quiz Completed!"
            buttons.forEach { $0.isHidden = true }
            return
        }

        let current = questions[currentQuestionIndex]
        questionLabel.text = current.question
        for (i, choice) in current.choices.enumerated() {
            buttons[i].setTitle(choice, for: .normal)
            buttons[i].isHidden = false
        }
    }

    // MARK: - Handle Answer
    @objc func answerTapped(_ sender: UIButton) {
        let correctIndex = questions[currentQuestionIndex].correctIndex
        let isCorrect = sender.tag == correctIndex
        
        let resultVC = AnswerResultViewController()
        resultVC.isCorrect = isCorrect
        resultVC.correctAnswer = questions[currentQuestionIndex].choices[correctIndex]
        resultVC.nextHandler = {
            self.currentQuestionIndex += 1
            
            // 5問終了時にインターステシャル広告を表示
            if self.currentQuestionIndex == 5 {
                self.showInterstitialAdIfAvailable()
            }
            
            self.showQuestion()
        }
        
        // iOS 15+ only
        if let sheet = resultVC.sheetPresentationController {
            sheet.detents = [
                .custom(identifier: .init("oneThird")) { context in
                    return context.maximumDetentValue * 0.3
                }
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        resultVC.modalPresentationStyle = .pageSheet
        present(resultVC, animated: true)
    }

    
    // Quize Reset
    @objc func resetQuiz() {
        currentQuestionIndex = 0
        showQuestion()
    }
    
    // MARK: - Interstitial Ad
    func loadInterstitialAd() {
        let request = Request()
        InterstitialAd.load(with: MyAds.interstitialID, request: request) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load interstitial ad: \(error.localizedDescription)")
                return
            }
            self.interstitialAd = ad
            self.interstitialAd?.fullScreenContentDelegate = self
        }
    }
    
    func showInterstitialAdIfAvailable() {
        guard let interstitialAd = interstitialAd else {
            // 広告が読み込まれていない場合は、次の広告を読み込む
            loadInterstitialAd()
            return
        }
        
        interstitialAd.present(from: self)
    }

}

// MARK: - GADFullScreenContentDelegate
extension QuizViewController: FullScreenContentDelegate {
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
