
import Foundation
import UIKit

class DescriptionView: UIView {
    let imageView = UIImageView()
    let button = UIButton(type: .system)
    let label = UILabel()
    let checkBoxLabel = UILabel()
    let descriptionCheckBox = UIImageView()
    let closeButton = UIButton()
    // QuickMemoかPhraseStoreかの判別フラグ
    var discriptNumber = 1
    // 説明ダイアログ次回以降非表示フラグ(UserDefaultsで管理)
    var isDescription: Bool {
        return UserDefaults.standard.bool(forKey: "isDescription")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 12
        setupView()
    }
    
    func setupView() {
        // 画像
//        imageView.contentMode = .scaleAspectFit
//        imageView.frame = CGRect(x: 20, y: 20, width: 250, height: 150)
//        addSubview(imageView)

        // 説明文
        label.frame = CGRect(x: 20, y: 20, width: 280, height: 20)
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        addSubview(label)
        
        // チェックボックスの説明
        checkBoxLabel.text = "アプリ起動時に説明を表示しない"
        checkBoxLabel.frame = CGRect(x: 5, y: 110, width: 250, height: 20)
        checkBoxLabel.font = UIFont.systemFont(ofSize: 15)
        checkBoxLabel.textColor = .systemGray
        addSubview(checkBoxLabel)
        
        // 起動時に説明ダイアログを表示するかどうかのチェックボックス
        descriptionCheckBox.frame = CGRect(x: 180, y: 110, width: 150, height: 30)
        descriptionCheckBox.contentMode = .scaleAspectFit
        descriptionCheckBox.isUserInteractionEnabled = true
        addSubview(descriptionCheckBox)
        
        //チェックボックスのアクション
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))
        descriptionCheckBox.addGestureRecognizer(gesture)

        // 画面切り替えボタン
        button.backgroundColor = AppColors.appMainColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(changePage), for: .touchUpInside)
        button.frame = CGRect(x: 20, y: 150, width: 250, height: 40)
        addSubview(button)
        
        //閉じるボタン
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .systemGray
        closeButton.frame = CGRect(x: 270, y: 0, width: 30, height: 30)
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        addSubview(closeButton)
        
        updateViewContent()
    }
    
    func updateViewContent() {
        //TODO: 画像の差し替え
//        imageView.image = discriptNumber == 1 ? UIImage(named: "Quick Memo Sample") :
//        discriptNumber == 2 ? UIImage(named: "Add PhraseStore from Quick Memo") : UIImage(named: "PhraseStore Sample")
        
        label.text = discriptNumber == 1 ?
        "「単語のタネ」では、日常で気になったり理解できない単語を簡単にメモすることができます。"
        : discriptNumber == 2 ? "単語のタネ」で保存した単語を元に、文章やシチュエーションをカスタム単語帳に保存することができます。" :
        "「カスタム単語帳」では、日常で気になった単語を文章やシチュエーションと共に保存して記憶に定着することをサポートします。"
        label.sizeToFit()
        
        button.setTitle(discriptNumber == 3 ? "Close" : "Next", for: .normal)
        
        updateCheckBox()
    }
    
    func updateCheckBox() {
        descriptionCheckBox.image = isDescription ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
    }
    
    @objc func changePage() {
        if discriptNumber == 1 {
            discriptNumber = 2
        } else if discriptNumber == 2 {
            discriptNumber = 3
        } else {
            self.removeFromSuperview()
        }
        updateViewContent()
    }
    // チェックボックスの状態を切り替え
    @objc func didTapCheckBox() {
        let newState = !UserDefaults.standard.bool(forKey: "isDescription")
        UserDefaults.standard.set(newState, forKey: "isDescription")
        updateCheckBox()
    }
    
    @objc func closeModal() {
        self.removeFromSuperview()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
