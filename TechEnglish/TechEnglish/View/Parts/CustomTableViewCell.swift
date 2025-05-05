//カスタムセル
import UIKit


class CustomTableViewCell: UITableViewCell {
    
    var firstVC: VocabFirstViewController?
    var secondVC: VocabSecondViewController?
    var thirdVC: VocabThirdViewController?
    var fourthVC: VocabFourthViewController?
    var fifthVC: VocabFifthViewController?
    var eighthVC: VocabEighthViewController?
    
    var vocabularyList: VocabularyList?
    
    let sentenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = AppColors.textColor
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
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let exampleSentenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 44/255, green: 92/255, blue: 144/255, alpha: 1)
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
        addSubview(exampleSentenceLabel)
        //namelabelの配置
        sentenceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        sentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100).isActive = true
        soundsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true // 通知ボタンと被るので途中で折り返す
        //soundsButtonの配置
        soundsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        soundsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        soundsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true // 通知ボタンと被るので途中で折り返す
        //japaneseLabelの配置
        japaneseLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        japaneseLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -13).isActive = true
        japaneseLabel.widthAnchor.constraint(equalToConstant: self.frame.width * 0.6).isActive = true // 通知ボタンと被るので途中で折り返す
        // exampleSentenceLabelの配置
        exampleSentenceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        exampleSentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 60).isActive = true
        exampleSentenceLabel.widthAnchor.constraint(equalToConstant: self.frame.width * 0.6).isActive = true // 通知ボタンと被るので途中で折り返す
        
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
        explainLabel.numberOfLines = 0
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
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.width * 0.6),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            stackView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            explainLabel.leadingAnchor.constraint(equalTo: heartButton.trailingAnchor, constant: 10),
            heartButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: contentView.frame.width * 0.15),
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
        explainLabel.numberOfLines = 0
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
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.width * 0.6),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            stackView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 130),
            explainLabel.leadingAnchor.constraint(equalTo: heartButton2.trailingAnchor, constant: 10),
            heartButton2.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: contentView.frame.width * 0.15),
            heartButton2.widthAnchor.constraint(equalToConstant: 40),
            heartButton2.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    
    func setCell(sentence: String, pronunciation: String, japanese: String, exampleSentence: String) {
        sentenceLabel.text = sentence
        soundsLabel.text = pronunciation
        japaneseLabel.text = japanese
        exampleSentenceLabel.text = exampleSentence
    }
    //MARK: -Function
    // Set notif time, when tap heartButton for 1 hour
    @objc private func tapButton() {
        firstVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        secondVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        thirdVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        fourthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        fifthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        eighthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
    }
    
    // Set notif time, when tap heartButton2 for 1 day
    @objc private func tapButton2() {
        firstVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        secondVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        thirdVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        fourthVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        fifthVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
        eighthVC?.CustomCellTapButtonCall2(cell: self, pushTime: 86400)
    }
    

}
