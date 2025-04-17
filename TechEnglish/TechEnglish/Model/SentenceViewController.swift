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
        NSLocalizedString("invoked_meaning", comment: ""),
        NSLocalizedString("exception_meaning", comment: ""),
        NSLocalizedString("occurred_meaning", comment: ""),
        NSLocalizedString("related_meaning", comment: ""),
        NSLocalizedString("existing_meaning", comment: ""),
        NSLocalizedString("inherited_meaning", comment: ""),
        NSLocalizedString("embed_meaning", comment: ""),
        NSLocalizedString("opposed_meaning", comment: ""),
        NSLocalizedString("fetch_meaning", comment: "")
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
        NSLocalizedString("ancestor_meaning", comment: ""),
        NSLocalizedString("modify_meaning", comment: ""),
        NSLocalizedString("contained_meaning", comment: ""),
        NSLocalizedString("identifiable_meaning", comment: ""),
        NSLocalizedString("instead_meaning", comment: ""),
        NSLocalizedString("verify_meaning", comment: ""),
        NSLocalizedString("permission_meaning", comment: ""),
        NSLocalizedString("permanent_meaning", comment: "")
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
        NSLocalizedString("denied_meaning", comment: ""),
        NSLocalizedString("constraint_meaning", comment: ""),
        NSLocalizedString("attempted_meaning", comment: ""),
        NSLocalizedString("indeed_meaning", comment: ""),
        NSLocalizedString("suspended_meaning", comment: ""),
        NSLocalizedString("observable_meaning", comment: ""),
        NSLocalizedString("deprecated_meaning", comment: ""),
        NSLocalizedString("absolute_meaning", comment: "")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

