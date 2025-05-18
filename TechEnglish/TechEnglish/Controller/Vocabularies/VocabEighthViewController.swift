import UIKit
import SnapKit
import AVFoundation
import UserNotifications

class VocabEighthViewController: UITableViewController,AVAudioPlayerDelegate, AVSpeechSynthesizerDelegate {
    
    let titleName: String
    let vocabularyList = VocabularyList()
    let synthesizer = AVSpeechSynthesizer()
    //     マナーモード時音鳴らすための宣言 AVAudioSession
    let audioSession = AVAudioSession.sharedInstance()
    // 通知の編集を可能にする定数宣言
    let content = UNMutableNotificationContent()
    let vobabList = VocabularyList()
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    //　　　　viewのセット
    private lazy var container: UIScrollView = {
        let container = UIScrollView()
        container.backgroundColor = UIColor.white
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName
        self.view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview() //中心点を親Viewと合わせる、全画面に窓を固定
        }
        
        container.snp.makeConstraints { make in
            make.width.equalTo(container.frameLayoutGuide)
            make.edges.equalTo(container.contentLayoutGuide)
        }
       
        do {
            // マナーモードでも音を鳴らすようにする
            try audioSession.setCategory(.playback)

        } catch {
            print("Audio Setting Failed.")
            return
        }
        // TableViewのcontentInsetを調整して、広告スペースを確保
        let bannerHeight: CGFloat = 50 // AdMobバナーの高さ
        tableView.contentInset.bottom = bannerHeight
        tableView.scrollIndicatorInsets.bottom = bannerHeight
        
        tableView.dataSource = self
        tableView.delegate  = self
        //CustomCellの登録
        tableView.register(TechWordTableViewCell.self, forCellReuseIdentifier: "cell")
    }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    //MARK: -Function
    // ハートボタンをタップした際の設定
    func CustomCellTapButtonCall(cell: UITableViewCell, pushTime: TimeInterval) {
        //タップしたcellの値
        guard let indexPathTapped = tableView.indexPath(for: cell) else
        {return}
        
        let contact = vocabularyList.otherSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited
        
        vocabularyList.otherSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        //タップしてときの値をpushメッセージに記載
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "eighth"]
        //通知設定
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
            // リマインドリストへの登録
            addRemindList(tappedRow: indexPathTapped.row, remindPattern: String(Int(pushTime)))
        } else {
            pushDelete()
        }
        
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    //RemindListへの追加
    func addRemindList(tappedRow: Int, remindPattern: String) {
        let sentence = vobabList.otherSentenceArray[0].names[tappedRow].name
        RemindManager.addRemindItem(sentence: sentence, remindPattern: remindPattern)
    }
    
    //MARK: -TableView
    //cellの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocabularyList.otherSentenceArray[0].names.count
    }
    //cellの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CustomTableViewCellの追加
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TechWordTableViewCell
        cell.eighthVC = self
        let contact = vocabularyList.otherSentenceArray[0].names[indexPath.row]
        //cellの文字指定
        cell.setCell(sentence: contact.name, pronunciation: vocabularyList.otherPronunciation[indexPath.row], meaning: vocabularyList.otherEnglish[indexPath.row], exampleSentence: vocabularyList.otherExampleSentence[indexPath.row])
        // 参考文テキストの文字色指定
        cell.exampleSentenceLabel.attributedText = cell.highlightKeyword(
            in: vocabularyList.otherExampleSentence[indexPath.row],
            keyword:contact.name)
            return cell
        }
//    セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    //cellをタップした時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //英語の読み上げ設定
        let utterance = AVSpeechUtterance.init(string: vocabularyList.otherSentence[indexPath.row])
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)

    }
    //MARK:- Push
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
    //push通知削除
    func pushDelete() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [content.title])
        
    }
}
    
    
