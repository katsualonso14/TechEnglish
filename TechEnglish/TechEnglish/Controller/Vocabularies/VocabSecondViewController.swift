import UIKit
import SnapKit
import AVFoundation
import UserNotifications

class VocabSecondViewController: UITableViewController,AVAudioPlayerDelegate, AVSpeechSynthesizerDelegate {
    
    let titleName: String
    let vocabularyList = VocabularyList()
    let synthesizer = AVSpeechSynthesizer()
    //     マナーモード時音鳴らすための宣言 AVAudioSession
    let audioSession = AVAudioSession.sharedInstance()
    // 通知の編集を可能にする定数宣言
    let content = UNMutableNotificationContent()
    
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
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
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
        
        let contact = vocabularyList.secondSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        print(contact)
        let hasFavorited = contact.hasFavorited
        
        vocabularyList.secondSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        //タップしてときの値をpushメッセージに記載
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "second"]
        //通知設定
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
        } else {
            pushDelete()
        }
        
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    // ハートボタン2をタップした際の設定
    func CustomCellTapButtonCall2(cell: UITableViewCell, pushTime: TimeInterval) {
        //タップしたcellの値
        guard let indexPathTapped = tableView.indexPath(for: cell) else
        {return}
        
        let contact = vocabularyList.secondSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited2
        
        vocabularyList.secondSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited2 = !hasFavorited
        //タップしてときの値をpushメッセージに記載
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "second"]
        //通知設定
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
        } else {
            pushDelete()
        }
        
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    //MARK: -TableView
    //cellの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocabularyList.secondSentenceArray[0].names.count
    }
    //cellの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CustomTableViewCellの追加
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.secondVC = self
        let contact = vocabularyList.secondSentenceArray[0].names[indexPath.row]
        //cellの文字指定
        cell.setCell(sentence: contact.name, pronunciation: vocabularyList.secondPronunciation[indexPath.row], japanese: vocabularyList.secondEnglish[indexPath.row], exampleSentence: vocabularyList.secondExampleSentence[indexPath.row])
        
        cell.heartButton.tintColor = contact.hasFavorited ? .red : .gray
        cell.heartButton2.tintColor = contact.hasFavorited2 ? .orange : .gray

            return cell
        }
//    セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(220)
    }
    //cellをタップした時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //英語の読み上げ設定
        let utterance = AVSpeechUtterance.init(string: vocabularyList.secondSentence[indexPath.row])
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
    
    
