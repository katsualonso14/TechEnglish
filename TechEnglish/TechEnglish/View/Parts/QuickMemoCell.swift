import UIKit

class QuickMemoCell: UITableViewCell {
    
    let label = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()
        // layer
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.backgroundColor = .clear
        // contentView layer
        self.contentView.layer.cornerRadius = 16
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .systemBackground
        
        self.contentView.layer.borderColor = UIColor.systemGray6.cgColor
        self.contentView.layer.borderWidth = 3
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label.textColor = AppColors.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
    
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
