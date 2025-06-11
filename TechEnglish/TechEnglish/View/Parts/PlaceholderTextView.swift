import UIKit


class PlaceholderTextView: UITextView {
    let placeholderLabel = UILabel()

    var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    override var text: String! {
        didSet {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.frame = CGRect(x: 5, y: 8, width: bounds.width - 10, height: 20)
    }

    private func setupPlaceholder() {
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = self.font
        addSubview(placeholderLabel)
        placeholderLabel.isHidden = !text.isEmpty

        // テキストが変更されたら非表示にする
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: self
        )
    }

    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
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
