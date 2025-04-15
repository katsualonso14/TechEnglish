import UIKit
import WebKit

class WebModalViewController: UIViewController {
    private let webContainer = WebViewContainer()
    var selectedWord: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        setupCloseButton()
    }

    private func setupView() {
        webContainer.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height - 50)
        webContainer.layer.cornerRadius = 16
        webContainer.layer.masksToBounds = true
        // search google about selected word
        if let selectedWord = selectedWord {
            webContainer.loadURL("https://www.google.com/search?q=\(selectedWord) 意味")
        }
        view.addSubview(webContainer)
    }

    private func setupCloseButton() {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.frame = CGRect(x: self.view.frame.width - 53, y: 0, width: 50, height: 50)
        button.tintColor = AppColors.appMainColor
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}

