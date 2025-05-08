import Foundation
import UIKit


class CheckNotifController: UIViewController {
    
    //　通知によって画面遷移ページを変更する
    func navigateToPage(navController: UINavigationController, page: String) {
        switch page {
        case "first":
            let vc = VocabFirstViewController(titleName: NSLocalizedString("vocab_first_button_title", comment: ""))
            navController.pushViewController(vc, animated: true)
        case "second":
            let vc = VocabSecondViewController(titleName: NSLocalizedString("vocab_second_button_title", comment: ""))
            navController.pushViewController(vc, animated: true)
        case "third":
            let vc = VocabThirdViewController(titleName: NSLocalizedString("vocab_third_button_title", comment: ""))
            navController.pushViewController(vc, animated: true)
        case "fourth":
            let vc = VocabFourthViewController(titleName: NSLocalizedString("vocab_fourth_button_title", comment: ""))
            navController.pushViewController(vc, animated: true)
        case "fifth":
            let vc = VocabFifthViewController(titleName: NSLocalizedString("vocab_fifth_button_title", comment: ""))
            navController.pushViewController(vc, animated: true)
        case "sixth":
            let vc = VocabSixthViewController(titleName: NSLocalizedString("vocab_sixth_button_title", comment: ""))
            navController.pushViewController(vc, animated: true)
        case "eighth":
            let vc = VocabEighthViewController(titleName: NSLocalizedString("vocab_eighth_button_title", comment: ""))
            navController.pushViewController(vc, animated: true)
        default:
            break
        }
    }

}
