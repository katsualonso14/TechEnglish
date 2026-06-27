import UIKit

protocol MyCardsCellDelegate: AnyObject {
    func didTapReminderButton(in cell: MyCardsCell, pushTime: Int)
}

class MyCardsCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    let frontView = UIView()
    let backView = UIView()
    let label = UILabel()
    let backViewLabel = UILabel()
    let backViewSubLabel = UILabel()
    private let lineNumberLabel = UILabel()
    private let gutterView = UIView()
    
    weak var delegate: MyCardsCellDelegate?
    var isFlipped = false
    var lineNumber: Int = 1 {
        didSet { lineNumberLabel.text = String(format: "%3d", lineNumber) }
    }

    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupGutter()
        setupFrontView()
        setupBackView()
        setupLabel()
        setupReviewButton()
        setupBackViewLabel()
        setupBackViewSubLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setupLayout() {
        self.layer.cornerRadius = 0
        self.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 0
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = EditorTheme.editorBackground
        self.backgroundColor = EditorTheme.editorBackground
        self.selectionStyle = .none
    }
    
    private func setupGutter() {
        gutterView.backgroundColor = EditorTheme.sidebarBackground
        gutterView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gutterView)
        
        lineNumberLabel.font = EditorFonts.lineNumber
        lineNumberLabel.textColor = EditorTheme.lineNumber
        lineNumberLabel.textAlignment = .right
        lineNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        gutterView.addSubview(lineNumberLabel)
        
        let separator = UIView()
        separator.backgroundColor = EditorTheme.border
        separator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separator)
        
        NSLayoutConstraint.activate([
            gutterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gutterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gutterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gutterView.widthAnchor.constraint(equalToConstant: 44),
            
            lineNumberLabel.trailingAnchor.constraint(equalTo: gutterView.trailingAnchor, constant: -8),
            lineNumberLabel.centerYAnchor.constraint(equalTo: gutterView.centerYAnchor),
            
            separator.leadingAnchor.constraint(equalTo: gutterView.trailingAnchor),
            separator.topAnchor.constraint(equalTo: contentView.topAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupFrontView() {
        frontView.backgroundColor = EditorTheme.editorBackground
        frontView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(frontView)
        
        NSLayoutConstraint.activate([
            frontView.topAnchor.constraint(equalTo: contentView.topAnchor),
            frontView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            frontView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            frontView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupBackView() {
        backView.backgroundColor = EditorTheme.sidebarBackground
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        backView.isHidden = true
    }
    
    func setupLabel() {
        label.textColor = EditorTheme.type
        label.font = EditorFonts.monoBold(size: EditorFonts.Size.subheadline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        frontView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: frontView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -50)
        ])
    }
    
    func setupBackViewLabel() {
        backViewLabel.textColor = EditorTheme.string
        backViewLabel.font = EditorFonts.mono(size: EditorFonts.Size.body)
        backViewLabel.numberOfLines = 0
        backViewLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(backViewLabel)
        
        NSLayoutConstraint.activate([
            backViewLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12),
            backViewLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            backViewLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupBackViewSubLabel() {
        backViewSubLabel.textColor = EditorTheme.comment
        backViewSubLabel.font = EditorFonts.mono(size: EditorFonts.Size.small)
        backViewSubLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(backViewSubLabel)
        
        NSLayoutConstraint.activate([
            backViewSubLabel.topAnchor.constraint(equalTo: backViewLabel.bottomAnchor, constant: 8),
            backViewSubLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16)
        ])
    }
    
    func setupReviewButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "clock.arrow.circlepath"), for: .normal)
        button.tintColor = EditorTheme.accentPrimary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showBottomModal), for: .touchUpInside)
        frontView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: frontView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Helper
    
    func flip() {
        let fromView = isFlipped ? backView : frontView
        let toView = isFlipped ? frontView : backView

        UIView.transition(from: fromView,
                          to: toView,
                          duration: 0.6,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews],
                          completion: nil)

        isFlipped.toggle()
    }
    
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
                self.tapButton()
                self.showRemindCompletedAlert()
            })
        )
        
        actionSheet.addAction(
            UIAlertAction(title: "setTimeout(() => remind(), 10800)", style: .default, handler: { _ in
                self.tapButton2()
                self.showRemindCompletedAlert()
            })
        )
        
        actionSheet.addAction(
            UIAlertAction(title: "setTimeout(() => remind(), 86400)", style: .default, handler: { _ in
                self.tapButton3()
                self.showRemindCompletedAlert()
            })
        )
        
        actionSheet.addAction(
            UIAlertAction(title: "// Cancel", style: .cancel, handler: nil)
        )
        
        if let viewController = self.window?.rootViewController {
            viewController.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    @objc private func tapButton() {
        delegate?.didTapReminderButton(in: self, pushTime: 3600)
    }
    
    @objc private func tapButton2() {
        delegate?.didTapReminderButton(in: self, pushTime: 10800)
    }
    
    @objc private func tapButton3() {
        delegate?.didTapReminderButton(in: self, pushTime: 86400)
    }
}
