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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(sentenceLabel)
        //namelabelの配置
        sentenceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        sentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        sentenceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true
        sentenceLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(sentence: String) {
        sentenceLabel.text = sentence
    }
}
