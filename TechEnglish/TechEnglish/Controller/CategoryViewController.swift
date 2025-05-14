import UIKit

class CategoryViewController: UIViewController {
    let container = UIView()
    let scrollView = UIScrollView()
    let vocabButtons: [VocabButtonInfo] = [
        VocabButtonInfo(titleKey: "vocab_first_button_title", subtitleKey: "vocab_first_button_subtitle", imageName: "exclamationmark.triangle", selector: #selector(pushFirstButton)),
        VocabButtonInfo(titleKey: "vocab_sixth_button_title", subtitleKey: "vocab_sixth_button_subtitle", imageName: "doc.text", selector: #selector(pushSixthButton)),
        VocabButtonInfo(titleKey: "vocab_second_button_title", subtitleKey: "vocab_second_button_subtitle", imageName: "cube.box", selector: #selector(pushSecondButton)),
        VocabButtonInfo(titleKey: "vocab_third_button_title", subtitleKey: "vocab_third_button_subtitle", imageName: "arrow.triangle.2.circlepath", selector: #selector(pushThirdButton)),
        VocabButtonInfo(titleKey: "vocab_fourth_button_title", subtitleKey: "vocab_fourth_button_subtitle", imageName: "gearshape", selector: #selector(pushFourthButton)),
        VocabButtonInfo(titleKey: "vocab_fifth_button_title", subtitleKey: "vocab_fifth_button_subtitle", imageName: "chevron.left.forwardslash.chevron.right", selector: #selector(pushFifthButton)),
        VocabButtonInfo(titleKey: "vocab_eighth_button_title", subtitleKey: "vocab_eighth_button_subtitle", imageName: "ellipsis", selector: #selector(pushEighthButton)),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tech Words"
        setupScrollView()
        setupContainer()
        setupVocabButtons()
        setDeleteNotifButton()
        setDescriptionButton()
        checkIsDescription()
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
    
    func setDescriptionButton() {
        let descriptionButton = UIButton(type: .system)
        descriptionButton.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        descriptionButton.tintColor = AppColors.appMainColor
        descriptionButton.addTarget(self, action: #selector(setDiscrptionView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: descriptionButton)
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

        let imageView = createImageView()
        view.addSubview(imageView)
        
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

            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),

            labelStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            labelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            labelStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
    // 共通のimageViewセットアップ
    func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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


    
    func setDeleteNotifButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell.circle"), for: .normal)
        button.tintColor = AppColors.appMainColor
        button.addTarget(self, action: #selector(openAllNotifDeleteAleart), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
    }
    
    //MARK: -objc
    // Push Buttons Setting
    @objc func pushFirstButton(sender: UIButton){
    let vc = VocabFirstViewController(titleName: NSLocalizedString("vocab_first_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushSecondButton(sender: UIButton){
        let vc = VocabSecondViewController(titleName: NSLocalizedString("vocab_second_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushThirdButton(sender: UIButton){
        let vc = VocabThirdViewController(titleName: NSLocalizedString("vocab_third_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushFourthButton(sender: UIButton){
        let vc = VocabFourthViewController(titleName: NSLocalizedString("vocab_fourth_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushFifthButton(sender: UIButton){
        let vc = VocabFifthViewController(titleName: NSLocalizedString("vocab_fifth_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushSixthButton(sender: UIButton){
        let vc = VocabSixthViewController(titleName: NSLocalizedString("vocab_sixth_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushEighthButton(sender: UIButton){
        let vc = VocabEighthViewController(titleName: NSLocalizedString("vocab_eighth_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func setDiscrptionView() {
        let vc = DescriptionViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    // 全てのリマインドを削除
    @objc func openAllNotifDeleteAleart(){
        let alert = UIAlertController(title: NSLocalizedString("delete_all_notif_title", comment: ""),
                                      message: NSLocalizedString("delete_all_notif_message", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in
          deleteAllNotif()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    // MARK - Helper
    // 説明画面表示判定
    func checkIsDescription() {
        let isDescriptionShown = UserDefaults.standard.bool(forKey: "isDescription")
        // 通知用の説明表示出しわけフラグ
        let launchedFromNotification = UserDefaults.standard.bool(forKey: "launchedFromNotification")

        if !isDescriptionShown && !launchedFromNotification {
            setDiscrptionView()
        }

        // 通知から遷移した場合は一時的にフラグをリセット
        UserDefaults.standard.set(false, forKey: "launchedFromNotification")
    }

    //全ての通知を削除する処理
    func deleteAllNotif() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        //全ての通知を削除しましたのダイアログ表示
        let alert = UIAlertController(
            title: NSLocalizedString("delete_all_notif_finish_title", comment: ""),
            message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //大きい画像などのメモリ解放
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

