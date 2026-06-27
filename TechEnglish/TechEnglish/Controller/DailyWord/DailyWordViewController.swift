import UIKit

class DailyWordViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let containerView = UIView()
    private let headerView = UIView()
    private let tabIndicator = UIView()
    private let fileIconView = UIImageView()
    private let fileNameLabel = UILabel()
    private let codeBlockView = UIView()
    private let lineNumberStack = UIStackView()
    private let codeContentStack = UIStackView()
    private let closeButton = EditorButton()
    private let statusBar = UIView()
    private let statusLabel = UILabel()
    
    var wordData: (word: String, pronunciation: String, meaning: String, example: String)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = EditorTheme.editorBackground
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        setupContainerView()
        setupHeader()
        setupCodeBlock()
        setupCloseButton()
        setupStatusBar()
    }
    
    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupHeader() {
        headerView.backgroundColor = EditorTheme.tabBarBackground
        headerView.layer.cornerRadius = 8
        headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        headerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(headerView)
        
        tabIndicator.backgroundColor = EditorTheme.accentPrimary
        tabIndicator.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(tabIndicator)
        
        fileIconView.image = UIImage(systemName: "swift")
        fileIconView.tintColor = UIColor(red: 240/255, green: 81/255, blue: 56/255, alpha: 1.0)
        fileIconView.contentMode = .scaleAspectFit
        fileIconView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(fileIconView)
        
        fileNameLabel.text = "DailyWord.swift"
        fileNameLabel.font = EditorFonts.mono(size: EditorFonts.Size.small)
        fileNameLabel.textColor = EditorTheme.textDefault
        fileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(fileNameLabel)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),
            
            tabIndicator.topAnchor.constraint(equalTo: headerView.topAnchor),
            tabIndicator.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            tabIndicator.widthAnchor.constraint(equalToConstant: 150),
            tabIndicator.heightAnchor.constraint(equalToConstant: 2),
            
            fileIconView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            fileIconView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            fileIconView.widthAnchor.constraint(equalToConstant: 18),
            fileIconView.heightAnchor.constraint(equalToConstant: 18),
            
            fileNameLabel.leadingAnchor.constraint(equalTo: fileIconView.trailingAnchor, constant: 8),
            fileNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
    
    private func setupCodeBlock() {
        codeBlockView.backgroundColor = EditorTheme.editorBackground
        codeBlockView.layer.borderWidth = 1
        codeBlockView.layer.borderColor = EditorTheme.border.cgColor
        codeBlockView.layer.cornerRadius = 8
        codeBlockView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        codeBlockView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(codeBlockView)
        
        let contentStack = UIStackView()
        contentStack.axis = .horizontal
        contentStack.spacing = 12
        contentStack.alignment = .top
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        codeBlockView.addSubview(contentStack)
        
        lineNumberStack.axis = .vertical
        lineNumberStack.spacing = 6
        lineNumberStack.alignment = .trailing
        contentStack.addArrangedSubview(lineNumberStack)
        
        let separator = UIView()
        separator.backgroundColor = EditorTheme.border
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        contentStack.addArrangedSubview(separator)
        
        codeContentStack.axis = .vertical
        codeContentStack.spacing = 6
        codeContentStack.alignment = .leading
        contentStack.addArrangedSubview(codeContentStack)
        
        NSLayoutConstraint.activate([
            codeBlockView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            codeBlockView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            codeBlockView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            contentStack.topAnchor.constraint(equalTo: codeBlockView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: codeBlockView.leadingAnchor, constant: 12),
            contentStack.trailingAnchor.constraint(equalTo: codeBlockView.trailingAnchor, constant: -12),
            contentStack.bottomAnchor.constraint(equalTo: codeBlockView.bottomAnchor, constant: -16)
        ])
        
        populateCodeContent()
    }
    
    private func populateCodeContent() {
        let word = wordData?.word ?? "word"
        let pronunciation = wordData?.pronunciation ?? ""
        let meaning = wordData?.meaning ?? ""
        let example = wordData?.example ?? ""
        
        let codeLines: [(lineNum: String, content: NSAttributedString)] = [
            ("1", createCodeLine(prefix: "// ", text: "📚 Today's Word", style: .comment)),
            ("2", createCodeLine(prefix: "", text: "", style: .plain)),
            ("3", createCodeLine(prefix: "let ", text: "word", style: .keyword, suffix: " = ", value: "\"\(word)\"", valueStyle: .string)),
            ("4", createCodeLine(prefix: "let ", text: "pronunciation", style: .keyword, suffix: " = ", value: "\"\(pronunciation)\"", valueStyle: .string)),
            ("5", createCodeLine(prefix: "", text: "", style: .plain)),
            ("6", createCodeLine(prefix: "// ", text: "Definition", style: .comment)),
            ("7", createCodeLine(prefix: "let ", text: "meaning", style: .keyword, suffix: " = \"\"\"", value: "", valueStyle: .plain)),
            ("8", createMeaningLine(meaning)),
            ("9", createCodeLine(prefix: "\"\"\"", text: "", style: .string)),
            ("10", createCodeLine(prefix: "", text: "", style: .plain)),
            ("11", createCodeLine(prefix: "// ", text: "Usage Example", style: .comment)),
            ("12", createCodeLine(prefix: "let ", text: "example", style: .keyword, suffix: " = \"\"\"", value: "", valueStyle: .plain)),
            ("13", createExampleLine(example, word: word)),
            ("14", createCodeLine(prefix: "\"\"\"", text: "", style: .string))
        ]
        
        for line in codeLines {
            let lineNumLabel = UILabel()
            lineNumLabel.font = EditorFonts.lineNumber
            lineNumLabel.textColor = EditorTheme.lineNumber
            lineNumLabel.text = line.lineNum
            lineNumLabel.textAlignment = .right
            lineNumLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
            lineNumberStack.addArrangedSubview(lineNumLabel)
            
            let codeLabel = UILabel()
            codeLabel.attributedText = line.content
            codeLabel.numberOfLines = 0
            codeContentStack.addArrangedSubview(codeLabel)
        }
    }
    
    private func createCodeLine(prefix: String, text: String, style: CodeStyle, suffix: String = "", value: String = "", valueStyle: CodeStyle = .plain) -> NSAttributedString {
        let result = NSMutableAttributedString()
        
        if !prefix.isEmpty {
            let prefixStyle: [NSAttributedString.Key: Any] = [
                .font: EditorFonts.code,
                .foregroundColor: style == .comment ? EditorTheme.comment : EditorTheme.keyword
            ]
            result.append(NSAttributedString(string: prefix, attributes: prefixStyle))
        }
        
        if !text.isEmpty {
            let textAttrs: [NSAttributedString.Key: Any] = [
                .font: EditorFonts.code,
                .foregroundColor: colorForStyle(style)
            ]
            result.append(NSAttributedString(string: text, attributes: textAttrs))
        }
        
        if !suffix.isEmpty {
            let suffixAttrs: [NSAttributedString.Key: Any] = [
                .font: EditorFonts.code,
                .foregroundColor: EditorTheme.textDefault
            ]
            result.append(NSAttributedString(string: suffix, attributes: suffixAttrs))
        }
        
        if !value.isEmpty {
            let valueAttrs: [NSAttributedString.Key: Any] = [
                .font: EditorFonts.code,
                .foregroundColor: colorForStyle(valueStyle)
            ]
            result.append(NSAttributedString(string: value, attributes: valueAttrs))
        }
        
        return result
    }
    
    private func createMeaningLine(_ meaning: String) -> NSAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: EditorFonts.mono(size: EditorFonts.Size.body),
            .foregroundColor: EditorTheme.string
        ]
        return NSAttributedString(string: "    \(meaning)", attributes: attrs)
    }
    
    private func createExampleLine(_ example: String, word: String) -> NSAttributedString {
        let result = NSMutableAttributedString()
        let indent = "    "
        
        result.append(NSAttributedString(string: indent, attributes: [
            .font: EditorFonts.mono(size: EditorFonts.Size.body),
            .foregroundColor: EditorTheme.string
        ]))
        
        let keywords = word.components(separatedBy: "/")
        var remainingText = example
        
        for keyword in keywords {
            let lowercaseRemaining = remainingText.lowercased()
            let lowercaseKeyword = keyword.lowercased()
            
            if let range = lowercaseRemaining.range(of: lowercaseKeyword) {
                let nsRange = NSRange(range, in: remainingText)
                let beforeText = String(remainingText[..<range.lowerBound])
                let keywordText = String(remainingText[range])
                
                result.append(NSAttributedString(string: beforeText, attributes: [
                    .font: EditorFonts.mono(size: EditorFonts.Size.body),
                    .foregroundColor: EditorTheme.string
                ]))
                
                result.append(NSAttributedString(string: keywordText, attributes: [
                    .font: EditorFonts.monoBold(size: EditorFonts.Size.body),
                    .foregroundColor: EditorTheme.type,
                    .backgroundColor: EditorTheme.selectionBackground
                ]))
                
                remainingText = String(remainingText[range.upperBound...])
            }
        }
        
        result.append(NSAttributedString(string: remainingText, attributes: [
            .font: EditorFonts.mono(size: EditorFonts.Size.body),
            .foregroundColor: EditorTheme.string
        ]))
        
        return result
    }
    
    private func colorForStyle(_ style: CodeStyle) -> UIColor {
        switch style {
        case .keyword: return EditorTheme.keyword
        case .string: return EditorTheme.string
        case .comment: return EditorTheme.comment
        case .variable: return EditorTheme.variable
        case .type: return EditorTheme.type
        case .plain: return EditorTheme.textDefault
        }
    }
    
    private func setupCloseButton() {
        closeButton.style = .primary
        closeButton.setTitle(NSLocalizedString("close", comment: ""), for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: codeBlockView.bottomAnchor, constant: 20),
            closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
            closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupStatusBar() {
        statusBar.backgroundColor = EditorTheme.statusBarBackground
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusBar)
        
        statusLabel.text = "Swift • UTF-8 • LF"
        statusLabel.font = EditorFonts.mono(size: 11)
        statusLabel.textColor = .white
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusBar.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: 22),
            
            statusLabel.trailingAnchor.constraint(equalTo: statusBar.trailingAnchor, constant: -12),
            statusLabel.centerYAnchor.constraint(equalTo: statusBar.centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Code Style

private enum CodeStyle {
    case keyword
    case string
    case comment
    case variable
    case type
    case plain
}
