import UIKit

class DailyWordViewController: UIViewController {
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let wordLabel = UILabel()
    let pronunciationLabel = UILabel()
    let meaningLabel = UILabel()
    let exampleLabel = UILabel()
    let closeButton = UIButton(type: .system)
    
    var wordData: (word: String, pronunciation: String, meaning: String, example: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        setupContainerView()
        setupTitleLabel()
        setupWordLabel()
        setupPronunciationLabel()
        setupMeaningLabel()
        setupExampleLabel()
        setupCloseButton()
    }
    
    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = NSLocalizedString("daily_word_title", comment: "")
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = AppColors.appMainColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setupWordLabel() {
        wordLabel.text = wordData?.word ?? ""
        wordLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        wordLabel.textAlignment = .center
        wordLabel.numberOfLines = 0
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(wordLabel)
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            wordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            wordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setupPronunciationLabel() {
        pronunciationLabel.text = wordData?.pronunciation ?? ""
        pronunciationLabel.font = UIFont.systemFont(ofSize: 18)
        pronunciationLabel.textAlignment = .center
        pronunciationLabel.textColor = .secondaryLabel
        pronunciationLabel.numberOfLines = 0
        pronunciationLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(pronunciationLabel)
        
        NSLayoutConstraint.activate([
            pronunciationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 8),
            pronunciationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pronunciationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setupMeaningLabel() {
        meaningLabel.text = wordData?.meaning ?? ""
        meaningLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        meaningLabel.textAlignment = .left
        meaningLabel.numberOfLines = 0
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(meaningLabel)
        
        NSLayoutConstraint.activate([
            meaningLabel.topAnchor.constraint(equalTo: pronunciationLabel.bottomAnchor, constant: 24),
            meaningLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            meaningLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupExampleLabel() {
        exampleLabel.text = wordData?.example ?? ""
        exampleLabel.font = UIFont.systemFont(ofSize: 16)
        exampleLabel.textAlignment = .left
        exampleLabel.textColor = .secondaryLabel
        exampleLabel.numberOfLines = 0
        exampleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(exampleLabel)
        
        NSLayoutConstraint.activate([
            exampleLabel.topAnchor.constraint(equalTo: meaningLabel.bottomAnchor, constant: 16),
            exampleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            exampleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupCloseButton() {
        closeButton.setTitle(NSLocalizedString("close", comment: ""), for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = AppColors.appMainColor
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        closeButton.layer.cornerRadius = 12
        closeButton.layer.masksToBounds = true
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: exampleLabel.bottomAnchor, constant: 24),
            closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
}
