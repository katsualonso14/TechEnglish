import UIKit

class CategoryViewController: UIViewController {
    let container = UIView()
    let scrollView = UIScrollView()
    let vocabButtons: [VocabButtonInfo] = [
        VocabButtonInfo(titleKey: "vocab_first_button_title", imageName: "error_image", selector: #selector(pushFirstButton)),
        VocabButtonInfo(titleKey: "vocab_second_button_title", imageName: "data_image", selector: #selector(pushSecondButton)),
        VocabButtonInfo(titleKey: "vocab_third_button_title", imageName: "lifecycle_image", selector: #selector(pushThirdButton)),
        VocabButtonInfo(titleKey: "vocab_fourth_button_title", imageName: "settings_image", selector: #selector(pushFourthButton)),
        VocabButtonInfo(titleKey: "vocab_fifth_button_title", imageName: "coding_test_image", selector: #selector(pushFifthButton)),
        VocabButtonInfo(titleKey: "vocab_sixth_button_title", imageName: "others_image", selector: #selector(pushSixthButton)),
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Category"
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
            container.heightAnchor.constraint(equalToConstant: 2400), // 全体の高さを設定
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
    func createVocabButton(
        titleKey: String,
        imageName: String,
        topAnchor: NSLayoutYAxisAnchor,
        topConstant: CGFloat,
        selector: Selector
    ) -> UIButton {
        let button = createBaseButton()
        let label = createBaseLabel()
        let imageView = createImageView()

        container.addSubview(button)
        container.addSubview(label)
        button.addSubview(imageView)

        label.text = NSLocalizedString(titleKey, comment: "")
        if !imageName.isEmpty {
            imageView.image = UIImage(named: imageName)
        }

        NSLayoutConstraint.activate([
            // ボタン本体
            button.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            button.heightAnchor.constraint(equalTo: button.widthAnchor),

            // タイトル（ボタンの上に配置）
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -7),
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),

            // 画像（ボタン内に配置）
            imageView.topAnchor.constraint(equalTo: button.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: button.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: button.heightAnchor),
        ])

        button.addTarget(self, action: selector, for: .touchUpInside)

        return button
    }
    // 各ボタン配置
    func setupVocabButtons() {
        var previousAnchor: NSLayoutYAxisAnchor = container.topAnchor
        var topPadding: CGFloat = view.frame.height * 0.1

        for buttonInfo in vocabButtons {
            let button = createVocabButton(
                titleKey: buttonInfo.titleKey,
                imageName: buttonInfo.imageName,
                topAnchor: previousAnchor,
                topConstant: topPadding,
                selector: buttonInfo.selector
            )
            previousAnchor = button.bottomAnchor
            topPadding = 50 // 2個目以降は等間隔に
        }
    }

    // 共通のUIButtonセットアップ
    func createBaseButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        return button
    }
    // 共通のラベルセットアップ
    func createBaseLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppColors.textColor
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }
    // 共通のimageViewセットアップ
    func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        return imageView
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
        let vc = VocabEighthViewController(titleName: NSLocalizedString("vocab_eighth_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func setDiscrptionView() {
        let explanationView = DescriptionView(frame: CGRect(x: 50, y: 170, width: 330, height: 350))
        explanationView.center = view.center
        view.addSubview(explanationView)
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
    func checkIsDescription() {
        if !UserDefaults.standard.bool(forKey: "isDescription") {
            setDiscrptionView()
        }
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

