import UIKit
import FirebaseAnalytics

class QuizListViewController: UIViewController {
    
    let container = UIView()
    let scrollView = UIScrollView()
    let quizList = QuizListModel()

    let vocabButtons: [VocabButtonInfo] = [
        VocabButtonInfo(
            titleKey: "error_handling_quiz",
            subtitleKey: "quiz_greeting_button_subtitle",
            imageName: "exclamationmark.triangle",
            selector: #selector(pushErrorButton)
        ),
        VocabButtonInfo(
            titleKey: "document_quiz",
            subtitleKey: "quiz_pronoun_button_subtitle",
            imageName: "doc.text",
            selector: #selector(pushDocsButton)
        ),
        VocabButtonInfo(
            titleKey: "lifecycle_quiz",
            subtitleKey: "quiz_travel_button_subtitle",
            imageName: "arrow.triangle.2.circlepath",
            selector: #selector(pushLifecycleButton)
        ),
        VocabButtonInfo(
            titleKey:"core_words_quiz",
            subtitleKey: "quiz_core_words_button_subtitle",
            imageName: "book.closed",
            selector: #selector(pushCoreWordsButton)
        ),
        VocabButtonInfo(
            titleKey: "core_words_quiz2",
            subtitleKey: "quiz_core_words2_button_subtitle",
            imageName: "book.closed",
            selector: #selector(pushCoreWords2Button)
        ),
        VocabButtonInfo(
            titleKey: "core_words_quiz3",
            subtitleKey: "quiz_core_words3_button_subtitle",
            imageName: "book.closed",
            selector: #selector(pushCoreWords3Button)
        ),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("quiz_tab_button", comment: "")
        setupScrollView()
        setupContainer()
        setupVocabButtons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: "quiz_list"
        ])
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
        // contentSizeを設定
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 2400)
    }
    
    func setupContainer() {
        container.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 2400), // 全体の高さを設定
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
    }
    // MARK: - Vocab Buttons Setting
    func createVocabItemView(
        titleKey: String,
        imageName: String,
        topAnchor: NSLayoutYAxisAnchor,
        topConstant: CGFloat,
        selector: Selector
    ) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)

        let imageView = createImageView()
        view.addSubview(imageView)
        
        let titleLabel = createLabel(titleKey: titleKey)
        view.addSubview(titleLabel)
        
        let chevronButton = craeteChevronButton()
        view.addSubview(chevronButton)

        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        view.addGestureRecognizer(tapGesture)
        chevronButton.addTarget(self, action: selector, for: .touchUpInside)

        // レイアウト
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            view.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            view.widthAnchor.constraint(equalTo: view.superview!.widthAnchor, multiplier: 0.9),
            view.heightAnchor.constraint(equalToConstant: 110),

            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            chevronButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            chevronButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            chevronButton.widthAnchor.constraint(equalToConstant: 30),
        ])

        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = .label

        // ボタンの背景色と角丸
        view.backgroundColor = AppColors.backgroundColorCheckMode
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1 // 薄めで自然な影
        view.layer.shadowOffset = CGSize(width: 0, height: 2) // 下方向に落ちる影
        view.layer.shadowRadius = 4

        return view
    }

    // 各ボタン配置
    func setupVocabButtons() {
        var previousAnchor: NSLayoutYAxisAnchor = container.topAnchor
        var topPadding: CGFloat = view.frame.height * 0.05

        for buttonInfo in vocabButtons {
            let button = createVocabItemView(
                titleKey: buttonInfo.titleKey,
                imageName: buttonInfo.imageName,
                topAnchor: previousAnchor,
                topConstant: topPadding,
                selector: buttonInfo.selector
            )
            previousAnchor = button.bottomAnchor
            topPadding = 15 // 2個目以降は等間隔に
        }
    }
    // 共通のimageViewセットアップ
    func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func createLabel(titleKey: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = NSLocalizedString(titleKey, comment: "")
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        return titleLabel
    }
    
    func craeteChevronButton() -> UIButton {
        let chevronButton = UIButton(type: .system)
        chevronButton.translatesAutoresizingMaskIntoConstraints = false
        chevronButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        chevronButton.tintColor = AppColors.appMainColor
        return chevronButton
    }

    
// MARK: - objc
    @objc func pushErrorButton(sender: UIButton){
        Analytics.logEvent("start_quiz", parameters: ["quiz_name": "error_handling"])
        let vc = QuizViewController(
            questions: quizList.errorHandlingQuestions,
            navTitle: NSLocalizedString("error_handling_quiz", comment: "")
        )
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushDocsButton(sender: UIButton){
        Analytics.logEvent("start_quiz", parameters: ["quiz_name": "document"])
        let vc = QuizViewController(
            questions: quizList.docsWordQuestions,
            navTitle: NSLocalizedString("document_quiz", comment: "")
        )
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushLifecycleButton(sender: UIButton){
        Analytics.logEvent("start_quiz", parameters: ["quiz_name": "lifecycle"])
        let vc = QuizViewController(
            questions: quizList.docsWordQuestions,
            navTitle: NSLocalizedString("lifecycle_quiz", comment: "")
        )
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushCoreWordsButton(sender: UIButton){
        Analytics.logEvent("start_quiz", parameters: ["quiz_name": "core_words_1"])
        let vc = QuizViewController(
            questions: quizList.coreWordsQuestions,
            navTitle: NSLocalizedString("core_words_quiz", comment: "")
        )
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushCoreWords2Button(sender: UIButton){
        Analytics.logEvent("start_quiz", parameters: ["quiz_name": "core_words_2"])
        let vc = QuizViewController(
            questions: quizList.coreWordsQuestions2,
            navTitle: NSLocalizedString("core_words_quiz2", comment: "")
        )
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushCoreWords3Button(sender: UIButton){
        Analytics.logEvent("start_quiz", parameters: ["quiz_name": "core_words_3"])
        let vc = QuizViewController(
            questions: quizList.coreWordsQuestions3,
            navTitle: NSLocalizedString("core_words_quiz3", comment: "")
        )
        navigationController?.pushViewController(vc, animated: true)
    }

    //大きい画像などのメモリ解放
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

