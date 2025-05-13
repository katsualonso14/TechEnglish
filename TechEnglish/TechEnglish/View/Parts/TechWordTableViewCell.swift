//カスタムセル
import UIKit


class TechWordTableViewCell: UITableViewCell {
    
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
    
    let meaningLabel: UILabel = {
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

        let verticalStack = UIStackView(arrangedSubviews: [sentenceLabel, soundsLabel, meaningLabel, exampleSentenceLabel])
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
    func setCell(sentence: String, pronunciation: String, meaning: String, exampleSentence: String) {
        sentenceLabel.text = sentence
        soundsLabel.text = pronunciation
        meaningLabel.text = meaning
        exampleSentenceLabel.text = exampleSentence
    }
    //MARK: -Function
    @objc private func didTapReviewButton() {
        print("Review button tapped")
    }
    
    // キーワードの文字色可変
    func highlightKeyword(in sentence: String, keyword: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: sentence)
        
        // 複数キーワードに対応（例: "index/indices" → ["index", "indices"]）
        let keywordOptions = keyword.components(separatedBy: "/")
        
        for word in keywordOptions {
            // 大文字小文字を無視して検索
            let lowercaseSentence = sentence.lowercased()
            let lowercaseWord = word.lowercased()
            
            var searchRange = lowercaseSentence.startIndex..<lowercaseSentence.endIndex
            
            while let range = lowercaseSentence.range(of: lowercaseWord, options: [], range: searchRange) {
                // 実際の位置をNSRangeで取得
                let nsRange = NSRange(range, in: sentence)
                attributed.addAttribute(.foregroundColor, value: UIColor(red: 44/255, green: 92/255, blue: 144/255, alpha: 1), range: nsRange)
                attributed.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: nsRange)
                
                // 検索位置を更新
                searchRange = range.upperBound..<lowercaseSentence.endIndex
            }
        }
        
        return attributed
    }




}
