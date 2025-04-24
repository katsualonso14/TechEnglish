//メインページ
import UIKit

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Category"
        let scrollView = UIScrollView() // for scroll
        self.view.addSubview(scrollView)
        // First Button
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        //set layout
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: view.frame.height * 0.3).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle(NSLocalizedString("vocab_first_button_title", comment: ""), for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)

        button.setImage(UIImage(named: "vocab_first"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushButton), for: .touchUpInside)
        // Second Button Settting
        let secondButton:UIButton = UIButton()
        self.view.addSubview(secondButton)
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.backgroundColor = .systemBackground
        
        secondButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30).isActive = true
        secondButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        secondButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        secondButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        secondButton.layer.cornerRadius = 25.0
        secondButton.layer.masksToBounds = true
        
        secondButton.setTitle(NSLocalizedString("vocab_second_button_title", comment: ""), for: .normal)
        secondButton.setTitleColor(AppColors.textColor, for: .normal)
        secondButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        secondButton.setImage(UIImage(named: "vocab_second"), for: .normal)
        secondButton.contentHorizontalAlignment = .left
        secondButton.imageView?.contentMode = .scaleAspectFit
        secondButton.imageView?.layer.cornerRadius = 15.0
        secondButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        secondButton.addTarget(self, action: #selector(pushSecondButton), for: .touchUpInside)
        //    上級者ボタン
        let thirdButton:UIButton = UIButton()
        self.view.addSubview(thirdButton)
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.backgroundColor = .systemBackground
        
        thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 30).isActive = true
        thirdButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        thirdButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        thirdButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        thirdButton.layer.cornerRadius = 25.0
        thirdButton.layer.masksToBounds = true
        
        thirdButton.setTitle(NSLocalizedString("vocab_third_button_title", comment: ""), for: .normal)
        thirdButton.setTitleColor(AppColors.textColor, for: .normal)
        thirdButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        thirdButton.setImage(UIImage(named: "vocab_third"), for: .normal)
        thirdButton.contentHorizontalAlignment = .left
        thirdButton.imageView?.contentMode = .scaleAspectFit
        thirdButton.imageView?.layer.cornerRadius = 15.0
        thirdButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        thirdButton.addTarget(self, action: #selector(pushAThirdButton), for: .touchUpInside)
        
        setDeleteNotifButton()
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
    let vc = VocabFirstViewController(titleName: NSLocalizedString("frequent_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushSecondButton(sender: UIButton){
        let vc = VocabSecondViewController(titleName: NSLocalizedString("nomal_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushAThirdButton(sender: UIButton){
        let vc = VocabThirdViewController(titleName: NSLocalizedString("rare_button_title", comment: ""))
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

