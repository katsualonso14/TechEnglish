import UIKit

class SelectSearchWordModal: UIView {
    var searchWord: [String] = []
    var selecetedWord: String?
    var parentVC: UIViewController?
    
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
        label.text = "Would you like to search for the following words in Web?"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        self.addSubview(label)
    }
    
    func setupPicker() {
        let pickerView = UIPickerView()
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
    //MARK - objc
    @objc func openWebView() {
        print("tap")
        self.removeFromSuperview()
        let webView = WebModalViewController()
        // pickerで選択した単語を渡す
        webView.selectedWord = selecetedWord == nil ? searchWord[0] : selecetedWord
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
        selecetedWord = searchWord[row]
        return searchWord[row]
    }
}
