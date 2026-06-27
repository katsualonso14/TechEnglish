import UIKit

class PlaceholderTextView: UITextView {
    
    let placeholderLabel = UILabel()
    private let lineNumberLabel = UILabel()
    private let gutterView = UIView()
    
    var showLineNumbers: Bool = false {
        didSet { updateGutterVisibility() }
    }

    var placeholder: String? {
        didSet {
            placeholderLabel.text = "// \(placeholder ?? "")"
        }
    }

    override var text: String! {
        didSet {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let gutterWidth: CGFloat = showLineNumbers ? 32 : 0
        placeholderLabel.frame = CGRect(x: gutterWidth + 8, y: 8, width: bounds.width - gutterWidth - 16, height: 20)
        
        if showLineNumbers {
            gutterView.frame = CGRect(x: 0, y: 0, width: gutterWidth, height: bounds.height)
            lineNumberLabel.frame = CGRect(x: 4, y: 8, width: gutterWidth - 8, height: 20)
        }
    }

    private func setupPlaceholder() {
        applyEditorStyle()
        
        placeholderLabel.textColor = EditorTheme.comment
        placeholderLabel.font = EditorFonts.mono(size: EditorFonts.Size.body)
        addSubview(placeholderLabel)
        placeholderLabel.isHidden = !text.isEmpty

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: self
        )
        
        setupGutter()
    }
    
    private func applyEditorStyle() {
        backgroundColor = EditorTheme.editorBackground
        textColor = EditorTheme.textDefault
        font = EditorFonts.mono(size: EditorFonts.Size.body)
        layer.borderColor = EditorTheme.border.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 6
        tintColor = EditorTheme.accentPrimary
        keyboardAppearance = .dark
    }
    
    private func setupGutter() {
        gutterView.backgroundColor = EditorTheme.sidebarBackground
        gutterView.isHidden = true
        addSubview(gutterView)
        
        lineNumberLabel.font = EditorFonts.lineNumber
        lineNumberLabel.textColor = EditorTheme.lineNumber
        lineNumberLabel.textAlignment = .right
        lineNumberLabel.text = "1"
        gutterView.addSubview(lineNumberLabel)
    }
    
    private func updateGutterVisibility() {
        gutterView.isHidden = !showLineNumbers
        textContainerInset = UIEdgeInsets(
            top: 8,
            left: showLineNumbers ? 32 : 8,
            bottom: 8,
            right: 8
        )
        setNeedsLayout()
    }

    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
        
        if showLineNumbers {
            let lineCount = text.components(separatedBy: "\n").count
            lineNumberLabel.text = "\(lineCount)"
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPlaceholder()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupPlaceholder()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
