import UIKit

class AnswerResultViewController: UIViewController {
    var isCorrect: Bool = false
    var correctAnswer: String = ""
    var nextHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupNextButton()
    }

    private func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = isCorrect ? NSLocalizedString("correct", comment: "") : NSLocalizedString("wrong", comment: "")
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center

        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.text = isCorrect
            ? NSLocalizedString("correct_message", comment: "")
            : NSLocalizedString("wrong_message", comment: "") + correctAnswer

        let stack = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupNextButton() {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle(NSLocalizedString("next", comment: ""), for: .normal)

        // スタイル：角丸・背景色・フォント
        nextButton.backgroundColor = AppColors.appMainColor
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        nextButton.layer.cornerRadius = 12
        nextButton.layer.masksToBounds = false

        // シャドー
        nextButton.layer.shadowColor = UIColor.black.cgColor
        nextButton.layer.shadowOpacity = 0.2
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        nextButton.layer.shadowRadius = 6

        // 高さと横幅を指定（例：横いっぱい）
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 50)
            // 横幅はStackView内で自動調整される。必要なら別途制約を追加。
        ])

        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        view.addSubview(nextButton)
        
        // ボタンの配置
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        

    }

    @objc private func nextTapped() {
        dismiss(animated: true) {
            self.nextHandler?()
        }
    }
}
