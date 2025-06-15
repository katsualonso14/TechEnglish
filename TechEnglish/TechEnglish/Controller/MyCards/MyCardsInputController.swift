import UIKit

protocol MyCardsInputDelegate: AnyObject {
    //TODO: ここが効いていないので要確認
    func didSaveMyCards(frontText: String, backText: String)
    func didSaveEditMyCards(frontText: String, backText: String, index: Int)
    func saveEditFilterdMyCards()
}

class MyCardsInputViewController: UIViewController {
    
    let frontLabel = UILabel()
    let backLabel = UILabel()
    let myWordsField = UITextField()
    let myWordsTextView = PlaceholderTextView()
    let setenceTextView = PlaceholderTextView()
    let saveButton = UIButton(type: .system)
    let separator = UIView()
    var editMode = false
    var currentIndex: Int = 0
    
    weak var delegate: MyCardsInputDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupFrontLabel()
        setupMyWordTextView()
        setupSeparator()
        
        setupBackLabel()
        setupSentenceTextView()
        saveButtonSetup()
    }
    
    func setupMyWordTextView() {
        myWordsTextView.placeholder = NSLocalizedString("word_placeholder", comment: "")
        myWordsTextView.font = UIFont.systemFont(ofSize: 16)
        myWordsTextView.layer.borderColor = UIColor.lightGray.cgColor
        myWordsTextView.layer.borderWidth = 1.0
        myWordsTextView.layer.cornerRadius = 8
        view.addSubview(myWordsTextView)
        myWordsTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            myWordsTextView.topAnchor.constraint(equalTo: frontLabel.bottomAnchor, constant: 8),
            myWordsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myWordsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myWordsTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupSentenceTextView() {
        setenceTextView.placeholder = NSLocalizedString("word_placeholder", comment: "")
        setenceTextView.font = UIFont.systemFont(ofSize: 16)
        setenceTextView.layer.borderColor = UIColor.lightGray.cgColor
        setenceTextView.layer.borderWidth = 1.0
        setenceTextView.layer.cornerRadius = 8
        view.addSubview(setenceTextView)
        setenceTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            setenceTextView.topAnchor.constraint(equalTo: backLabel.bottomAnchor, constant: 8),
            setenceTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setenceTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setenceTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func saveButtonSetup() {
        saveButton.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = AppColors.appMainColor
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        saveButton.layer.cornerRadius = 12
        saveButton.layer.masksToBounds = true

        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        saveButton.layer.shadowOpacity = 0.3
        saveButton.layer.shadowRadius = 4
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: setenceTextView.bottomAnchor, constant: 24),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }

    func setupSeparator() {
        separator.backgroundColor = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator)

        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: myWordsTextView.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupFrontLabel() {
        frontLabel.text = NSLocalizedString("front_label", comment: "")
        frontLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(frontLabel)
        
        NSLayoutConstraint.activate([
            frontLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            frontLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func setupBackLabel() {
        backLabel.text = NSLocalizedString("back_label", comment: "")
        backLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backLabel)
        
        NSLayoutConstraint.activate([
            backLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            backLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    @objc func saveTapped() {
        let frontText = myWordsTextView.text ?? ""
        let backText = setenceTextView.text ?? ""
        // 単語テキストフィールドがからの場合はアラートを表示
         // ただし、バックテキストが空の場合は許容する
        if frontText.isEmpty {
            let alert = UIAlertController(
                title: NSLocalizedString("error", comment: ""),
                message: NSLocalizedString("word_seeds_error_message", comment: ""),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return // dismiss しない
        }
        
        if (editMode) {
            delegate?.didSaveEditMyCards(frontText: frontText, backText: backText, index: currentIndex)
        } else {
            delegate?.didSaveMyCards(frontText: frontText, backText: backText)
        }
        
        delegate?.saveEditFilterdMyCards()
        
        dismiss(animated: true, completion: nil)
    }
}
