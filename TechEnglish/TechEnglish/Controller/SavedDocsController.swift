import UIKit
import SwiftLinkPreview
import FirebaseAnalytics

class SavedDocsController: UIViewController {
    
    let textField = UITextField()
    let addButton = UIButton(type: .system)
    let tableView = UITableView()
    let userDefaultsKey = "savedUrls"
    var webMetas: [WebMeta] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Saved Docs"
        setupUI()
        loadUrls()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: "saved_docs"
        ])
    }
    
    func setupUI() {
        textField.placeholder = NSLocalizedString("enter_url", comment: "")
        textField.borderStyle = .roundedRect
        
        addButton.setTitle(NSLocalizedString("add_button_title", comment: ""), for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addButton.addTarget(self, action: #selector(addUrl), for: .touchUpInside)
        addButton.backgroundColor = AppColors.appMainColor
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 8
        addButton.layer.masksToBounds = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(textField)
        view.addSubview(addButton)
        view.addSubview(tableView)
        textField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
             textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
             textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             textField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8),
             textField.heightAnchor.constraint(equalToConstant: 40),
             
             addButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
             addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
             addButton.widthAnchor.constraint(equalToConstant: 60),
             
             tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         ])
    }
    
    func saveUrl() {
        // save to UserDefaults after encoding
        let encoded = try? JSONEncoder().encode(webMetas)
        UserDefaults.standard.set(encoded, forKey: userDefaultsKey)

    }
    
    func loadUrls() {
        // load from UserDefaults after decoding
        if let savedUrls = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([WebMeta].self, from: savedUrls) {
            webMetas = decoded
        }
        tableView.reloadData()
    }
    
     @objc func addUrl() {
        guard let userInputURL = textField.text, !userInputURL.isEmpty else { return }
        let slp = SwiftLinkPreview()
         
        // Use SwiftLinkPreview to fetch the URL preview
        slp.preview(
            userInputURL,
            onSuccess: { preview in
                let title = preview.title ?? "No Title"
                let url = preview.finalUrl ?? URL(string: userInputURL)
                let domain = url?.host ?? "Unknown"
                let icon = preview.image
                let meta = WebMeta(title: title, url: url!.absoluteString, domain: domain, faviconURL: icon)
                self.webMetas.insert(meta, at: 0)
                self.tableView.reloadData()
                self.saveUrl()
                self.textField.text = ""
                Analytics.logEvent("add_saved_doc", parameters: ["domain": domain])
            },
            onError: { error in
                print("Error: \(error)")
                self.textField.text = ""
                let alert = UIAlertController(title: "Error", message: "Failed to fetch URL preview.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        )
    }

}


extension SavedDocsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webMetas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = webMetas[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedUrl = webMetas[indexPath.row].url
        if let ulr = URL(string: webMetas[indexPath.row].url) {
            let webVC = WebModalViewController()
            webVC.contentType = .url(selectedUrl)
            present(webVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Delete cell process
        if editingStyle == .delete {
            webMetas.remove(at: indexPath.row)
            saveUrl()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
