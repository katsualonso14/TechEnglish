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
        ExpandableNames(isExpanded: true, names: ["indices", "constraint", "global_variable", "expression", "decreasing_order", "non_decreasing_order", "calculation"].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var secondSentence = ["indices", "constraint", "global_variable", "expression", "decreasing_order", "non_decreasing_order", "calculation"]
    var secondPronunciation = ["ˈɪndɪˌsiz", "kənˈstreɪnt", "ˈɡloʊbəl ˈvɛriəbl", "ɪkˈsprɛʃən", "diːˈkriːsɪŋ ˈɔːrdər", "ˌnɑn.dɪˈkriːsɪŋ ˈɔːrdər", "ˌkælkjʊˈleɪʃən"]
    var secondEnglish = [
        NSLocalizedString("indices_meaning", comment: ""),
        NSLocalizedString("constraint_meaning", comment: ""),
        NSLocalizedString("global_variable_meaning", comment: ""),
        NSLocalizedString("expression_meaning", comment: ""),
        NSLocalizedString("decreasing_order_meaning", comment: ""),
        NSLocalizedString("non_decreasing_order_meaning", comment: ""),
        NSLocalizedString("calculation_meaning", comment: "")
    ]

    // Third: 状態・ライフサイクル
        var thirdSentenceArray = [
            ExpandableNames(isExpanded: true, names: ["suspended", "persist", "persistent", "embed", "fetch", "rotated", "unbounded"].map {
                Contact(name: $0,
                        hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
            })
        ]
        var thirdSentence = ["suspended", "persist", "persistent", "embed", "fetch", "rotated", "unbounded"]
        var thirdPronunciation = ["səˈspɛndɪd", "pərˈsɪst", "ˈpɝːsɪstənt", "ɪmˈbɛd", "fɛtʃ", "ˈroʊˌteɪtɪd", "ʌnˈbaʊndɪd"]
        var thirdEnglish = [
            NSLocalizedString("suspended_meaning", comment: ""),
            NSLocalizedString("persist_meaning", comment: ""),
            NSLocalizedString("persistent_meaning", comment: ""),
            NSLocalizedString("embed_meaning", comment: ""),
            NSLocalizedString("fetch_meaning", comment: ""),
            NSLocalizedString("rotated_meaning", comment: ""),
            NSLocalizedString("unbounded_meaning", comment: "")
        ]

        // Fourth: 設定・条件
        var fourthSentenceArray = [
            ExpandableNames(isExpanded: true, names: ["assume", "specify", "determines", "intended", "prerequisites"].map {
                Contact(name: $0,
                        hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
            })
        ]
        var fourthSentence = ["assume", "specify", "determines", "intended", "prerequisites"]
        var fourthPronunciation = ["əˈsuːm", "ˈspɛsɪˌfaɪ", "dɪˈtɜːrmɪnz", "ɪnˈtɛndɪd", "priːˈrɛkwɪzɪts"]
        var fourthEnglish = [
            NSLocalizedString("assume_meaning", comment: ""),
            NSLocalizedString("specify_meaning", comment: ""),
            NSLocalizedString("determines_meaning", comment: ""),
            NSLocalizedString("intended_meaning", comment: ""),
            NSLocalizedString("prerequisites_meaning", comment: "")
        ]

        // Fifth: 構文・表現
        var fifthSentenceArray = [
            ExpandableNames(isExpanded: true, names: ["indeed", "instead", "shorthand_notation", "absolute"].map {
                Contact(name: $0,
                        hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
            })
        ]
        var fifthSentence = ["indeed", "instead", "shorthand_notation", "absolute"]
        var fifthPronunciation = ["ɪnˈdiːd", "ɪnˈstɛd", "ˈʃɔːrtˌhænd noʊˈteɪʃən", "ˈæbsəluːt"]
        var fifthEnglish = [
            NSLocalizedString("indeed_meaning", comment: ""),
            NSLocalizedString("instead_meaning", comment: ""),
            NSLocalizedString("shorthand_notation_meaning", comment: ""),
            NSLocalizedString("absolute_meaning", comment: "")
        ]

        // Sixth: 処理・関数
        var sixthSentenceArray = [
            ExpandableNames(isExpanded: true, names: ["invoked", "modify", "verify", "inherited"].map {
                Contact(name: $0,
                        hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
            })
        ]
        var sixthSentence = ["invoked", "modify", "verify", "inherited"]
        var sixthPronunciation = ["ɪnˈvoʊkt", "ˈmɒdɪfaɪ", "ˈvɛrɪfaɪ", "ɪnˈhɛrɪtɪd"]
        var sixthEnglish = [
            NSLocalizedString("invoked_meaning", comment: ""),
            NSLocalizedString("modify_meaning", comment: ""),
            NSLocalizedString("verify_meaning", comment: ""),
            NSLocalizedString("inherited_meaning", comment: "")
        ]

        // Seventh: 目的・関係
        var seventhSentenceArray = [
            ExpandableNames(isExpanded: true, names: ["related", "identifiable", "ancestor", "contained"].map {
                Contact(name: $0,
                        hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
            })
        ]
        var seventhSentence = ["related", "identifiable", "ancestor", "contained"]
        var seventhPronunciation = ["rɪˈleɪtɪd", "aɪˈdɛntɪˌfaɪəb(ə)l", "ˈænsɛstər", "kənˈteɪnd"]
        var seventhEnglish = [
            NSLocalizedString("related_meaning", comment: ""),
            NSLocalizedString("identifiable_meaning", comment: ""),
            NSLocalizedString("ancestor_meaning", comment: ""),
            NSLocalizedString("contained_meaning", comment: "")
        ]

        // Eighth: その他・補足
        var eighthSentenceArray = [
            ExpandableNames(isExpanded: true, names: ["existing", "opposed", "palindrome_number", "depth", "proportionally", "permanent"].map {
                Contact(name: $0,
                        hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
            })
        ]
        var eighthSentence = ["existing", "opposed", "palindrome_number", "depth", "proportionally", "permanent"]
        var eighthPronunciation = ["ɪɡˈzɪstɪŋ", "əˈpoʊzd", "ˈpælɪnˌdroʊm ˈnʌmbər", "dɛpθ", "prəˈpɔːʃənəli", "ˈpɝːmənənt"]
        var eighthEnglish = [
            NSLocalizedString("existing_meaning", comment: ""),
            NSLocalizedString("opposed_meaning", comment: ""),
            NSLocalizedString("palindrome_number_meaning", comment: ""),
            NSLocalizedString("depth_meaning", comment: ""),
            NSLocalizedString("proportionally_meaning", comment: ""),
            NSLocalizedString("permanent_meaning", comment: "")
        ]


}

