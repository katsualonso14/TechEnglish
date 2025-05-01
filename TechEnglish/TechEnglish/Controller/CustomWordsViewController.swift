import UIKit

class CustomWordsViewController: UIViewController {
    let tableView = UITableView()
    let conteinerView = UIView()
    //TODO: UseDefaultsの値のみで良い場合は削除を検討
    var words = [String]()
    var sentences = [String]()
    var situation = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredWords = [String]()
    var filteredSentences = [String]()
    var filteredSituations = [String]()
    var isSearching = false // 検索中かどうか判定
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("custom_word_list_tab_button", comment: "")
        setView()
        setTableView()
        setAddButton()
        setupSearchController()
        updateBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 遷移のたびに確認
        words = UserDefaults.standard.stringArray(forKey: "word") ?? []
        sentences = UserDefaults.standard.stringArray(forKey: "sentence") ?? []
        situation = UserDefaults.standard.stringArray(forKey: "situation") ?? []
        tableView.reloadData()
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
        tableView.backgroundColor = .systemGray6
        // 画面下部の広告スペースを確保
        let bannerHeight: CGFloat = 150 // AdMobバナーの高さ
        tableView.contentInset.bottom = bannerHeight
        tableView.horizontalScrollIndicatorInsets.bottom = bannerHeight
        
        self.words = UserDefaults.standard.stringArray(forKey: "word") ?? []
        self.sentences = UserDefaults.standard.stringArray(forKey: "sentence") ?? []
        self.situation = UserDefaults.standard.stringArray(forKey: "situation") ?? []
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomWordsCell.self, forCellReuseIdentifier: "CustomWordsCell")
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
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    // cellのが0の場合の背景
    func updateBackgroundView() {
        if words.isEmpty {
            let emptyView = UIView(frame: tableView.bounds)
            emptyView.backgroundColor = AppColors.backgroundColorCheckMode
            emptyView.layer.cornerRadius = 16
            emptyView.layer.masksToBounds = true

            let label = UILabel()
            let explanationText = """
            🔹 message:
            
            No phrases added yet.
            Save words, create example sentences, and add notes about their meanings or the situations where you found them.
            
            🔹 Example:
            
            Word: existing
            Sentence: The existing system needs to be updated to improve performance.
            Memo: It appears in the error message if it is a duplicate of something that already exists.
            """
            label.text = explanationText
            label.textAlignment = .left
            label.numberOfLines = 0
            label.frame = CGRect(x: 40, y: 50, width: 300, height: 300)
            label.font = .systemFont(ofSize: 16)

            emptyView.addSubview(label)
            tableView.backgroundView = emptyView
        } else {
            tableView.backgroundView = nil
        }
    }
    
    //MARK: - Function
    @objc func addTapped() {
        //add new cell
        let aleat = UIAlertController(title: "New Notes", message: "add word and sentence", preferredStyle: .alert)
        
        aleat.addTextField{ (textField) in
            textField.placeholder = "Enter word..."
        }
        aleat.addTextField{ (textField) in
            textField.placeholder = "Enter sentence..."
        }
        aleat.addTextField{ (textField) in
            textField.placeholder = "Enter memo..."
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
 
        
            if let filed = aleat.textFields?.first {
                if let text = filed.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        var currentWord = UserDefaults.standard.array(forKey: "word") ?? []
                        currentWord.append(text)
                        UserDefaults.standard.setValue(currentWord, forKey: "word")
                        self?.words.append(text)
                        self?.tableView.reloadData()
                    }
                }
            }
            
            if let filed2 = aleat.textFields?[1] {
                if let text2 = filed2.text, !text2.isEmpty {
                    DispatchQueue.main.async {
                        var currentSentence = UserDefaults.standard.array(forKey: "sentence") ?? []
                        currentSentence.append(text2)
                        UserDefaults.standard.setValue(currentSentence, forKey: "sentence")
                        self?.sentences.append(text2)
                        self?.tableView.reloadData()
                    }
                }
            }
            
            if let filed3 = aleat.textFields?.last {
                if let text3 = filed3.text, !text3.isEmpty {
                    DispatchQueue.main.async {
                        var currentSituation = UserDefaults.standard.array(forKey: "situation") ?? []
                        currentSituation.append(text3)
                        UserDefaults.standard.setValue(currentSituation, forKey: "situation")
                        self?.situation.append(text3)
                        self?.tableView.reloadData()
                        // 0個のcellでなくなった際の背景更新
                        self?.updateBackgroundView()
                    }
                }
            }
            
        }))
        
        present(aleat, animated: true)
    }
    // メモの編集処理
    func openEditMemo(word: String, sentence: String, situation: String, index: Int) {
        let alert = UIAlertController(
            title: NSLocalizedString("edit_custom_word_list_title", comment: ""),
            message: NSLocalizedString("edit_custom_word_list_message", comment: ""),
            preferredStyle: .alert)
        
        alert.addTextField { $0.text = word }
        alert.addTextField { $0.text = sentence }
        alert.addTextField { $0.text = situation }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            guard let textFields = alert.textFields,
                  let newWord = textFields[0].text, !newWord.isEmpty,
                  let newSentence = textFields[1].text, !newSentence.isEmpty,
                  let newSituation = textFields[2].text, !newSituation.isEmpty else {
                let errorAlert = UIAlertController(
                    title: "Error",
                    message: NSLocalizedString("edit_custom_word_list_error_message", comment: ""),
                    preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true)
                return
            }
            
            // データ更新
            self.words[index] = newWord
            self.sentences[index] = newSentence
            self.situation[index] = newSituation
            
            // UserDefaults の更新を一回でまとめる
            UserDefaults.standard.setValue(self.words, forKey: "word")
            UserDefaults.standard.setValue(self.sentences, forKey: "sentence")
            UserDefaults.standard.setValue(self.situation, forKey: "situation")
            
            // テーブルをリロード（UI更新はメインスレッドで）
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }))
        
        present(alert, animated: true)
    }

}


//MARK: - TableView DataSource
extension CustomWordsViewController: UITableViewDataSource, UITableViewDelegate {
    // テーブルビューのセクション数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return min(filteredWords.count, filteredSentences.count, filteredSituations.count)
        } else {
            return min(words.count, sentences.count, situation.count)
        }
    }

    
    // テーブルビューのセルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomWordsCell") as! CustomWordsCell
        // Background view for selection
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
        selectedBackgroundView.layer.cornerRadius = 16
        selectedBackgroundView.layer.masksToBounds = true
        cell.selectedBackgroundView = selectedBackgroundView
        
        guard indexPath.row < (isSearching ? filteredWords.count : words.count),
              indexPath.row < (isSearching ? filteredSentences.count : sentences.count),
              indexPath.row < (isSearching ? filteredSituations.count : situation.count) else {
            return cell
        }
        
        let word = isSearching ? filteredWords[indexPath.row] : words[indexPath.row]
        let sentence = isSearching ? filteredSentences[indexPath.row] : sentences[indexPath.row]
        let situation = isSearching ? filteredSituations[indexPath.row] : situation[indexPath.row]

        cell.label.text = "Word: \(word)"
        cell.secondLabel.text = "Sentence: \(sentence)"
        cell.thirdLabel.text = "Memo: \(situation)"
        
        return cell
    }

    
    //セルの高さ
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    //Cellの編集と削除
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 編集アクション
        let editAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            // 検索中の場合、フィルター時のインデックス指定
            if(self.isSearching) {
                let originalIndex = self.words.firstIndex(of: self.filteredWords[indexPath.row]) ?? indexPath.row
                self.openEditMemo(
                    word: self.words[originalIndex],
                    sentence: self.sentences[originalIndex],
                    situation: self.situation[originalIndex],
                    index: originalIndex
                )
            } else {
                self.openEditMemo(
                    word: self.words[indexPath.row],
                    sentence: self.sentences[indexPath.row],
                    situation: self.situation[indexPath.row],
                    index: indexPath.row
                )
            }
            completionHandler(true)
        }

        // 削除アクション
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, completionHandler) in
            // 検索中の場合、フィルター時のインデックス指定
            if(self.isSearching) {
                let originalIndex = self.words.firstIndex(of: self.filteredWords[indexPath.row]) ?? indexPath.row
                self.words.remove(at: originalIndex)
                self.sentences.remove(at: originalIndex)
                self.situation.remove(at: originalIndex)

                self.filteredWords.remove(at: indexPath.row)
                self.filteredSentences.remove(at: indexPath.row)
                self.filteredSituations.remove(at: indexPath.row)
            } else {
                self.words.remove(at: indexPath.row)
                self.sentences.remove(at: indexPath.row)
                self.situation.remove(at: indexPath.row)
            }
            
            UserDefaults.standard.setValue(self.words, forKey: "word")
            UserDefaults.standard.setValue(self.sentences, forKey: "sentence")
            UserDefaults.standard.setValue(self.situation, forKey: "situation")
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .systemBlue
        deleteAction.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }



    
}
//MARK: - Search
extension CustomWordsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }

        isSearching = true
        filteredWords.removeAll()
        filteredSentences.removeAll()
        filteredSituations.removeAll()

        for (index, word) in words.enumerated() {
            let sentence = sentences[index]
            let situ = situation[index]

            // words, sentences, situation のどれかに検索ワードが含まれていたら追加
            if word.lowercased().contains(searchText.lowercased()) ||
               sentence.lowercased().contains(searchText.lowercased()) ||
               situ.lowercased().contains(searchText.lowercased()) {
                filteredWords.append(word)
                filteredSentences.append(sentence)
                filteredSituations.append(situ)
            }
        }
        tableView.reloadData()
    }


}




