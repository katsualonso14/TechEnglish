//カスタムセル
import UIKit


class CustomTableViewCell: UITableViewCell {
    
    var firstVC: VocabFirstViewController?
    var secondVC: VocabSecondViewController?
    var thirdVC: VocabThirdViewController?
    var fourthVC: VocabFourthViewController?
    var fifthVC: VocabFifthViewController?
    var sixthVC: VocabSixthViewController?
    var seventhVC: VocabSeventhViewController?
    var eighthVC: VocabEighthViewController?
    
    var vocabularyList: VocabularyList?
    
    let sentenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let soundsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let japaneseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.blue
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heartButton = UIButton(type: .system)
    let heartButton2 = UIButton(type: .system)
    let heartButton3 = UIButton(type: .system)
    let heartButton4 = UIButton(type: .system)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(sentenceLabel)
        addSubview(soundsLabel)
        addSubview(japaneseLabel)
        //namelabelの配置
        sentenceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        sentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        soundsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true // 通知ボタンと被るので途中で折り返す
        sentenceLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        //soundsButtonの配置
        soundsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        soundsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true // 通知ボタンと被るので途中で折り返す
        soundsLabel.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
        //japaneseLabelの配置
        japaneseLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        japaneseLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        japaneseLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true // 通知ボタンと被るので途中で折り返す
        japaneseLabel.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
        
        setupHeartButton()
        setupHeartButton2()

    }
    //    初期化
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -Layout
    //　ハートボタンの設定
    func setupHeartButton(){
        //pushTriggerButton
        let buttonImage = UIImage(named: "heart")
        heartButton.setImage(buttonImage, for: .normal)
        heartButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        // 説明ラベルの設定
        let explainLabel = UILabel()
        explainLabel.text = "Remind in 1 hour"
        explainLabel.font = UIFont.systemFont(ofSize: 17)
        explainLabel.textColor = .lightGray
        explainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [heartButton, explainLabel])
        stackView.spacing = 10
        stackView.alignment = .leading // Set Start UI from HaertButton
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        // StackViewの制約を設定
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            explainLabel.leadingAnchor.constraint(equalTo: heartButton.trailingAnchor, constant: 10),
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -160),
            heartButton.widthAnchor.constraint(equalToConstant: 40),
            heartButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupHeartButton2(){
        let buttonImage = UIImage(named: "heart")
        heartButton2.setImage(buttonImage, for: .normal)
        heartButton2.addTarget(self, action: #selector(tapButton2), for: .touchUpInside)
        // 説明ラベルの設定
        let explainLabel = UILabel()
        explainLabel.text = "Remind in 1 day"
        explainLabel.font = UIFont.systemFont(ofSize: 17)
        explainLabel.textColor = .lightGray
        explainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [heartButton2, explainLabel])
        stackView.spacing = 10
        stackView.alignment = .leading // Set Start UI from HaertButton
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        // StackViewの制約を設定
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 130),
            explainLabel.leadingAnchor.constraint(equalTo: heartButton.trailingAnchor, constant: 10),
            heartButton2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -160),
            heartButton2.widthAnchor.constraint(equalToConstant: 40),
            heartButton2.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    
    func setCell(sentence: String, pronunciation: String , japanese: String) {
        sentenceLabel.text = sentence
        soundsLabel.text = pronunciation
        japaneseLabel.text = japanese
    }
    //MARK: -Function
    // Set notif time, when tap heartButton for 1 hour
    @objc private func tapButton() {
        firstVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        secondVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        thirdVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        fourthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        fifthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        sixthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        seventhVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        eighthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
    }
    
    // Set notif time, when tap heartButton2 for 1 day
    @objc private func tapButton2() {
        firstVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        secondVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        thirdVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        fourthVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        fifthVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        sixthVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        seventhVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        eighthVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
    }
    

}
