//メインページ
import UIKit

class CategoryViewController: UIViewController {
    
    let container = UIView()
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Category"
        
        setupScrollView()
        setupContainer()
        // Vocabulary Buttons Settings
        let firstButton = setupFirstButton()
        let secondButton = setupSecondButton(below: firstButton)
        let thirdButton = setupThirdButton(below: secondButton)
        let fourthButton = setupFourthButton(below: thirdButton)
        let fifthButton = setupFifthButton(below: fourthButton)
        let sixthButton = setupSixthButton(below: fifthButton)
        let seventhButton = setupSeventhButton(below: sixthButton)
        let eighthButton = setupEighthButton(below: seventhButton)

        setDeleteNotifButton()
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
    // MARK: Vocab Buttons Setting
    func setupFirstButton() -> UIButton {
        let button = createBaseButton()
        container.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: container.topAnchor, constant: view.frame.height * 0.03),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])

        button.setTitle(NSLocalizedString("vocab_first_button_title", comment: ""), for: .normal)
        button.setImage(UIImage(named: "vocab_first"), for: .normal)
        button.addTarget(self, action: #selector(pushButton), for: .touchUpInside)

        return button
    }

    func setupSecondButton(below anchorView: UIView) -> UIButton {
        let button = createBaseButton()
        container.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])

        button.setTitle(NSLocalizedString("vocab_second_button_title", comment: ""), for: .normal)
        button.setImage(UIImage(named: "vocab_second"), for: .normal)
        button.addTarget(self, action: #selector(pushSecondButton), for: .touchUpInside)

        return button
    }

    func setupThirdButton(below anchorView: UIView) -> UIButton {
        let button = createBaseButton()
        container.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])

        button.setTitle(NSLocalizedString("vocab_third_button_title", comment: ""), for: .normal)
        button.setImage(UIImage(named: "vocab_third"), for: .normal)
        button.addTarget(self, action: #selector(pushAThirdButton), for: .touchUpInside)

        return button
    }

    func setupFourthButton(below anchorView: UIView) -> UIButton {
        let button = createBaseButton()
        container.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])

        button.setTitle(NSLocalizedString("vocab_fourth_button_title", comment: ""), for: .normal)
        button.setImage(UIImage(named: "settings_image"), for: .normal)
        button.addTarget(self, action: #selector(pushFourthButton), for: .touchUpInside)

        return button
    }

    func setupFifthButton(below anchorView: UIView) -> UIButton {
        let button = createBaseButton()
        container.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])

        button.setTitle(NSLocalizedString("vocab_fifth_button_title", comment: ""), for: .normal)
        button.setImage(UIImage(named: "expression_image"), for: .normal)
        button.addTarget(self, action: #selector(pushFifthButton), for: .touchUpInside)

        return button
    }

    func setupSixthButton(below anchorView: UIView) -> UIButton {
        let button = createBaseButton()
        container.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])

        button.setTitle(NSLocalizedString("vocab_sixth_button_title", comment: ""), for: .normal)
        button.setImage(UIImage(named: "functions_image"), for: .normal)
        button.addTarget(self, action: #selector(pushSixthButton), for: .touchUpInside)

        return button
    }

    func setupSeventhButton(below anchorView: UIView) -> UIButton {
        let button = createBaseButton()
        container.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])

        button.setTitle(NSLocalizedString("vocab_seventh_button_title", comment: ""), for: .normal)
        button.setImage(UIImage(named: "relation_image"), for: .normal)
        button.addTarget(self, action: #selector(pushSeventhButton), for: .touchUpInside)

        return button
    }

    func setupEighthButton(below anchorView: UIView) -> UIButton {
        let button = createBaseButton()
        container.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])

        button.setTitle(NSLocalizedString("vocab_eighth_button_title", comment: ""), for: .normal)
        button.setImage(UIImage(named: "others_image"), for: .normal)
        button.addTarget(self, action: #selector(pushEighthButton), for: .touchUpInside)

        return button
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
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        return button
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
    @objc func pushButton(sender: UIButton){
    let vc = VocabFirstViewController(titleName: NSLocalizedString("vocab_first_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushSecondButton(sender: UIButton){
        let vc = VocabSecondViewController(titleName: NSLocalizedString("vocab_second_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushAThirdButton(sender: UIButton){
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
    
    @objc func pushSeventhButton(sender: UIButton){
        let vc = VocabSeventhViewController(titleName: NSLocalizedString("vocab_seventh_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushEighthButton(sender: UIButton){
        let vc = VocabEighthViewController(titleName: NSLocalizedString("vocab_eighth_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
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

