// 文章データ
import UIKit

class VocabularyList {

    // First: エラー・例外
    var firstSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "exception", "invalid", "failed", "permission denied", "occurred",
            "detected", "deprecated", "terminated", "attempted"
        ].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var firstSentence = [
        "exception", "invalid", "failed", "permission denied", "occurred",
        "detected", "deprecated", "terminated", "attempted"
    ]

    var firstPronunciation = [
        "ɪkˈsɛpʃ(ə)n", "ˌɪnˈvælɪd", "feɪld", "pɚˈmɪʃən", "əˈkɜrd",
        "dɪˈtɛktɪd", "ˈdɛprɪˌkeɪtɪd", "ˈtɜrmɪˌneɪtɪd", "əˈtɛmptɪd"
    ]

    var firstEnglish = [
        NSLocalizedString("exception_meaning", comment: ""),
        NSLocalizedString("invalid_meaning", comment: ""),
        NSLocalizedString("failed_meaning", comment: ""),
        NSLocalizedString("permission_dinied_meaning", comment: ""),
        NSLocalizedString("occurred_meaning", comment: ""),
        NSLocalizedString("detected_meaning", comment: ""),
        NSLocalizedString("deprecated_meaning", comment: ""),
        NSLocalizedString("terminated_meaning", comment: ""),
        NSLocalizedString("attempted_meaning", comment: "")
    ]

    let firstExampleSentence = [
        "The system threw an exception when the input value was null.",
        "The input format is invalid and cannot be processed.",
        "The login process failed due to incorrect credentials.",
        "Permission denied: You need admin rights to access this folder.",
        "An unexpected error occurred while processing your request.",
        "The antivirus software detected a potential threat in the file.",
        "This function is deprecated and should not be used in new code.",
        "The process was terminated due to a memory overflow error.",
        "The application attempted to access a restricted area."
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
    
    let secondExampleSentence = [
        "The array indices must be integers starting from zero.",
        "A foreign key constraint failed during the insert operation.",
        "The error is related to a missing dependency.",
        "Avoid using global variables to reduce side effects.",
        "This regular expression matches all lowercase letters.",
        "The method is defined in an ancestor class.",
        "Sort the data in decreasing order before calculating the average.",
        "The list must be sorted in non-decreasing order.",
        "The final price is the result of a simple tax calculation."
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
    
    let thirdExampleSentence = [
        "The task was suspended due to lack of user input.",
        "The archive contained several log files.",
        "These changes will persist after you restart the application.",
        "The bug was caused by a persistent connection issue.",
        "You can embed custom fonts into the PDF document.",
        "Use the fetch API to retrieve data from the server.",
        "The image was rotated 90 degrees to fit the layout.",
        "An unbounded loop can lead to performance issues.",
        "Use 'let' instead of 'var' for block scoping."
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

    let fourthExampleSentence = [
        "We assume the configuration file exists by default.",
        "Please specify the file path in the input field.",
        "The user role determines access permissions.",
        "This script is intended for internal use only.",
        "Installing Node.js is one of the prerequisites for running this tool.",
        "The issue should be easily identifiable in the logs."
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
    
    let fifthExampleSentence = [
        "The array indices must be integers starting from zero.",
        "A foreign key constraint failed during the insert operation.",
        "This regular expression matches all lowercase letters.",
        "Sort the data in decreasing order before calculating the average.",
        "The list must be sorted in non-decreasing order.",
        "The final price is the result of a simple tax calculation.",
        "We assume the configuration file exists by default.",
        "Verify the user's email before granting access.",
        "121 is a palindrome number, which reads the same backward.",
        "The depth of the directory tree can affect performance.",
        "Set the position to absolute to remove it from the normal flow.",
        "Installing Node.js is one of the prerequisites for running this tool."
    ]
    
    // Sixth: ドキュメント
    var sixthSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "outdated", "deprecated", "obsolete", "superseded", "legacy",
            "experimental", "preview", "stable", "release note", "changelog"
        ].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var sixthSentence = [
        "outdated", "deprecated", "obsolete", "superseded", "legacy",
        "experimental", "preview", "stable", "release note", "changelog"
    ]

    var sixthPronunciation = [
        "ˌaʊtˈdeɪtɪd", "ˌdɛprəˈkeɪtɪd", "ˈɑːbsəliːt", "ˌsuːpərˈsiːdɪd", "ˈlɛɡəsi",
        "ˌɛkspəˈrɪməntl", "ˈpriːvjuː", "ˈsteɪbəl", "rɪˈliːs noʊt", "ˈtʃeɪndʒˌlɔɡ"
    ]

    var sixthEnglish = [
        NSLocalizedString("outdated_meaning", comment: ""),
        NSLocalizedString("deprecated_meaning", comment: ""),
        NSLocalizedString("obsolete_meaning", comment: ""),
        NSLocalizedString("superseded_meaning", comment: ""),
        NSLocalizedString("legacy_meaning", comment: ""),
        NSLocalizedString("experimental_meaning", comment: ""),
        NSLocalizedString("preview_meaning", comment: ""),
        NSLocalizedString("stable_meaning", comment: ""),
        NSLocalizedString("release_note_meaning", comment: ""),
        NSLocalizedString("changelog_meaning", comment: "")
    ]

    let sixthExampleSentence = [
        "The documentation is outdated and needs revision.",
        "This method is deprecated and should not be used.",
        "The API is obsolete and will be removed in future versions.",
        "This tool has been superseded by a newer version.",
        "This is a legacy system that requires special maintenance.",
        "Use this feature with caution as it is experimental.",
        "The new UI is currently in preview mode.",
        "Version 2.1 is now available as a stable release.",
        "Check the release note for recent updates.",
        "The changelog provides a full history of changes."
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

    let eighthExampleSentence = [
        "Check if the file exists before reading it.",
        "We are opposed to changing the default behavior.",
        "121 is a palindrome number, which reads the same backward.",
        "The depth of the directory tree can affect performance.",
        "The chart scales proportionally to the window size.",
        "This change will make the redirect permanent (301).",
        "This method is indeed faster for large datasets.",
        "You can use shorthand notation for defining properties."
    ]


}

