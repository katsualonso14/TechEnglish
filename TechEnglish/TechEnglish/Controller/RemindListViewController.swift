import UIKit
import FirebaseFirestore

class RemindListController: UITableViewController {
    
    var remindItems: [RemindItem] = []
   
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyEditorTheme()
        navigationItem.title = NSLocalizedString("remind_tab_button", comment: "")
        
        setupDeleteNotifButton()
        loadRemind()
        setupLeftBarButtons()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name("addRemind"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteData(_:)), name: Notification.Name("deleteRemind"), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RemindListCell.self, forCellReuseIdentifier: "remindCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 72
    }
    
    // MARK: - Theme
    
    private func applyEditorTheme() {
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = EditorTheme.editorBackground
        tableView.backgroundColor = EditorTheme.editorBackground
    }

    // MARK: - Layout
    
    func setupDeleteNotifButton() {
        let deleteButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(openAllNotifDeleteAleart)
        )
        deleteButton.tintColor = EditorTheme.accentError
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    func setupLeftBarButtons() {
        let feedbackButton = UIBarButtonItem(
            image: UIImage(systemName: "bubble.left.and.bubble.right"),
            style: .plain,
            target: self,
            action: #selector(openFeedbackModal)
        )
        feedbackButton.tintColor = EditorTheme.accentPrimary

        let descriptionButton = UIBarButtonItem(
            image: UIImage(systemName: "questionmark.circle"),
            style: .plain,
            target: self,
            action: #selector(showDescriptionView)
        )
        descriptionButton.tintColor = EditorTheme.accentPrimary

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

    // MARK: - Delete Notification
    
    func showDeleteAllDoneAlert() {
        let alert = UIAlertController(
            title: "✓ \(NSLocalizedString("delete_all_notif_finish_title", comment: ""))",
            message: nil,
            preferredStyle: .alert
        )
        alert.overrideUserInterfaceStyle = .dark
        alert.view.tintColor = EditorTheme.accentSuccess
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
    
    // MARK: - Notification Handlers
    
    @objc func updateData(_ notification: Notification) {
        guard let data = notification.userInfo as? [String: String],
              let sentence = data["sentence"],
              let pattern = data["remindPattern"] else { return }
        
        let newItem = RemindItem(sentence: sentence, remindPattern: pattern)
        remindItems.append(newItem)

        if let encoded = try? JSONEncoder().encode(remindItems) {
            UserDefaults.standard.set(encoded, forKey: "remindItems")
        }

        tableView.reloadData()
    }
    
    @objc func deleteData(_ notification: Notification) {
        guard let tapSentence = notification.userInfo?["sentence"] as? String else { return }
        guard let rowIndex = remindItems.firstIndex(where: { $0.sentence == tapSentence }) else { return }
        remindItems.remove(at: rowIndex)
        tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
        saveRemindItemsToLocal()
    }
    
    @objc func openAllNotifDeleteAleart() {
        let alert = UIAlertController(
            title: "⚠️ \(NSLocalizedString("delete_all_remind_title", comment: ""))",
            message: NSLocalizedString("delete_all_remind_message", comment: ""),
            preferredStyle: .alert
        )
        alert.overrideUserInterfaceStyle = .dark
        alert.view.tintColor = EditorTheme.accentError
        
        let deleteAction = UIAlertAction(
            title: "$ rm -rf *",
            style: .destructive,
            handler: { [self] _ in
                deleteAllRemindList()
                showDeleteAllDoneAlert()
            }
        )
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showDescriptionView() {
        let vc = DescriptionViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }

    @objc func openFeedbackModal() {
        let alert = UIAlertController(
            title: "// Feedback",
            message: NSLocalizedString("feedback_massage", comment: ""),
            preferredStyle: .alert
        )
        alert.overrideUserInterfaceStyle = .dark
        alert.view.tintColor = EditorTheme.accentPrimary
        
        alert.addTextField { textField in
            textField.placeholder = "Enter your feedback..."
            textField.font = EditorFonts.mono(size: EditorFonts.Size.body)
            textField.backgroundColor = EditorTheme.editorBackground
            textField.textColor = EditorTheme.textDefault
            textField.keyboardAppearance = .dark
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "$ submit", style: .default, handler: { _ in
            if let feedback = alert.textFields?.first?.text, !feedback.isEmpty {
                self.saveFeedbackToFirestore(feedback: feedback)
                self.showFeedbackSuccessAlert()
            } else {
                self.showFeedbackErrorAlert()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func showFeedbackSuccessAlert() {
        let alert = UIAlertController(
            title: "✓ Submitted",
            message: "Thank you for your feedback!",
            preferredStyle: .alert
        )
        alert.overrideUserInterfaceStyle = .dark
        alert.view.tintColor = EditorTheme.accentSuccess
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showFeedbackErrorAlert() {
        let alert = UIAlertController(
            title: "// Error",
            message: "Please enter feedback.",
            preferredStyle: .alert
        )
        alert.overrideUserInterfaceStyle = .dark
        alert.view.tintColor = EditorTheme.accentError
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remindItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "remindCell") as! RemindListCell
        cell.setCell(sentence: remindItems[indexPath.row].sentence, pattern: remindItems[indexPath.row].remindPattern)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sentence = remindItems[indexPath.row].sentence
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [sentence])
            
            remindItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveRemindItemsToLocal()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



