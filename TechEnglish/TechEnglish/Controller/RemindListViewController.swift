
import UIKit


class RemindListController: UITableViewController {
    var remindItems: [RemindItem] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("remind_tab_button", comment: "")
        
        loadRemind()
        setDeleteNotifButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name("addRemind"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteData(_:)), name: Notification.Name("deleteRemind"), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RemindListCell.self, forCellReuseIdentifier: "remindCell")
    }

    //MARK: - Layout
    func setDeleteNotifButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = AppColors.appMainColor
        button.addTarget(self, action: #selector(openAllNotifDeleteAleart), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
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

    // ローカルのremindItems更新
    func saveRemindItemsToLocal() {
        if let data = try? JSONEncoder().encode(remindItems) {
            UserDefaults.standard.set(data, forKey: "remindItems")
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



