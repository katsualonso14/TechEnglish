
import UIKit

class UrlListController: UIViewController {
    
    let textField = UITextField()
    let addButton = UIButton(type: .system)
    let tableView = UITableView()
    var urls: [String] = []
    let userDefaultsKey = "savedUrls"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Web Stock"
        setupUI()
        loadUrls()
    }
    
    func setupUI() {
        textField.placeholder = NSLocalizedString("enter_url", comment: "")
        textField.borderStyle = .roundedRect
        
        addButton.setTitle(NSLocalizedString("add_button_title", comment: ""), for: .normal)
        addButton.addTarget(self, action: #selector(addUrl), for: .touchUpInside)
        
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
     UserDefaults.standard.set(urls, forKey: userDefaultsKey)
    }
    
    func loadUrls() {
        if let savedUrls = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            urls = savedUrls
        }
    }
    
    @objc func addUrl() {
        guard let urlText = textField.text, !urlText.isEmpty else { return }
        urls.append(urlText)
        saveUrl()
        tableView.reloadData()
        textField.text = ""
    }
}


extension UrlListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = urls[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedUrl = urls[indexPath.row]
        if let ulr = URL(string: urls[indexPath.row]) {
            let webVC = WebModalViewController()
            webVC.contentType = .url(selectedUrl)
            present(webVC, animated: true, completion: nil)
        }
    }
}
