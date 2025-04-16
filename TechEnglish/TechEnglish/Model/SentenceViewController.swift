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
        NSLocalizedString("invoked", comment: ""),
        NSLocalizedString("exception", comment: ""),
        NSLocalizedString("occurred", comment: ""),
        NSLocalizedString("related", comment: ""),
        NSLocalizedString("existing", comment: ""),
        NSLocalizedString("inherited", comment: ""),
        NSLocalizedString("embed", comment: ""),
        NSLocalizedString("opposed", comment: ""),
        NSLocalizedString("fetch", comment: "")
    ]
    //TODO: 文章やシチュエーションなども追加を検討
    
    // Intermediate Page
    var secondSentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["ancestor","modify","Contained","identifiable","Instead","verify","Permission","permanent"].map{
            Contact(name: $0,
                hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var secondSentence = ["ancestor", "modify", "Contained", "identifiable", "Instead", "verify", "Permission", "permanent"]

    var secondPronunciation = ["ˈænsɛstər", "ˈmɒdɪfaɪ", "kənˈteɪnd", "aɪˈdɛntɪˌfaɪəb(ə)l", "ɪnˈstɛd", "ˈvɛrɪfaɪ", "pɚˈmɪʃən", "ˈpɝːmənənt"]

    var secondEnglish = [
        NSLocalizedString("ancestor", comment: ""),
        NSLocalizedString("modify", comment: ""),
        NSLocalizedString("contained", comment: ""),
        NSLocalizedString("identifiable", comment: ""),
        NSLocalizedString("instead", comment: ""),
        NSLocalizedString("verify", comment: ""),
        NSLocalizedString("permission", comment: ""),
        NSLocalizedString("permanent", comment: "")
    ]

    
    // Advanced Page
    var thirdSentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["denied","constraint","attempted","indeed","suspended","observable","Deprecated","absolute"].map{
            Contact(name: $0,
                hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var thirdSentence = ["denied", "constraint", "attempted", "indeed", "suspended", "observable", "Deprecated", "absolute"]

    var thirdPronunciation = ["dɪˈnaɪd", "kənˈstreɪnt", "əˈtɛmptɪd", "ɪnˈdiːd", "səˈspɛndɪd", "əbˈzɝː.və.bəl", "ˈdɛprɪˌkeɪtɪd", "ˈæbsəluːt"]

    var thirdEnglish = [
        NSLocalizedString("denied", comment: ""),
        NSLocalizedString("constraint", comment: ""),
        NSLocalizedString("attempted", comment: ""),
        NSLocalizedString("indeed", comment: ""),
        NSLocalizedString("suspended", comment: ""),
        NSLocalizedString("observable", comment: ""),
        NSLocalizedString("deprecated", comment: ""),
        NSLocalizedString("absolute", comment: "")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

