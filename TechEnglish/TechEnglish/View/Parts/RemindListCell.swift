import UIKit

class RemindListCell: UITableViewCell {
    
    let sentenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(sentenceLabel)
        addSubview(timeLabel)
        //namelabelの配置
        sentenceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        sentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        sentenceLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        //timeLabelの配置
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 25).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(sentence: String, pattern: String) {
        sentenceLabel.text = sentence
        
        switch pattern {
        case "3600":
            timeLabel.text = NSLocalizedString("in 1hour", comment: "")
        case "10800":
            timeLabel.text = NSLocalizedString("in 3hour", comment: "")
        case "86400":
            timeLabel.text = NSLocalizedString("in 1day", comment: "")
        default:
            timeLabel.text = NSLocalizedString("no set", comment: "")
        }
    }

}
