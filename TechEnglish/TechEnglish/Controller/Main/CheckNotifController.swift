import Foundation
import UIKit


class CheckNotifController: UIViewController {
    
    //　通知によって画面遷移ページを変更する
    func navigateToPage(navController: UINavigationController, page: String) {
        switch page {
        case "first":
            let firstVC = VocabFirstViewController(titleName: "よく出てくる")
            navController.pushViewController(firstVC, animated: true)
        case "second":
            let secondVC = VocabSecondViewController(titleName: "出てくる")
            navController.pushViewController(secondVC, animated: true)
        case "third":
            let thirdVC = VocabThirdViewController(titleName: "たまに出てくる")
            navController.pushViewController(thirdVC, animated: true)
        default:
            break
        }
        
    }
}
