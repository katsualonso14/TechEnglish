import Foundation
import UIKit

class WordSeedViewController: UIViewController {
    let tableView = UITableView()
    let conteinerView = UIView()
    var QuickMemo = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredWords = [String]()
    var isSearching = false // 検索中かどうか判定
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "単語のタネ"
        setView()
        setDescriptionButton()
        setTableView()
        setAddButton()
        setResearchButton()
        setupSearchController()
        // 説明ダイアログが必要か確認
        checkIsDescription()
    }
    //MARK: - View Layout
    func setView() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conteinerView)
        
        NSLayoutConstraint.activate([
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            conteinerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            conteinerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setTableView() {
        conteinerView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .none // Remove default separator
        // 画面下部の広告スペースを確保
        let bannerHeight: CGFloat = 150 // AdMobバナーの高さ
        tableView.contentInset.bottom = bannerHeight
        tableView.horizontalScrollIndicatorInsets.bottom = bannerHeight
        
        self.QuickMemo = UserDefaults.standard.stringArray(forKey: "quick word") ?? []
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WordSeedCell.self, forCellReuseIdentifier: "QuickMemoCell")
    }
    
    func setAddButton() {
        let addButton = UIButton()
        addButton.backgroundColor = AppColors.appMainColor
        addButton.setTitle("+", for: UIControl.State())
        addButton.setTitleColor(.white, for: UIControl.State())
        addButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        addButton.layer.cornerRadius = 30
        addButton.layer.masksToBounds = true
        view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height * -0.1),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.02),
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setResearchButton() {
        let researchButton = UIButton()
        researchButton.backgroundColor = .systemBlue
        let searchImage = UIImage(systemName: "magnifyingglass")
        researchButton.setImage(searchImage, for: .normal)
        researchButton.tintColor = .white
        researchButton.addTarget(self, action: #selector(checkSearchWord), for: .touchUpInside)
        researchButton.layer.cornerRadius = 30
        researchButton.layer.masksToBounds = true
        view.addSubview(researchButton)
        
        researchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            researchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height * -0.19),
            researchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.02),
            researchButton.widthAnchor.constraint(equalToConstant: 60),
            researchButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setDescriptionButton() {
        let descriptionButton = UIButton(type: .system)
        descriptionButton.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        descriptionButton.tintColor = AppColors.appMainColor
        descriptionButton.addTarget(self, action: #selector(setDiscrptionView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: descriptionButton)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "単語を検索"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    //MARK: - Helper Function
    func checkIsDescription() {
        if !UserDefaults.standard.bool(forKey: "isDescription") {
            setDiscrptionView()
        }
    }
    
    // PhraseStoreに追加
    func addPhraseStore(word: String) {
        let phraseStoreVC = PhraseStoreViewController()
        let aleat = UIAlertController(title: "カスタム単語帳へ保存", message: "チェックした単語とともに例文作成とシチュエーションをメモできます。チェックした単語: \(word)", preferredStyle: .alert)
        
        aleat.addTextField{ (textField) in
            textField.placeholder = "例文を入力..."
        }
        aleat.addTextField{ (textField) in
            textField.placeholder = "シチュエーションを入力..."
        }
        
        aleat.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        aleat.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
            // 文字がない場合はエラーメッセージ
            if aleat.textFields?.first?.text == "" || aleat.textFields?[1].text == "" || aleat.textFields?.last?.text == "" {
                let alert = UIAlertController(title: "Error", message: "Please enter word and sentence", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true)
                return
            }
 
            //wordの追加
            DispatchQueue.main.async {
                var currentWord = UserDefaults.standard.array(forKey: "word") ?? []
                currentWord.append(word)
                UserDefaults.standard.setValue(currentWord, forKey: "word")
                phraseStoreVC.words.append(word)
                phraseStoreVC.tableView.reloadData()
            }
            
            if let filed = aleat.textFields?.first {
                if let text = filed.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        var currentSentence = UserDefaults.standard.array(forKey: "sentence") ?? []
                        currentSentence.append(text)
                        UserDefaults.standard.setValue(currentSentence, forKey: "sentence")
                        phraseStoreVC.sentences.append(text)
                        phraseStoreVC.tableView.reloadData()
                    }
                }
            }
            
            if let filed2 = aleat.textFields?.last {
                if let text2 = filed2.text, !text2.isEmpty {
                    DispatchQueue.main.async {
                        var currentSituation = UserDefaults.standard.array(forKey: "situation") ?? []
                        currentSituation.append(text2)
                        UserDefaults.standard.setValue(currentSituation, forKey: "situation")
                        phraseStoreVC.situation.append(text2)
                        phraseStoreVC.tableView.reloadData()
                    }
                }
            }
            
        }))
        
        present(aleat, animated: true)
    }
    // メモの編集処理
    func openEditMemo(quickMemo: String, index: Int) {
        let alert = UIAlertController(title: "Edit Quick Memo", message: "Edit Your Word", preferredStyle: .alert)
        
        alert.addTextField { $0.text = quickMemo }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            guard let textFields = alert.textFields,
                  let newWord = textFields[0].text, !newWord.isEmpty else {
                let errorAlert = UIAlertController(title: "Error", message: "Please enter word and sentence", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true)
                return
            }
            
            // データ更新
            self.QuickMemo[index] = newWord
            
            // UserDefaults の更新
            UserDefaults.standard.setValue(self.QuickMemo, forKey: "quick word")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }))
        
        present(alert, animated: true)
    }
    
    //MARK: - Function
    @objc func addTapped() {
        //add new cell
        let aleat = UIAlertController(title: "Save Quick Memo", message: "Add word", preferredStyle: .alert)
        aleat.addTextField{ (textField) in
            textField.placeholder = "Enter word..."
        }
        
        aleat.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        aleat.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
            // 文字がない場合はエラーメッセージ
            if aleat.textFields?.first?.text == "" || aleat.textFields?.last?.text == "" {
                let alert = UIAlertController(title: "Error", message: "Please enter word and sentence", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true)
                return
            }
 
            if let filed = aleat.textFields?.first {
                if let text = filed.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        var currentWord = UserDefaults.standard.array(forKey: "quick word") ?? []
                        currentWord.append(text)
                        UserDefaults.standard.setValue(currentWord, forKey: "quick word")
                        self?.QuickMemo.append(text)
                        self?.tableView.reloadData()
                    }
                }
            }
        }))
        
        present(aleat, animated: true)
    }
    
    @objc func checkSearchWord() {
        let modal = SelectSearchWordModal(frame: CGRect(x: 0, y: 0, width: 300, height: 300), parentVC: self)
        modal.searchWord = QuickMemo
        modal.center = view.center
        view.addSubview(modal)
    }

    @objc func setDiscrptionView() {
        let explanationView = DescriptionView(frame: CGRect(x: 50, y: 170, width: 330, height: 350))
        explanationView.center = view.center
        view.addSubview(explanationView)
    }
    
}

//MARK: - TableView DataSource
extension WordSeedViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return QuickMemo.count
    }
    // 各セクションに対して1つだけ入れるように設定(スペースのため）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //TODO: もう少し間を短くする
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        //最小限の高さを間に指定
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 1)
            ])
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuickMemoCell") as! WordSeedCell
        // Background view for selection
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
        selectedBackgroundView.layer.cornerRadius = 16
        selectedBackgroundView.layer.masksToBounds = true
        cell.selectedBackgroundView = selectedBackgroundView
        
        cell.label.text = QuickMemo[indexPath.section]
        
        return cell
    }
    //タップ処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addPhraseStore(word: QuickMemo[indexPath.section])
    }
    
    //Cellの編集と削除
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 編集
        let editAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            // 検索中の場合、フィルター時のインデックス指定
            if(self.isSearching) {
                let originalIndex = self.QuickMemo.firstIndex(of: self.filteredWords[indexPath.section]) ?? indexPath.section
                self.openEditMemo(
                    quickMemo: self.QuickMemo[originalIndex],
                    index: originalIndex
                )
            } else {
                self.openEditMemo(
                    quickMemo: self.QuickMemo[indexPath.section],
                    index: indexPath.section
                )
            }
            completionHandler(true)
        }

        // 削除
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, completionHandler) in
            // 検索中の場合、フィルター時のインデックス指定
            if(self.isSearching) {
                let originalIndex = self.QuickMemo.firstIndex(of: self.filteredWords[indexPath.section]) ?? indexPath.section
                self.QuickMemo.remove(at: originalIndex)

                self.filteredWords.remove(at: indexPath.section)
            } else {
                self.QuickMemo.remove(at: indexPath.section)
            }
    
            UserDefaults.standard.setValue(self.QuickMemo, forKey: "quick word")
            tableView.deleteSections([indexPath.section], with: .fade) // セクションで設定しているため、セクション削除
            completionHandler(true)
        }
        
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .systemBlue
        
        deleteAction.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

//MARK: - Search
extension WordSeedViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }
        
        isSearching = true
        filteredWords.removeAll()
        
        for (index, word) in QuickMemo.enumerated() {
            // wordsにsearchTextが含まれているかどうか
            if word.lowercased().contains(searchText.lowercased()) {
                filteredWords.append(word)
            }
        }
        tableView.reloadData()
    }
}




