// MARK: - Tech Word Table View Cell
// Terminal-style cell for vocabulary display

import UIKit

class TechWordTableViewCell: UITableViewCell {
    
    // MARK: - View Controller References
    
    var firstVC: VocabFirstViewController?
    var secondVC: VocabSecondViewController?
    var thirdVC: VocabThirdViewController?
    var fourthVC: VocabFourthViewController?
    var fifthVC: VocabFifthViewController?
    var sixthVC: VocabSixthViewController?
    var eighthVC: VocabEighthViewController?
    
    var vocabularyList: VocabularyList?
    
    // MARK: - UI Elements
    
    private let containerView = UIView()
    private let lineNumberLabel = UILabel()
    private let separatorLine = UIView()
    private let gutterView = UIView()
    
    let sentenceLabel: UILabel = {
        let label = UILabel()
        label.font = EditorFonts.monoBold(size: EditorFonts.Size.subheadline)
        label.textColor = EditorTheme.type
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let soundsLabel: UILabel = {
        let label = UILabel()
        label.font = EditorFonts.mono(size: EditorFonts.Size.body)
        label.textColor = EditorTheme.comment
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let meaningLabel: UILabel = {
        let label = UILabel()
        label.font = EditorFonts.mono(size: EditorFonts.Size.body)
        label.textColor = EditorTheme.string
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let exampleSentenceLabel: UILabel = {
        let label = UILabel()
        label.font = EditorFonts.mono(size: EditorFonts.Size.body)
        label.textColor = EditorTheme.textDefault
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "clock.arrow.circlepath"), for: .normal)
        button.tintColor = EditorTheme.accentPrimary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showBottomModal), for: .touchUpInside)
        return button
    }()
    
    private var lineNumber: Int = 1
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        updateSelectionState(selected)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            containerView.backgroundColor = EditorTheme.lineHighlight
        } else if !isSelected {
            containerView.backgroundColor = EditorTheme.editorBackground
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = EditorTheme.editorBackground
        self.selectionStyle = .none
        
        setupLayout()
        setupContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setCell(sentence: String, pronunciation: String, meaning: String, exampleSentence: String) {
        sentenceLabel.text = sentence
        soundsLabel.text = "// \(pronunciation)"
        meaningLabel.text = "→ \(meaning)"
        exampleSentenceLabel.attributedText = highlightKeyword(in: exampleSentence, keyword: sentence)
    }
    
    func setLineNumber(_ number: Int) {
        lineNumber = number
        lineNumberLabel.text = String(format: "%3d", number)
    }
    
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = EditorTheme.editorBackground

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        gutterView.backgroundColor = EditorTheme.sidebarBackground
        gutterView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(gutterView)
        
        lineNumberLabel.font = EditorFonts.lineNumber
        lineNumberLabel.textColor = EditorTheme.lineNumber
        lineNumberLabel.textAlignment = .right
        lineNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        gutterView.addSubview(lineNumberLabel)
        
        separatorLine.backgroundColor = EditorTheme.border
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            gutterView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            gutterView.topAnchor.constraint(equalTo: containerView.topAnchor),
            gutterView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            gutterView.widthAnchor.constraint(equalToConstant: 44),
            
            lineNumberLabel.trailingAnchor.constraint(equalTo: gutterView.trailingAnchor, constant: -8),
            lineNumberLabel.topAnchor.constraint(equalTo: gutterView.topAnchor, constant: 12),
            
            separatorLine.leadingAnchor.constraint(equalTo: gutterView.trailingAnchor),
            separatorLine.topAnchor.constraint(equalTo: containerView.topAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            separatorLine.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupContent() {
        let verticalStack = UIStackView(arrangedSubviews: [sentenceLabel, soundsLabel, meaningLabel, exampleSentenceLabel])
        verticalStack.axis = .vertical
        verticalStack.spacing = 6
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(verticalStack)
        containerView.addSubview(reviewButton)

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            verticalStack.leadingAnchor.constraint(equalTo: separatorLine.trailingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: reviewButton.leadingAnchor, constant: -12),
            verticalStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),

            reviewButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            reviewButton.centerYAnchor.constraint(equalTo: verticalStack.centerYAnchor),
            reviewButton.widthAnchor.constraint(equalToConstant: 32),
            reviewButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = EditorTheme.border
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(bottomBorder)
        
        NSLayoutConstraint.activate([
            bottomBorder.leadingAnchor.constraint(equalTo: separatorLine.trailingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func updateSelectionState(_ selected: Bool) {
        if selected {
            containerView.backgroundColor = EditorTheme.selectionBackground
            gutterView.backgroundColor = EditorTheme.lineHighlight
        } else {
            containerView.backgroundColor = EditorTheme.editorBackground
            gutterView.backgroundColor = EditorTheme.sidebarBackground
        }
    }
    
    // MARK: - Actions
    
    @objc func showBottomModal() {
        let actionSheet = UIAlertController(
            title: "// \(NSLocalizedString("remind_bottom_sheet_title", comment: ""))",
            message: NSLocalizedString("remind_bottom_sheet_message", comment: ""),
            preferredStyle: .actionSheet
        )
        
        actionSheet.overrideUserInterfaceStyle = .dark
        actionSheet.view.tintColor = EditorTheme.accentPrimary
        
        actionSheet.addAction(
            UIAlertAction(title: "setTimeout(() => remind(), 3600)", style: .default, handler: { _ in
                self.scheduleReminder(pushTime: 3600)
            })
        )
        
        actionSheet.addAction(
            UIAlertAction(title: "setTimeout(() => remind(), 10800)", style: .default, handler: { _ in
                self.scheduleReminder(pushTime: 10800)
            })
        )
        
        actionSheet.addAction(
            UIAlertAction(title: "setTimeout(() => remind(), 86400)", style: .default, handler: { _ in
                self.scheduleReminder(pushTime: 86400)
            })
        )
        
        let cancelAction = UIAlertAction(title: "// Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        if let viewController = self.window?.rootViewController {
            viewController.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    private func scheduleReminder(pushTime: Int) {
        firstVC?.CustomCellTapButtonCall(cell: self, pushTime: TimeInterval(pushTime))
        secondVC?.CustomCellTapButtonCall(cell: self, pushTime: TimeInterval(pushTime))
        thirdVC?.CustomCellTapButtonCall(cell: self, pushTime: TimeInterval(pushTime))
        fourthVC?.CustomCellTapButtonCall(cell: self, pushTime: TimeInterval(pushTime))
        fifthVC?.CustomCellTapButtonCall(cell: self, pushTime: TimeInterval(pushTime))
        sixthVC?.CustomCellTapButtonCall(cell: self, pushTime: TimeInterval(pushTime))
        eighthVC?.CustomCellTapButtonCall(cell: self, pushTime: TimeInterval(pushTime))
        
        showRemindCompletedAlert()
    }
    
    // MARK: - Text Highlighting
    
    func highlightKeyword(in sentence: String, keyword: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: sentence, attributes: [
            .font: EditorFonts.mono(size: EditorFonts.Size.body),
            .foregroundColor: EditorTheme.textDefault
        ])
        
        let keywordOptions = keyword.components(separatedBy: "/")
        
        for word in keywordOptions {
            let lowercaseSentence = sentence.lowercased()
            let lowercaseWord = word.lowercased()
            
            var searchRange = lowercaseSentence.startIndex..<lowercaseSentence.endIndex
            
            while let range = lowercaseSentence.range(of: lowercaseWord, options: [], range: searchRange) {
                let nsRange = NSRange(range, in: sentence)
                attributed.addAttribute(.foregroundColor, value: EditorTheme.type, range: nsRange)
                attributed.addAttribute(.font, value: EditorFonts.monoBold(size: EditorFonts.Size.body), range: nsRange)
                attributed.addAttribute(.backgroundColor, value: EditorTheme.selectionBackground, range: nsRange)
                
                searchRange = range.upperBound..<lowercaseSentence.endIndex
            }
        }
        
        return attributed
    }
    
    // MARK: - Alerts
    
    func showRemindCompletedAlert() {
        let alert = UIAlertController(
            title: "✓ Scheduled",
            message: "// \(NSLocalizedString("remind_completed_message", comment: ""))",
            preferredStyle: .alert
        )
        
        alert.overrideUserInterfaceStyle = .dark
        alert.view.tintColor = EditorTheme.accentSuccess
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let viewController = self.window?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
