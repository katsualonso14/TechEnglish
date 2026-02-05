import Foundation
import UIKit

class MyCardsViewController: UIViewController, MyCardsInputDelegate {
    let tableView = UITableView()
    let conteinerView = UIView()
    var myCards: [MyCard] = []
    var filteredMyCards: [MyCard] = []
    let searchController = UISearchController(searchResultsController: nil)
    var isSearching = false // 検索中かどうか判定
    let content = UNMutableNotificationContent() // 通知の編集を可能にする定数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Cards"
        setView()
        setTableView()
        setupSearchController()
        setupRightNavBarButton()
    }
    //MARK: - View Layout
    func setView() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conteinerView)
        
        NSLayoutConstraint.activate([
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            conteinerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            conteinerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
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
        loadFromUserDefaults()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyCardsCell.self, forCellReuseIdentifier: "MyCardsCell")
    }
    
    func setResearchButton() {
        let researchButton = UIButton()
        researchButton.backgroundColor = .systemBlue
        let searchImage = UIImage(systemName: "magnifyingglass")
        researchButton.setImage(searchImage, for: .normal)
        researchButton.tintColor = .white
        researchButton.addTarget(self, action: #selector(checkSearchWord), for: .touchUpInside)
        researchButton.layer.cornerRadius = 36
        
        researchButton.layer.shadowColor = UIColor.black.cgColor
        researchButton.layer.shadowOpacity = 0.3
        researchButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        researchButton.layer.shadowRadius = 6
        view.addSubview(researchButton)
        
        researchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            researchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height * -0.19),
            researchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.02),
            researchButton.widthAnchor.constraint(equalToConstant: 72),
            researchButton.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    
    func setupRightNavBarButton() {
        let webReseachButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(checkSearchWord))
        webReseachButton.tintColor = AppColors.appMainColor
        
        let addButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(openAddMyCardModal))
        addButton.tintColor = AppColors.appMainColor
    
        navigationItem.rightBarButtonItems = [webReseachButton, addButton]
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "")
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    //MARK: - Helper Function
    // メモの編集処理
    func openEditMyCard(editingCard: MyCard, index: Int) {
        let modal = MyCardsInputViewController()
        modal.delegate = self
        modal.editMode = true
        modal.currentIndex = index
        modal.myWordsTextView.text = editingCard.word
        modal.setenceTextView.text = editingCard.sentence
        present(modal, animated: true)
    }
    
    func loadFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "myCards"),
           let decoded = try? JSONDecoder().decode([MyCard].self, from: data) {
            myCards = decoded
        }
    }

    func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(myCards) {
            UserDefaults.standard.set(encoded, forKey: "myCards")
        }
    }
    
    // MARK: - MemoInputDelegate
    func didSaveMyCards(frontText: String, backText: String) {
        myCards.append(MyCard(word: frontText, sentence: backText))
        saveToUserDefaults()
        tableView.reloadData()
    }
    
    func didSaveEditMyCards(frontText: String, backText: String, index: Int) {
            myCards[index].word = frontText
            myCards[index].sentence = backText
            saveToUserDefaults()
            tableView.reloadData()
    }
    // フィルター時の編集内容を即時反映
    func saveEditFilterdMyCards() {
        if isSearching, let searchText = searchController.searchBar.text {
            filteredMyCards = myCards.filter {
                $0.word.contains(searchText) || $0.sentence.contains(searchText)
            }
        }
        tableView.reloadData()
    }
    
    //MARK: - Notification
    func ReminderCall(indexPath: IndexPath, pushTime: TimeInterval) {
        
        //タップしてときの値をpushメッセージに記載
        content.title = NSLocalizedString("my_cards_remind_title", comment: "")
        content.body = isSearching ? filteredMyCards[indexPath.section].word : myCards[indexPath.section].word
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "myCards"]
        //通知設定
        pushRegister(pushTime: pushTime)
        // リマインドリストに追加
        addRemindList(tappedRow: indexPath.section, remindPattern: String(Int(pushTime)))
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    //プッシュ通知登録
    func pushRegister(pushTime: TimeInterval) {
        let notificationCenter = UNUserNotificationCenter.current()
        // 受け取った時間をリピート通知
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: pushTime, repeats: true)
        //通知のID(identifier,タイトル,内容、トリガーを設定 )
        let request = UNNotificationRequest(identifier: content.title, content: content, trigger: trigger)
        print("request is \(request.content.title)")
        
        notificationCenter.add(request) {
            (error) in
            if error != nil {
            print(error.debugDescription)
            }
        }
    }
    
    //RemindListへの追加
    func addRemindList(tappedRow: Int, remindPattern: String) {
        let sentence = isSearching ? filteredMyCards[tappedRow].sentence : myCards[tappedRow].word
        RemindManager.addRemindItem(sentence: sentence, remindPattern: remindPattern)
    }
    
    //MARK: - objc
    @objc func checkSearchWord() {
        let modal = SelectSearchWordModal(frame: CGRect(x: 0, y: 0, width: 300, height: 300), parentVC: self)
        modal.searchWord = myCards.map { $0.word }
        modal.center = view.center
        view.addSubview(modal)
    }
    
    // メモ追加モーダル表示
    @objc func openAddMyCardModal() {
        let inputVC = MyCardsInputViewController()
        inputVC.delegate = self
        if #available(iOS 15.0, *) {
            if let sheet = inputVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
            }
        }
        present(inputVC, animated: true)
    }
    
}

//MARK: - TableView DataSource
extension MyCardsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return filteredMyCards.count
        } else {
            return myCards.count
        }
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
        return 90
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCardsCell") as! MyCardsCell
        cell.delegate = self
        // Background view for selection
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
        selectedBackgroundView.layer.cornerRadius = 16
        selectedBackgroundView.layer.masksToBounds = true
        cell.selectedBackgroundView = selectedBackgroundView
        
        
        if isSearching {
            cell.label.text = filteredMyCards[indexPath.section].word
            cell.backViewLabel.text = filteredMyCards[indexPath.section].sentence.isEmpty ? NSLocalizedString("no_sentence", comment: "") :
            filteredMyCards[indexPath.section].sentence
        } else {
            cell.label.text = myCards[indexPath.section].word
            cell.backViewLabel.text = myCards[indexPath.section].sentence.isEmpty ? NSLocalizedString("no_sentence", comment: "") :
            myCards[indexPath.section].sentence
        }
        
        return cell
    }
    //タップ処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MyCardsCell {
            cell.flip()
        }
    }
    
    //Cellの編集と削除
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 編集
        let editAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            // 検索中の場合、フィルター時のインデックス指定
            if(self.isSearching) {
                let originalIndex =
                self.myCards.firstIndex(where: { $0.word == self.filteredMyCards.map { $0.word }[indexPath.section] }) ?? indexPath.section
                self.openEditMyCard(editingCard: self.myCards[originalIndex], index: originalIndex)
            } else {
                self.openEditMyCard(editingCard: self.myCards[indexPath.section], index: indexPath.section)
            }
            completionHandler(true)
        }

        // 削除
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, completionHandler) in
            // 検索中の場合、フィルター時のインデックス指定
            if(self.isSearching) {
                let originalIndex =
                self.myCards.firstIndex(where: { $0.word == self.filteredMyCards.map { $0.word }[indexPath.section] }) ?? indexPath.section
                self.myCards.remove(at: originalIndex)
                self.filteredMyCards.remove(at: indexPath.section)
            } else {
                self.myCards.remove(at: indexPath.section)
                print("Delete myCards: \(self.myCards)")
            }
    
            self.saveToUserDefaults()
            tableView.deleteSections([indexPath.section], with: .fade) // セクションで設定しているため、セクション削除
            completionHandler(true)
        }
        
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = UIColor.systemBlue
        
        deleteAction.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

//MARK: - Search
extension MyCardsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }
        
        isSearching = true
        filteredMyCards.removeAll()

        for (index, card) in myCards.enumerated() {
            // wordにsearchTextが含まれているかどうか
            if card.word.lowercased().contains(searchText.lowercased()) {
                filteredMyCards.append(card)
            }
        }

        tableView.reloadData()
    }
}

extension MyCardsViewController: MyCardsCellDelegate {
    func didTapReminderButton(in cell: MyCardsCell, pushTime: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        ReminderCall(indexPath: indexPath, pushTime: TimeInterval(pushTime))
    }
}




