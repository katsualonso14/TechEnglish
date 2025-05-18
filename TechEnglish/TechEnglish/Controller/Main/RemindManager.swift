import UIKit

class RemindManager {
    static func addRemindItem(sentence: String, remindPattern: String) {
        let data = [
            "sentence": sentence,
            "remindPattern": remindPattern
        ]
        NotificationCenter.default.post(name: Notification.Name("addRemind"), object: nil, userInfo: data)

        var savedRemindData: [RemindItem] = []
        if let data = UserDefaults.standard.data(forKey: "remindItems"),
           let decoded = try? JSONDecoder().decode([RemindItem].self, from: data) {
            savedRemindData = decoded
        }

        let newItem = RemindItem(sentence: sentence, remindPattern: remindPattern)
        savedRemindData.append(newItem)

        if let encoded = try? JSONEncoder().encode(savedRemindData) {
            UserDefaults.standard.set(encoded, forKey: "remindItems")
        }
    }
}
