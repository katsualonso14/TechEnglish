import UIKit

class SelectSearchWordModal: UIView {
    var searchWord: [String] = []
    var parentVC: UIViewController?
    let pickerView = UIPickerView()
    
    init(frame: CGRect, parentVC: UIViewController) {
        self.parentVC = parentVC
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        setupDiscriptLabel()
        setupPicker()
        setupOpenButton()
        setupCancelButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDiscriptLabel() {
        let label = UILabel()
        label.text = NSLocalizedString("web_search_massage", comment: "")
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        self.addSubview(label)
    }
    
    func setupPicker() {
        pickerView.backgroundColor = .systemBackground
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.frame = CGRect(x: 0, y: 100, width: 300, height: 100)
        self.addSubview(pickerView)
    }
    
    func setupOpenButton() {
        let openButton = UIButton(type: .system)
        openButton.setTitle("Open", for: .normal)
        openButton.tintColor = UIColor.systemBlue
        openButton.addTarget(self, action: #selector(openWebView), for: .touchUpInside)
        openButton.frame = CGRect(x: 150, y: 250, width: 150, height: 50)
        self.addSubview(openButton)
    }
    
    func setupCancelButton() {
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = UIColor.systemBlue
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        cancelButton.frame = CGRect(x: 0, y: 250, width: 150, height: 50)
        self.addSubview(cancelButton)
    }
    //MARK - Function
    // 検索する単語がありませんのモーダル表示
    func openNoSearchWordAlert() {
        let alert = UIAlertController(
            title: NSLocalizedString("no_search_word_title", comment: ""),
            message: NSLocalizedString("no_search_word_message", comment: ""),
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        parentVC?.present(alert, animated: true, completion: nil)
    }
    //MARK - objc
    @objc func openWebView() {
        self.removeFromSuperview()
        if (searchWord.isEmpty) {
            openNoSearchWordAlert()
        }
        let webView = WebModalViewController()
        // pickerで選択した単語を渡す(非選択時は0番目)
        let row = pickerView.selectedRow(inComponent: 0)
        webView.selectedWord = searchWord[row]
        webView.modalPresentationStyle = .popover
        // 親ビューの上に表示
        parentVC?.present(webView, animated: true, completion: nil)
    }
    
    @objc func cancelAction() {
        self.removeFromSuperview()
    }
    
}


extension SelectSearchWordModal: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return searchWord.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return searchWord[row]
    }
}
