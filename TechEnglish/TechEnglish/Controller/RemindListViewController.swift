
import UIKit


class RemindListController: UITableViewController {
    var sentences: [String] = []
   
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
        if let remindArray = UserDefaults.standard.stringArray(forKey: "remind") {
            sentences = remindArray
        }
        tableView.reloadData()
    }
    
    //MARK: Delete Notification
    //全ての通知を削除する処理
    func deleteAllNotif() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        //全ての通知を削除しましたのダイアログ表示
        let alert = UIAlertController(
            title: NSLocalizedString("delete_all_notif_finish_title", comment: ""),
            message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // RemidListから全データ削除
    func deleteAllRemindList() {
        // ローカルの remind 配列を空にする
        UserDefaults.standard.set([], forKey: "remind")
    }

    
    //MARK: -objc
    @objc func updateData(_ notification: Notification) {
        guard let data = notification.userInfo as? [String: String] else { return }
        //TODO: 複数を許容するか要確認
            sentences.append(data["sentence"]!)
            tableView.reloadData()
    }
    
    @objc func deleteData(_ notification: Notification) {
        guard let tapSentence = notification.userInfo?["sentence"] as? String else { return }
        guard let rowIndex = sentences.firstIndex(of: tapSentence) else { return }
        sentences.remove(at: rowIndex)
        // TableViewの行を削除
        tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
    }
    
    // 全てのリマインドを削除
    @objc func openAllNotifDeleteAleart(){
        let alert = UIAlertController(title: NSLocalizedString("delete_all_remind_title", comment: ""),
                                      message: NSLocalizedString("delete_all_remind_message", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive, handler: { [self] _ in
            deleteAllNotif()
            deleteAllRemindList()
            loadRemind()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: -Tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentences.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "remindCell") as! RemindListCell
        cell.setCell(sentence: sentences[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //TODO: タップ時に発音を
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
    }
    
}



