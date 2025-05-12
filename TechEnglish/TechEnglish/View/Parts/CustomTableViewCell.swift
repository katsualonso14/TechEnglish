//カスタムセル
import UIKit


class CustomTableViewCell: UITableViewCell {
    
    var firstVC: VocabFirstViewController?
    var secondVC: VocabSecondViewController?
    var thirdVC: VocabThirdViewController?
    var fourthVC: VocabFourthViewController?
    var fifthVC: VocabFifthViewController?
    var sixthVC: VocabSixthViewController?
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
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        button.tintColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapReviewButton), for: .touchUpInside)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        let verticalStack = UIStackView(arrangedSubviews: [sentenceLabel, soundsLabel, japaneseLabel, exampleSentenceLabel])
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(verticalStack)
        contentView.addSubview(reviewButton)

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),

            reviewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            reviewButton.centerYAnchor.constraint(equalTo: verticalStack.centerYAnchor)
        ])

    }

    //    初期化
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -Layout
    func setCell(sentence: String, pronunciation: String, japanese: String, exampleSentence: String) {
        sentenceLabel.text = sentence
        soundsLabel.text = pronunciation
        japaneseLabel.text = japanese
        exampleSentenceLabel.text = exampleSentence
    }
    //MARK: -Function
    @objc private func didTapReviewButton() {
        print("Review button tapped")
    }
    
    // Set highlighted text
    func highlightKeyword(in sentence: String, keyword: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: sentence)
        let range = (sentence as NSString).range(of: keyword)
        if range.location != NSNotFound {
            attributed.addAttribute(.foregroundColor, value: UIColor(red: 44/255, green: 92/255, blue: 144/255, alpha: 1), range: range)
            attributed.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: range)
        }
        return attributed
    }




}
