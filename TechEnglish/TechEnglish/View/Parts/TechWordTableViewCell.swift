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
    private let containerView = UIView()
    
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
        button.addTarget(self, action: #selector(showBottomModal), for: .touchUpInside)
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
        
        self.backgroundColor = .systemGray6
        
        setupLayout()
        setupVerticalStack()
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
    
    func setupLayout() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = AppColors.backgroundColorCheckMode

         NSLayoutConstraint.activate([
             containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
             containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
             containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
         ])

         containerView.layer.cornerRadius = 12
         containerView.layer.shadowOpacity = 0.1
         containerView.layer.shadowRadius = 4
        
        // カードっぽくする
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true
        
        // 影をつける
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 6
        self.layer.masksToBounds = false
     }
    
    func setupVerticalStack() {
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
    
    //MARK: -Function
    @objc func showBottomModal() {
        let actionSheet = UIAlertController(
            title: NSLocalizedString("remind_bottom_sheet_title", comment: ""),
            message: NSLocalizedString("remind_bottom_sheet_message", comment: ""),
            preferredStyle: .actionSheet)
        // 1時間後設定
          actionSheet.addAction(
            UIAlertAction(title: NSLocalizedString("remind_bottom_sheet_1hour", comment: ""),style: .default, handler: { _ in
                self.firstVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
                self.secondVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
                self.thirdVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
                self.fourthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
                self.fifthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
                self.sixthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
                self.eighthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
                
                self.showRemindCompletedAlert()
          }))
        // 3時間後設定
          actionSheet.addAction(
            UIAlertAction(title: NSLocalizedString("remind_bottom_sheet_3hour", comment: ""), style: .default, handler: { _ in
                self.firstVC?.CustomCellTapButtonCall(cell: self, pushTime: 10800)
                self.secondVC?.CustomCellTapButtonCall(cell: self, pushTime: 10800)
                self.thirdVC?.CustomCellTapButtonCall(cell: self, pushTime: 10800)
                self.fourthVC?.CustomCellTapButtonCall(cell: self, pushTime: 10800)
                self.fifthVC?.CustomCellTapButtonCall(cell: self, pushTime: 10800)
                self.sixthVC?.CustomCellTapButtonCall(cell: self, pushTime: 10800)
                self.eighthVC?.CustomCellTapButtonCall(cell: self, pushTime: 10800)
                
                self.showRemindCompletedAlert()
          }))
        // 1日後設定
          actionSheet.addAction(
            UIAlertAction(title: NSLocalizedString("remind_bottom_sheet_1day", comment: ""), style: .default, handler: { _ in
                self.firstVC?.CustomCellTapButtonCall(cell: self, pushTime: 86400)
                self.secondVC?.CustomCellTapButtonCall(cell: self, pushTime: 86400)
                self.thirdVC?.CustomCellTapButtonCall(cell: self, pushTime: 86400)
                self.fourthVC?.CustomCellTapButtonCall(cell: self, pushTime: 86400)
                self.fifthVC?.CustomCellTapButtonCall(cell: self, pushTime: 86400)
                self.sixthVC?.CustomCellTapButtonCall(cell: self, pushTime: 86400)
                self.eighthVC?.CustomCellTapButtonCall(cell: self, pushTime: 86400)
                
                self.showRemindCompletedAlert()
          }))
          actionSheet.addAction(
            UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
          )
            if let viewController = self.window?.rootViewController {
                viewController.present(actionSheet, animated: true, completion: nil)
            }
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
    // リマインド設定完了のモーダルを表示
    func showRemindCompletedAlert() {
        let alert = UIAlertController(
            title: NSLocalizedString("remind_completed_title", comment: ""),
            message: NSLocalizedString("remind_completed_message", comment: ""),
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // モーダルを表示
        if let viewController = self.window?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }



}
