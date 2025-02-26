
import Foundation
import UIKit

enum AppColors {
    static let textColor = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return .white
        default:
            return .black
        }
    }
    // 背景色をダークモードなら黒, ライトモードなら白に設定
    static let backgroundColorCheckMode = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return .black
        default:
            return .white
        }
    }
    
    static let appMainColor = UIColor(red: 90/255, green: 220/255, blue: 155/255, alpha: 1.0)
}



