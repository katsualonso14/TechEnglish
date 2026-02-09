
import UIKit
import FirebaseFirestore


class RemindListController: UITableViewController {
    var remindItems: [RemindItem] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("remind_tab_button", comment: "")
        
        setupDeleteNotifButton()
        loadRemind()
        setupLeftBarButtons()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name("addRemind"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteData(_:)), name: Notification.Name("deleteRemind"), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RemindListCell.self, forCellReuseIdentifier: "remindCell")
    }

    //MARK: -Layout
    func setupDeleteNotifButton() {
        let deleteButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(openAllNotifDeleteAleart)
        )
        deleteButton.tintColor = AppColors.appMainColor
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    func setupLeftBarButtons() {
        let feedbackButton = UIBarButtonItem(
            image: UIImage(systemName: "bubble.left.and.bubble.right"),
            style: .plain,
            target: self,
            action: #selector(openFeedbackModal)
        )
        feedbackButton.tintColor = AppColors.appMainColor

        let descriptionButton = UIBarButtonItem(
            image: UIImage(systemName: "questionmark.circle"),
            style: .plain,
            target: self,
            action: #selector(showDescriptionView)
        )
        descriptionButton.tintColor = AppColors.appMainColor

        navigationItem.leftBarButtonItems = [feedbackButton, descriptionButton]
    }
    
    //MARK: -Function
    //リマインドのローカルからの読み込み
    func loadRemind() {
        if let data = UserDefaults.standard.data(forKey: "remindItems") {
            if let decoded = try? JSONDecoder().decode([RemindItem].self, from: data) {
                remindItems = decoded
            }
        }
        tableView.reloadData()
    }

    // ローカルのremindItems更新
    func saveRemindItemsToLocal() {
        if let data = try? JSONEncoder().encode(remindItems) {
            UserDefaults.standard.set(data, forKey: "remindItems")
        }
    }

    //MARK: Delete Notification
    //全ての通知を削除する処理
    func showDeleteAllDoneAlert() {
        //全ての通知を削除しましたのダイアログ表示
        let alert = UIAlertController(
            title: NSLocalizedString("delete_all_notif_finish_title", comment: ""),
            message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // RemidListから全データ削除
    func deleteAllRemindList() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        
        UserDefaults.standard.set([], forKey: "remindItems")
        remindItems.removeAll()
        tableView.reloadData()
    }
    // Store feedback to Firestore
    func saveFeedbackToFirestore(feedback: String) {
        let db = Firestore.firestore()
        db.collection("feedbacks").addDocument(data: [
            "feedback": feedback,
            "timestamp": Timestamp(date: Date())
        ]) { error in
            if let error = error {
                print("Error saving feedback: \(error.localizedDescription)")
            } else {
                print("Feedback successfully saved!")
            }
        }
    }
    
    //MARK: -objc
    @objc func updateData(_ notification: Notification) {
        guard let data = notification.userInfo as? [String: String],
              let sentence = data["sentence"],
              let pattern = data["remindPattern"] else { return }
        
        let newItem = RemindItem(sentence: sentence, remindPattern: pattern)
        remindItems.append(newItem)

        // 保存
        if let encoded = try? JSONEncoder().encode(remindItems) {
            UserDefaults.standard.set(encoded, forKey: "remindItems")
        }

        tableView.reloadData()
    }

    
    @objc func deleteData(_ notification: Notification) {
        guard let tapSentence = notification.userInfo?["sentence"] as? String else { return }
        guard let rowIndex = remindItems.firstIndex(where: { $0.sentence == tapSentence }) else { return }
        remindItems.remove(at: rowIndex)// 配列から削除
        // TableViewの行を削除
        tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
        saveRemindItemsToLocal()// ローカル保存も更新
    }
    
    // 全てのリマインドを削除
    @objc func openAllNotifDeleteAleart(){
        let alert = UIAlertController(title: NSLocalizedString("delete_all_remind_title", comment: ""),
                                      message: NSLocalizedString("delete_all_remind_message", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive, handler: { [self] _ in
            deleteAllRemindList()
            showDeleteAllDoneAlert()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showDescriptionView() {
        let vc = DescriptionViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }

    @objc func openFeedbackModal() {
        let alert = UIAlertController(title: "Feedback",
                                      message: NSLocalizedString("feedback_massage", comment: ""),
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Feedback"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            if let feedback = alert.textFields?.first?.text , !feedback.isEmpty {
                // Save feedback to Firestore
                self.saveFeedbackToFirestore(feedback: feedback)
            } else {
                // Show error message
                let errorAlert = UIAlertController(title: "Error", message: "Please enter feedback.", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: -Tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remindItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "remindCell") as! RemindListCell
        cell.setCell(sentence: remindItems[indexPath.row].sentence, pattern: remindItems[indexPath.row].remindPattern)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 変数・テーブルのcell・ローカルデータを削除
        if editingStyle == .delete {
            let sentence = remindItems[indexPath.row].sentence
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [sentence])
            
            
            remindItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveRemindItemsToLocal()
        }
    }
    
    //TODO: タップ時に発音を
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
    }
    
}



