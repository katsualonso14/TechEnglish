// 文章データ
import UIKit

class VocabularyList {

    // First: エラー・例外
    var firstSentenceArray = [
        ExpandableNames(isExpanded: true, names: ["exception", "occurred", "detected", "permission", "deprecated", "terminated", "denied", "attempted"].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var firstSentence = ["exception", "occurred", "detected", "permission", "deprecated", "terminated", "denied", "attempted"]
    var firstPronunciation = ["ɪkˈsɛpʃ(ə)n", "əˈkɜrd", "dɪˈtɛktɪd", "pɚˈmɪʃən", "ˈdɛprɪˌkeɪtɪd", "ˈtɜrmɪˌneɪtɪd", "dɪˈnaɪd", "əˈtɛmptɪd"]
    var firstEnglish = [
        NSLocalizedString("exception_meaning", comment: ""),
        NSLocalizedString("occurred_meaning", comment: ""),
        NSLocalizedString("detected_meaning", comment: ""),
        NSLocalizedString("permission_meaning", comment: ""),
        NSLocalizedString("deprecated_meaning", comment: ""),
        NSLocalizedString("terminated_meaning", comment: ""),
        NSLocalizedString("denied_meaning", comment: ""),
        NSLocalizedString("attempted_meaning", comment: "")
    ]

    // Second: データ・構造
    var secondSentenceArray = [
        ExpandableNames(isExpanded: true, names: ["indices", "constraint", "related", "global variable", "expression", "ancestor", "decreasing order", "non decreasing order", "calculation"].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var secondSentence = ["indices", "constraint", "related", "global variable", "expression", "ancestor", "decreasing order", "non decreasing order", "calculation"]
    var secondPronunciation = ["ˈɪndɪˌsiz", "kənˈstreɪnt", "rɪˈleɪtɪd","ˈɡloʊbəl ˈvɛriəbl", "ɪkˈsprɛʃən", "ˈænsɛstər","diːˈkriːsɪŋ ˈɔːrdər", "ˌnɑn.dɪˈkriːsɪŋ ˈɔːrdər", "ˌkælkjʊˈleɪʃən"]
    var secondEnglish = [
        NSLocalizedString("indices_meaning", comment: ""),
        NSLocalizedString("constraint_meaning", comment: ""),
        NSLocalizedString("related_meaning", comment: ""),
        NSLocalizedString("global_variable_meaning", comment: ""),
        NSLocalizedString("expression_meaning", comment: ""),
        NSLocalizedString("ancestor_meaning", comment: ""),
        NSLocalizedString("decreasing_order_meaning", comment: ""),
        NSLocalizedString("non_decreasing_order_meaning", comment: ""),
        NSLocalizedString("calculation_meaning", comment: "")
    ]

    // Third: 状態・ライフサイクル
        var thirdSentenceArray = [
            ExpandableNames(isExpanded: true, names: ["suspended", "contained", "persist", "persistent", "embed", "fetch", "rotated", "unbounded", "instead"].map {
                Contact(name: $0,
                        hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
            })
        ]
        var thirdSentence = ["suspended", "contained", "persist", "persistent", "embed", "fetch", "rotated", "unbounded", "instead"]
        var thirdPronunciation = ["səˈspɛndɪd", "kənˈteɪnd", "pərˈsɪst", "ˈpɝːsɪstənt", "ɪmˈbɛd", "fɛtʃ", "ˈroʊˌteɪtɪd", "ʌnˈbaʊndɪd", "ɪnˈstɛd"]
        var thirdEnglish = [
            NSLocalizedString("suspended_meaning", comment: ""),
            NSLocalizedString("contained_meaning", comment: ""),
            NSLocalizedString("persist_meaning", comment: ""),
            NSLocalizedString("persistent_meaning", comment: ""),
            NSLocalizedString("embed_meaning", comment: ""),
            NSLocalizedString("fetch_meaning", comment: ""),
            NSLocalizedString("rotated_meaning", comment: ""),
            NSLocalizedString("unbounded_meaning", comment: ""),
            NSLocalizedString("instead_meaning", comment: "")
        ]

        // Fourth: 設定・条件
        var fourthSentenceArray = [
            ExpandableNames(isExpanded: true, names: ["assume", "specify", "determines", "intended", "prerequisites", "identifiable"].map {
                Contact(name: $0,
                        hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
            })
        ]
        var fourthSentence = ["assume", "specify", "determines", "intended", "prerequisites", "identifiable"]
        var fourthPronunciation = ["əˈsuːm", "ˈspɛsɪˌfaɪ", "dɪˈtɜːrmɪnz", "ɪnˈtɛndɪd", "priːˈrɛkwɪzɪts", "aɪˈdɛntɪˌfaɪəb(ə)l"]
        var fourthEnglish = [
            NSLocalizedString("assume_meaning", comment: ""),
            NSLocalizedString("specify_meaning", comment: ""),
            NSLocalizedString("determines_meaning", comment: ""),
            NSLocalizedString("intended_meaning", comment: ""),
            NSLocalizedString("prerequisites_meaning", comment: ""),
            NSLocalizedString("identifiable_meaning", comment: "")
        ]

    // Fifth: コーディングテスト
    var fifthSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "indices", "constraint", "expression", "decreasing order", "non decreasing order",
            "calculation", "assume", "verify", "palindrome number", "depth", "absolute", "prerequisites"
        ].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var fifthSentence = [
        "indices", "constraint", "expression", "decreasing order", "non decreasing order",
        "calculation", "assume", "verify", "palindrome number", "depth", "absolute", "prerequisites"
    ]

    var fifthPronunciation = [
        "ˈɪndɪsiːz", "kənˈstreɪnt", "ɪkˈsprɛʃən", "dɪˈkriːsɪŋ ˈɔːrdər", "nɒn dɪˈkriːsɪŋ ˈɔːrdər",
        "ˌkælkjʊˈleɪʃən", "əˈsjuːm", "ˈvɛrɪˌfaɪ", "ˈpælɪndroʊm ˈnʌmbər", "dɛpθ", "ˈæbsəluːt", "priːˈrɛkwəzɪts"
    ]

    var fifthEnglish = [
        NSLocalizedString("indices_meaning", comment: ""),
        NSLocalizedString("constraint_meaning", comment: ""),
        NSLocalizedString("expression_meaning", comment: ""),
        NSLocalizedString("decreasing_order_meaning", comment: ""),
        NSLocalizedString("non_decreasing_order_meaning", comment: ""),
        NSLocalizedString("calculation_meaning", comment: ""),
        NSLocalizedString("assume_meaning", comment: ""),
        NSLocalizedString("verify_meaning", comment: ""),
        NSLocalizedString("palindrome_number_meaning", comment: ""),
        NSLocalizedString("depth_meaning", comment: ""),
        NSLocalizedString("absolute_meaning", comment: ""),
        NSLocalizedString("prerequisites_meaning", comment: "")
    ]


        // Eighth: その他・補足
        var eighthSentenceArray = [
            ExpandableNames(isExpanded: true, names: ["existing", "opposed", "palindrome number", "depth", "proportionally", "permanent", "indeed", "shorthand notation"].map {
                Contact(name: $0,
                        hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
            })
        ]
        var eighthSentence = ["existing", "opposed", "palindrome number", "depth", "proportionally", "permanent", "indeed", "shorthand notation"]
        var eighthPronunciation = ["ɪɡˈzɪstɪŋ", "əˈpoʊzd", "ˈpælɪnˌdroʊm ˈnʌmbər", "dɛpθ", "prəˈpɔːʃənəli", "ˈpɝːmənənt", "ɪnˈdiːd", "ˈʃɔːrtˌhænd noʊˈteɪʃən"]
        var eighthEnglish = [
            NSLocalizedString("existing_meaning", comment: ""),
            NSLocalizedString("opposed_meaning", comment: ""),
            NSLocalizedString("palindrome_number_meaning", comment: ""),
            NSLocalizedString("depth_meaning", comment: ""),
            NSLocalizedString("proportionally_meaning", comment: ""),
            NSLocalizedString("permanent_meaning", comment: ""),
            NSLocalizedString("indeed_meaning", comment: ""),
            NSLocalizedString("shorthand_notation_meaning", comment: "")
        ]


}

