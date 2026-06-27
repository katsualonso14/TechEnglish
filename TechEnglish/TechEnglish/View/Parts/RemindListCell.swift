import UIKit

class RemindListCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private let containerView = UIView()
    private let iconView = UIImageView()
    
    let sentenceLabel: UILabel = {
        let label = UILabel()
        label.font = EditorFonts.mono(size: EditorFonts.Size.body)
        label.textColor = EditorTheme.textDefault
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = EditorFonts.mono(size: EditorFonts.Size.small)
        label.textColor = EditorTheme.comment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = EditorTheme.accentSuccess
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = EditorTheme.editorBackground
        selectionStyle = .none
        
        containerView.backgroundColor = EditorTheme.sidebarBackground
        containerView.layer.cornerRadius = 6
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = EditorTheme.border.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        iconView.image = UIImage(systemName: "clock.arrow.circlepath")
        iconView.tintColor = EditorTheme.accentPrimary
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconView)
        
        containerView.addSubview(statusIndicator)
        containerView.addSubview(sentenceLabel)
        containerView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            statusIndicator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            statusIndicator.topAnchor.constraint(equalTo: containerView.topAnchor),
            statusIndicator.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            statusIndicator.widthAnchor.constraint(equalToConstant: 4),
            
            iconView.leadingAnchor.constraint(equalTo: statusIndicator.trailingAnchor, constant: 12),
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            
            sentenceLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            sentenceLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -12),
            sentenceLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            timeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        containerView.backgroundColor = selected ? EditorTheme.lineHighlight : EditorTheme.sidebarBackground
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        containerView.backgroundColor = highlighted ? EditorTheme.lineHighlight : EditorTheme.sidebarBackground
    }
    
    // MARK: - Configuration
    
    func setCell(sentence: String, pattern: String) {
        sentenceLabel.text = sentence
        
        switch pattern {
        case "3600":
            timeLabel.text = "⏰ 1h"
            statusIndicator.backgroundColor = EditorTheme.accentSuccess
        case "10800":
            timeLabel.text = "⏰ 3h"
            statusIndicator.backgroundColor = EditorTheme.accentWarning
        case "86400":
            timeLabel.text = "📅 1d"
            statusIndicator.backgroundColor = EditorTheme.accentPrimary
        default:
            timeLabel.text = "—"
            statusIndicator.backgroundColor = EditorTheme.textInactive
        }
    }
}
