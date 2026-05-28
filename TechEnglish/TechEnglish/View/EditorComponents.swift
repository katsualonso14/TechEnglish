import UIKit

// MARK: - Editor-Style UI Components
// Reusable components with code editor aesthetic

// MARK: - Code Block View
/// A view styled like a code block in an IDE

class CodeBlockView: UIView {
    
    private let lineNumbersStack = UIStackView()
    private let codeStack = UIStackView()
    private let headerView = UIView()
    private let headerLabel = UILabel()
    private let copyButton = UIButton(type: .system)
    
    var showLineNumbers: Bool = true {
        didSet { lineNumbersStack.isHidden = !showLineNumbers }
    }
    
    var headerTitle: String? {
        didSet { 
            headerLabel.text = headerTitle
            headerView.isHidden = headerTitle == nil
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = EditorTheme.editorBackground
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = EditorTheme.border.cgColor
        clipsToBounds = true
        
        setupHeader()
        setupCodeArea()
    }
    
    private func setupHeader() {
        headerView.backgroundColor = EditorTheme.tabBarBackground
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
        
        headerLabel.font = EditorFonts.mono(size: EditorFonts.Size.small)
        headerLabel.textColor = EditorTheme.textInactive
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        
        copyButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        copyButton.tintColor = EditorTheme.textInactive
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(copyButton)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 32),
            
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            copyButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8),
            copyButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        headerView.isHidden = true
    }
    
    private func setupCodeArea() {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 12
        container.alignment = .top
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        
        lineNumbersStack.axis = .vertical
        lineNumbersStack.spacing = 4
        lineNumbersStack.alignment = .trailing
        container.addArrangedSubview(lineNumbersStack)
        
        let separator = UIView()
        separator.backgroundColor = EditorTheme.border
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        container.addArrangedSubview(separator)
        
        codeStack.axis = .vertical
        codeStack.spacing = 4
        codeStack.alignment = .leading
        container.addArrangedSubview(codeStack)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: headerView.isHidden ? topAnchor : headerView.bottomAnchor, constant: 12),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    func setCode(lines: [NSAttributedString]) {
        lineNumbersStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        codeStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, line) in lines.enumerated() {
            let lineNumLabel = UILabel()
            lineNumLabel.applyLineNumberStyle()
            lineNumLabel.text = "\(index + 1)"
            lineNumbersStack.addArrangedSubview(lineNumLabel)
            
            let codeLabel = UILabel()
            codeLabel.attributedText = line
            codeLabel.numberOfLines = 0
            codeStack.addArrangedSubview(codeLabel)
        }
    }
}

// MARK: - Editor Tab View
/// A view styled like IDE tabs

class EditorTabView: UIView {
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    
    var isActive: Bool = false {
        didSet { updateAppearance() }
    }
    
    var title: String? {
        didSet { titleLabel.text = title }
    }
    
    var icon: UIImage? {
        didSet { iconView.image = icon }
    }
    
    var onClose: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = EditorTheme.accentPrimary
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        stack.addArrangedSubview(iconView)
        
        titleLabel.font = EditorFonts.mono(size: EditorFonts.Size.small)
        titleLabel.textColor = EditorTheme.textDefault
        stack.addArrangedSubview(titleLabel)
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = EditorTheme.textInactive
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        stack.addArrangedSubview(closeButton)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
        
        layer.borderWidth = 1
        layer.borderColor = EditorTheme.border.cgColor
        
        updateAppearance()
    }
    
    private func updateAppearance() {
        backgroundColor = isActive ? EditorTheme.activeTabBackground : EditorTheme.tabBarBackground
        titleLabel.textColor = isActive ? EditorTheme.textDefault : EditorTheme.textInactive
        
        if isActive {
            layer.borderColor = UIColor.clear.cgColor
        } else {
            layer.borderColor = EditorTheme.border.cgColor
        }
    }
    
    @objc private func closeTapped() {
        onClose?()
    }
}

// MARK: - Terminal Output View
/// A view styled like terminal output

class TerminalOutputView: UIView {
    
    private let promptLabel = UILabel()
    private let outputLabel = UILabel()
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    
    var prompt: String = "$ " {
        didSet { promptLabel.text = prompt }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = EditorTheme.terminalBackground
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = EditorTheme.border.cgColor
        clipsToBounds = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        contentStack.axis = .vertical
        contentStack.spacing = 4
        contentStack.alignment = .leading
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func addOutput(_ text: String, color: UIColor = EditorTheme.textDefault) {
        let label = UILabel()
        label.font = EditorFonts.terminal
        label.textColor = color
        label.text = text
        label.numberOfLines = 0
        contentStack.addArrangedSubview(label)
    }
    
    func addCommand(_ command: String) {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 4
        
        let promptLabel = UILabel()
        promptLabel.font = EditorFonts.terminal
        promptLabel.textColor = EditorTheme.accentSuccess
        promptLabel.text = prompt
        container.addArrangedSubview(promptLabel)
        
        let commandLabel = UILabel()
        commandLabel.font = EditorFonts.terminal
        commandLabel.textColor = EditorTheme.textDefault
        commandLabel.text = command
        container.addArrangedSubview(commandLabel)
        
        contentStack.addArrangedSubview(container)
    }
    
    func clear() {
        contentStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

// MARK: - Editor Button
/// A button styled like IDE buttons

class EditorButton: UIButton {
    
    enum Style {
        case primary
        case secondary
        case destructive
        case ghost
    }
    
    var style: Style = .primary {
        didSet { updateAppearance() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = 4
        titleLabel?.font = EditorFonts.uiMedium(size: EditorFonts.Size.body)
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        updateAppearance()
    }
    
    private func updateAppearance() {
        switch style {
        case .primary:
            backgroundColor = EditorTheme.buttonPrimary
            setTitleColor(EditorTheme.buttonPrimaryText, for: .normal)
            layer.borderWidth = 0
            
        case .secondary:
            backgroundColor = EditorTheme.buttonSecondary
            setTitleColor(EditorTheme.buttonSecondaryText, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = EditorTheme.border.cgColor
            
        case .destructive:
            backgroundColor = EditorTheme.accentError
            setTitleColor(.white, for: .normal)
            layer.borderWidth = 0
            
        case .ghost:
            backgroundColor = .clear
            setTitleColor(EditorTheme.accentPrimary, for: .normal)
            layer.borderWidth = 0
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.7 : 1.0
        }
    }
}

// MARK: - Status Bar Indicator
/// A status bar styled like IDE status bar

class EditorStatusBar: UIView {
    
    private let leftStack = UIStackView()
    private let rightStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = EditorTheme.statusBarBackground
        
        leftStack.axis = .horizontal
        leftStack.spacing = 16
        leftStack.alignment = .center
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftStack)
        
        rightStack.axis = .horizontal
        rightStack.spacing = 16
        rightStack.alignment = .center
        rightStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightStack)
        
        NSLayoutConstraint.activate([
            leftStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            leftStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            rightStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            rightStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func addLeftItem(icon: UIImage?, text: String) {
        let item = createStatusItem(icon: icon, text: text)
        leftStack.addArrangedSubview(item)
    }
    
    func addRightItem(icon: UIImage?, text: String) {
        let item = createStatusItem(icon: icon, text: text)
        rightStack.addArrangedSubview(item)
    }
    
    private func createStatusItem(icon: UIImage?, text: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        
        if let icon = icon {
            let iconView = UIImageView(image: icon)
            iconView.tintColor = .white
            iconView.contentMode = .scaleAspectFit
            iconView.translatesAutoresizingMaskIntoConstraints = false
            iconView.widthAnchor.constraint(equalToConstant: 14).isActive = true
            iconView.heightAnchor.constraint(equalToConstant: 14).isActive = true
            stack.addArrangedSubview(iconView)
        }
        
        let label = UILabel()
        label.font = EditorFonts.mono(size: 12)
        label.textColor = .white
        label.text = text
        stack.addArrangedSubview(label)
        
        return stack
    }
}

// MARK: - Syntax Highlighted Label
/// A label that can display syntax-highlighted text

class SyntaxLabel: UILabel {
    
    func setText(_ text: String, style: SyntaxStyle) {
        let attributes: [NSAttributedString.Key: Any]
        
        switch style {
        case .keyword:
            attributes = [
                .font: EditorFonts.monoBold(size: font.pointSize),
                .foregroundColor: EditorTheme.keyword
            ]
        case .string:
            attributes = [
                .font: EditorFonts.mono(size: font.pointSize),
                .foregroundColor: EditorTheme.string
            ]
        case .comment:
            attributes = [
                .font: EditorFonts.mono(size: font.pointSize),
                .foregroundColor: EditorTheme.comment
            ]
        case .type:
            attributes = [
                .font: EditorFonts.monoSemibold(size: font.pointSize),
                .foregroundColor: EditorTheme.type
            ]
        case .function:
            attributes = [
                .font: EditorFonts.mono(size: font.pointSize),
                .foregroundColor: EditorTheme.function
            ]
        case .variable:
            attributes = [
                .font: EditorFonts.mono(size: font.pointSize),
                .foregroundColor: EditorTheme.variable
            ]
        case .number:
            attributes = [
                .font: EditorFonts.mono(size: font.pointSize),
                .foregroundColor: EditorTheme.number
            ]
        case .plain:
            attributes = [
                .font: EditorFonts.mono(size: font.pointSize),
                .foregroundColor: EditorTheme.textDefault
            ]
        }
        
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    enum SyntaxStyle {
        case keyword
        case string
        case comment
        case type
        case function
        case variable
        case number
        case plain
    }
}

// MARK: - Tree View Item
/// A view styled like file tree items in IDE

class TreeViewItem: UIView {
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let chevronView = UIImageView()
    
    var isExpanded: Bool = false {
        didSet { updateChevron() }
    }
    
    var isFolder: Bool = false {
        didSet { 
            chevronView.isHidden = !isFolder
            updateIcon()
        }
    }
    
    var title: String? {
        didSet { titleLabel.text = title }
    }
    
    var indentLevel: Int = 0 {
        didSet { updateIndent() }
    }
    
    private var leadingConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        chevronView.image = UIImage(systemName: "chevron.right")
        chevronView.tintColor = EditorTheme.textInactive
        chevronView.contentMode = .scaleAspectFit
        chevronView.translatesAutoresizingMaskIntoConstraints = false
        chevronView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        chevronView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        chevronView.isHidden = true
        stack.addArrangedSubview(chevronView)
        
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = EditorTheme.accentPrimary
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        stack.addArrangedSubview(iconView)
        
        titleLabel.font = EditorFonts.mono(size: EditorFonts.Size.small)
        titleLabel.textColor = EditorTheme.textDefault
        stack.addArrangedSubview(titleLabel)
        
        leadingConstraint = stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        
        NSLayoutConstraint.activate([
            leadingConstraint!,
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8)
        ])
        
        updateIcon()
    }
    
    private func updateChevron() {
        let imageName = isExpanded ? "chevron.down" : "chevron.right"
        chevronView.image = UIImage(systemName: imageName)
    }
    
    private func updateIcon() {
        if isFolder {
            let imageName = isExpanded ? "folder.fill" : "folder"
            iconView.image = UIImage(systemName: imageName)
            iconView.tintColor = EditorTheme.function
        } else {
            iconView.image = UIImage(systemName: "doc.text")
            iconView.tintColor = EditorTheme.accentPrimary
        }
    }
    
    private func updateIndent() {
        leadingConstraint?.constant = CGFloat(8 + indentLevel * 16)
    }
}
