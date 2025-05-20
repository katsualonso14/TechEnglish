import UIKit

class VocabErrorViewController: UIViewController {
    let container = UIView()
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Error&Exception"
        setupScrollView()
        setupContainer()
        setupVocabButtons()
    }
    // MARK - Layout Setting
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
            container.heightAnchor.constraint(equalToConstant: 1200), // 全体の高さを設定
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
    }
    
    // MARK: - Vocab Buttons Setting
    func createVocabItemView(
        titleKey: String,
        subtitleKey: String,
        imageName: String,
        topAnchor: NSLayoutYAxisAnchor,
        topConstant: CGFloat,
        selector: Selector
    ) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        
        let labelStack = createLabelStack(titleKey: titleKey, subtitleKey: subtitleKey)
        view.addSubview(labelStack)

        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        view.addGestureRecognizer(tapGesture)

        // レイアウト
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            view.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            view.widthAnchor.constraint(equalTo: view.superview!.widthAnchor, multiplier: 0.9),
            view.heightAnchor.constraint(equalToConstant: 110),

            labelStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            labelStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

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
                subtitleKey: buttonInfo.subtitleKey,
                imageName: buttonInfo.imageName,
                topAnchor: previousAnchor,
                topConstant: topPadding,
                selector: buttonInfo.selector
            )
            previousAnchor = button.bottomAnchor
            topPadding = 15 // 2個目以降は等間隔に
        }
    }

    // 共通のlabelStackセットアップ
    func createLabelStack(titleKey: String, subtitleKey: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = NSLocalizedString(titleKey, comment: "")
        titleLabel.font = .boldSystemFont(ofSize: 22)

        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = NSLocalizedString(subtitleKey, comment: "")
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 0

        let labelStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 4
        labelStack.translatesAutoresizingMaskIntoConstraints = false

        return labelStack
    }

    //大きい画像などのメモリ解放
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

