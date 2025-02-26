// 文章データ
import UIKit

class SentenceViewController: UITabBarController {

    // Beginner Page
    var sentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["invoked","exception","occurred","related","existing","Inherited","embed","opposed","fetch"].map{
            Contact(name: $0,
                hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var sentence = ["invoked", "exception", "occurred", "related", "existing", "Inherited", "embed", "opposed", "fetch"]

    var pronunciation = ["ɪnˈvoʊkt", "ɪkˈsɛpʃ(ə)n", "əˈkɜrd", "rɪˈleɪtɪd", "ɪɡˈzɪstɪŋ", "ɪnˈhɛrɪtɪd", "ɪmˈbɛd", "əˈpoʊzd", "fɛtʃ"]

    var english = [
        NSLocalizedString("呼び出された", comment: ""),
        NSLocalizedString("例外", comment: ""),
        NSLocalizedString("発生する・起こる", comment: ""),
        NSLocalizedString("関連している", comment: ""),
        NSLocalizedString("既存", comment: ""),
        NSLocalizedString("継承された", comment: ""),
        NSLocalizedString("埋め込む", comment: ""),
        NSLocalizedString("反対した", comment: ""),
        NSLocalizedString("持ってくる", comment: "")
    ]
    //TODO: 文章やシチュエーションなども追加を検討
    
    // Intermediate Page
    var secondSentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["ancestor","modify","Contained","identifiable","Instead","verify","Permission denied","permanent"].map{
            Contact(name: $0,
                hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var secondSentence = ["ancestor", "modify", "Contained", "identifiable", "Instead", "verify", "Permission denied", "permanent"]

    var secondPronunciation = ["ˈænsɛstər", "ˈmɒdɪfaɪ", "kənˈteɪnd", "aɪˈdɛntɪˌfaɪəb(ə)l", "ɪnˈstɛd", "ˈvɛrɪfaɪ", "pɚˈmɪʃən dɪˈnaɪd", "ˈpɝːmənənt"]

    var secondEnglish = [
        NSLocalizedString("祖先,先祖", comment: ""),
        NSLocalizedString("修正,変更", comment: ""),
        NSLocalizedString("含まれる", comment: ""),
        NSLocalizedString("識別可能な", comment: ""),
        NSLocalizedString("代わり", comment: ""),
        NSLocalizedString("確認する", comment: ""),
        NSLocalizedString("許可が降りない", comment: ""),
        NSLocalizedString("永続", comment: "")
    ]

    
    // Advanced Page
    var thirdSentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["indices","constraint","attempted","indeed","suspended","observable","Deprecated","absolute"].map{
            Contact(name: $0,
                hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var thirdSentence = ["indices", "constraint", "attempted", "indeed", "suspended", "observable", "Deprecated", "absolute"]

    var thirdPronunciation = ["ˈɪn.dɪ.siːz", "kənˈstreɪnt", "əˈtɛmptɪd", "ɪnˈdiːd", "səˈspɛndɪd", "əbˈzɝː.və.bəl", "ˈdɛprɪˌkeɪtɪd", "ˈæbsəluːt"]

    var thirdEnglish = [
        NSLocalizedString("インデックス", comment: ""),
        NSLocalizedString("制約", comment: ""),
        NSLocalizedString("試みた", comment: ""),
        NSLocalizedString("本当に,実際に", comment: ""),
        NSLocalizedString("一時停止中", comment: ""),
        NSLocalizedString("観察可能な", comment: ""),
        NSLocalizedString("廃止された", comment: ""),
        NSLocalizedString("絶対", comment: "")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

