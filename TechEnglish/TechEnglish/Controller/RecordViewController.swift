
import UIKit
import FSCalendar
import RealmSwift
import CalculateCalendarLogic
import FirebaseFirestore

class RecordViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    fileprivate weak var calendar: FSCalendar!
    let memoButton = UIButton() // memo contents
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("record_tab_button", comment: "")
        saveToday()
        setCalendar()
        // 連続ログイン確認と表示
        checkStreakDay()
    }
    
    //MARK: -Layout
    func setCalendar() {
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        //Auto Layout以前に使われていた制約を解除しないといけない
        calendar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendar)
        //レイアウト制約
        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: 330).isActive = true
        calendar.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        self.calendar = calendar
    }
    // チェックマーク設定
    func setCheckMark() {
        let checkMark = UIImage(systemName: "checkmark.circle.fill")
        let checkMarkView = UIImageView(image: checkMark)
        checkMarkView.contentMode = .scaleAspectFit
        view.addSubview(checkMarkView)
        
        checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkMarkView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: view.frame.height * 0.01),
            checkMarkView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkMarkView.widthAnchor.constraint(equalToConstant: 60),
            checkMarkView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setNoCheckMark() {
        let checkMark = UIImage(systemName: "checkmark.circle")
        let checkMarkView = UIImageView(image: checkMark)
        checkMarkView.contentMode = .scaleAspectFit
        view.addSubview(checkMarkView)
        
        checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkMarkView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: view.frame.height * 0.01),
            checkMarkView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkMarkView.widthAnchor.constraint(equalToConstant: 60),
            checkMarkView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    
    //MARK: -Function
    // 既存のチェックマークを削除する
    func removeCheckMarks() {
        for subview in view.subviews {
            if let imageView = subview as? UIImageView,
               imageView.image == UIImage(systemName: "checkmark.circle.fill") ||
               imageView.image == UIImage(systemName: "checkmark.circle") {
                imageView.removeFromSuperview()
            }
        }
    }
    

    
    // MARK: - Function Calendar
    func updateCalendar() {
        calendar.reloadData()
    }
    // 今日の日付を保存
    func saveToday() {
        let realm = try! Realm()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        try! realm.write{
            let Events = [EventModel(value: ["date": formatter.string(from: Date()), "event": "Study English"])]
            realm.add(Events)
        }
    }
    // 連続ログインモーダルの表示
    func openStreakModal(streakDays: Int) {
        let alert = UIAlertController(title: "You're on a streak!",
                                      message: "You've logged in for \(streakDays) days in a row. Keep up the momentum!",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
    func getCurrentConsecutiveLoginDays() -> Int {
        let realm = try! Realm()
        let loginRecords = realm.objects(EventModel.self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        // ログインした日付を重複なくリスト化
        let loginDatesSet = Set(loginRecords.compactMap { $0.date })

        var consecutiveDays = 0
        var currentDate = Date()
        
        while true {
            let dateString = dateFormatter.string(from: currentDate)
            
            if loginDatesSet.contains(dateString) {
                // その日ログインしてたらカウント＋1
                consecutiveDays += 1
            } else {
                // ログインしてなかったらストップ
                break
            }
            
            // 1日遡る
            currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        }
        
        return consecutiveDays
    }


    func checkStreakDay() {
        let streakDay = getCurrentConsecutiveLoginDays()
        if streakDay >= 2 {
            openStreakModal(streakDays: streakDay)
        }
    }    
    
    //MARK: -CalendarSupport
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
        return cell
    }
    // 日付を選択したときの処理
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        removeCheckMarks()
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        let mmmm = String(format: "%02d", month)
        let dddd = String(format: "%02d", day)
        
        let workDay = "\(year)/\(mmmm)/\(dddd)"
        
        let realm = try! Realm()
        let eventModel = realm.objects(EventModel.self)
        
        // イベントがあった場合チェックマークを表示
        if eventModel.contains(where: { $0.date == workDay }) {
            setCheckMark()
        } else {
            setNoCheckMark()
        }
    }
    //点マークをつける関数
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        var hasEvent = false
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let workDay = formatter.string(from: date)

        let realm = try! Realm()
        var result = realm.objects(EventModel.self)
        result = result.filter("date = '\(workDay)'")

        for event in result {
            if event.date == workDay {
                hasEvent = true
            }
        }
        if hasEvent {
            return 1
        } else {
            return 0
        }
    }
    
    //MARK: -祝日設定
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
        fileprivate lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        // 祝日判定を行い結果を返すメソッド(True:祝日)
        func judgeHoliday(_ date : Date) -> Bool {
            //祝日判定用のカレンダークラスのインスタンス
            let tmpCalendar = Calendar(identifier: .gregorian)
            // 祝日判定を行う日にちの年、月、日を取得
            let year = tmpCalendar.component(.year, from: date)
            let month = tmpCalendar.component(.month, from: date)
            let day = tmpCalendar.component(.day, from: date)
            // CalculateCalendarLogic()：祝日判定のインスタンスの生成
            let holiday = CalculateCalendarLogic()

            return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
        }
        // date型 -> 年月日をIntで取得
        func getDay(_ date:Date) -> (Int,Int,Int){
            let tmpCalendar = Calendar(identifier: .gregorian)
            let year = tmpCalendar.component(.year, from: date)
            let month = tmpCalendar.component(.month, from: date)
            let day = tmpCalendar.component(.day, from: date)
            return (year,month,day)
        }
        //曜日判定(日曜日:1 〜 土曜日:7)
        func getWeekIdx(_ date: Date) -> Int{
            let tmpCalendar = Calendar(identifier: .gregorian)
            return tmpCalendar.component(.weekday, from: date)
        }
        // 土日や祝日の日の文字色を変える
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            //祝日判定をする（祝日は赤色で表示する）
            if self.judgeHoliday(date){
                return UIColor.red
            }
            //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
            let weekday = self.getWeekIdx(date)
            if weekday == 1 {   //日曜日
                return UIColor.red
            }
            else if weekday == 7 {  //土曜日
                return UIColor.blue
            }
            // not current month for dark mode
            
            if(UITraitCollection.current.userInterfaceStyle == .dark ) {
                let today = Date()
                let year = self.gregorian.component(.year, from: date)
                let month = self.gregorian.component(.month, from: date)
                let todayYear = self.gregorian.component(.year, from: today)
                let todayMonth = self.gregorian.component(.month, from: today)
                
                if year == todayYear && month == todayMonth {
                    return UIColor.white
                }
                else {
                    return UIColor.lightGray
                }
            } else {
                return nil
            }
        }
}



