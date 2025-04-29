import UIKit
import WebKit

class WebModalViewController: UIViewController {
    private let webContainer = WebViewContainer()
    var contentType: WebContentType?

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
        view.addSubview(webContainer)
        
        // TODO: ユーザーの言語圏で切り分ける
        // search google about selected word
        loadContent()
    }

    private func setupCloseButton() {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.frame = CGRect(x: self.view.frame.width - 53, y: 0, width: 50, height: 50)
        button.tintColor = AppColors.appMainColor
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(button)
    }
    
    private func loadContent() {
        guard let contentType = contentType else { return }
        let urlString: String
        
        switch contentType {
        case .word(let word):
            urlString = "https://www.google.com/search?q=\(word) 意味"
        case .url(let url):
            urlString = url
        }
        if let url = URL(string: urlString) {
            webContainer.loadURL(urlString)
        }
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}

