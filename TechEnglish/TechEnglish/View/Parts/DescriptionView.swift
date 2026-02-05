import UIKit

class DescriptionView: UIView {
    let imageView = UIImageView()
    let label = UILabel()
    let checkBoxLabel = UILabel()
    let descriptionCheckBox = UIImageView()
    let button = UIButton(type: .system)
    let closeButton = UIButton(type: .system)
    var discriptNumber = 1
    weak var parentViewController: UIViewController?

    var isDescription: Bool {
        return UserDefaults.standard.bool(forKey: "isDescription")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.backgroundColorCheckMode
        layer.cornerRadius = 12
        setupView()
    }

    private func setupView() {
        [imageView, label, checkBoxLabel, descriptionCheckBox, button, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        imageView.contentMode = .scaleAspectFit

        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0

        checkBoxLabel.text = NSLocalizedString("dicript_check_box_lable", comment: "")
        checkBoxLabel.font = UIFont.systemFont(ofSize: 16)
        checkBoxLabel.textColor = .systemGray

        descriptionCheckBox.contentMode = .scaleAspectFit
        descriptionCheckBox.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))
        descriptionCheckBox.addGestureRecognizer(gesture)

        button.backgroundColor = AppColors.appMainColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(changePage), for: .touchUpInside)

        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .systemGray
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)

        setupConstraints()
        updateViewContent()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),

            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            checkBoxLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            checkBoxLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            descriptionCheckBox.centerYAnchor.constraint(equalTo: checkBoxLabel.centerYAnchor),
            descriptionCheckBox.leadingAnchor.constraint(equalTo: checkBoxLabel.trailingAnchor, constant: 10),
            descriptionCheckBox.widthAnchor.constraint(equalToConstant: 24),
            descriptionCheckBox.heightAnchor.constraint(equalToConstant: 24),

            button.topAnchor.constraint(equalTo: checkBoxLabel.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func updateViewContent() {
        switch discriptNumber {
        case 1:
            imageView.image = UIImage(named: "App_purpose_image")
            label.text = NSLocalizedString("dicript_label_app_purpose", comment: "")
            button.setTitle("Next", for: .normal)
            
        case 2:
            imageView.image = UIImage(named: "Quiz_image")
            label.text = NSLocalizedString("dicript_label_quiz", comment: "")
            button.setTitle("Next", for: .normal)
            
        case 3:
            imageView.image = UIImage(named: "PhraseStock_image")
            label.text = NSLocalizedString("dicript_label_phase_stock", comment: "")
            button.setTitle("Next", for: .normal)
            
        case 4:
            imageView.image = UIImage(named: "TechWords_image")
            label.text = NSLocalizedString("dicript_label_tech_words", comment: "")
            button.setTitle("Close", for: .normal)
            
        default:
            break
        }

        updateCheckBox()
    }

    func updateCheckBox() {
        descriptionCheckBox.image = isDescription ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
    }

    @objc func changePage() {
        if discriptNumber < 4 {
            discriptNumber += 1
        } else {
            parentViewController?.dismiss(animated: true)
        }
        updateViewContent()
    }

    @objc func didTapCheckBox() {
        let newState = !UserDefaults.standard.bool(forKey: "isDescription")
        UserDefaults.standard.set(newState, forKey: "isDescription")
        updateCheckBox()
    }

    @objc func closeModal() {
        self.removeFromSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

