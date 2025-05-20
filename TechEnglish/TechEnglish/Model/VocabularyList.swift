// 文章データ
import UIKit

class VocabularyList {

    // エラー・例外
    var errorSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "exception", "invalid", "failed", "permission denied", "occurred",
            "detected", "deprecated", "terminated", "attempted"
        ].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var errorSentence = [
        "exception", "invalid", "failed", "permission denied", "occurred",
        "detected", "deprecated", "terminated", "attempted"
    ]

    var errorPronunciation = [
        "ɪkˈsɛpʃ(ə)n", "ˌɪnˈvælɪd", "feɪld", "pɚˈmɪʃən", "əˈkɜrd",
        "dɪˈtɛktɪd", "ˈdɛprɪˌkeɪtɪd", "ˈtɜrmɪˌneɪtɪd", "əˈtɛmptɪd"
    ]

    var errorEnglish = [
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

    let errorExampleSentence = [
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
    
    // ドキュメント
    var docsSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "outdated", "deprecated", "obsolete", "superseded", "experimental", "stable"
        ].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var docsSentence = [
        "outdated", "deprecated", "obsolete", "superseded", "experimental", "stable"
    ]

    var docsPronunciation = [
        "ˌaʊtˈdeɪtɪd", "ˌdɛprəˈkeɪtɪd", "ˈɑːbsəliːt", "ˌsuːpərˈsiːdɪd", "ˌɛkspəˈrɪməntl", "ˈsteɪbəl"
    ]

    var docsEnglish = [
        NSLocalizedString("outdated_meaning", comment: ""),
        NSLocalizedString("deprecated_meaning", comment: ""),
        NSLocalizedString("obsolete_meaning", comment: ""),
        NSLocalizedString("superseded_meaning", comment: ""),
        NSLocalizedString("experimental_meaning", comment: ""),
        NSLocalizedString("stable_meaning", comment: "")
    ]

    let docsExampleSentence = [
        "The documentation is outdated and needs revision.",
        "This method is deprecated and should not be used.",
        "The API is obsolete and will be removed in future versions.",
        "This tool has been superseded by a newer version.",
        "Use this feature with caution as it is experimental.",
        "Version 2.1 is now available as a stable release."
    ]

    // データ・構造
    var dataSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "index/indices", "structure/struct", "constraint", "mutable", "immutable", "queue", "existing"
        ].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var dataSentence = [
        "index/indices", "structure/struct", "constraint", "mutable", "immutable", "queue", "existing"
    ]

    var dataPronunciation = [
        "ˈɪndɛks/ˈɪndɪˌsiz", "ˈstrʌktʃər/strʌkt", "kənˈstreɪnt", "mjuːtəbl", "ɪˈmjuːtəbəl", "kjuː", "ɪɡˈzɪstɪŋ"
    ]

    var dataEnglish = [
        NSLocalizedString("index_indices_meaning", comment: ""),
        NSLocalizedString("structure_struct_meaning", comment: ""),
        NSLocalizedString("constraint_meaning", comment: ""),
        NSLocalizedString("mutable_meaning", comment: ""),
        NSLocalizedString("immutable_meaning", comment: ""),
        NSLocalizedString("queue_meaning", comment: ""),
        NSLocalizedString("existing_meaning", comment: "")
    ]

    let dataExampleSentence = [
        "Access the value using its index in the list.",
        "A structure groups related values together.",
        "This constraint prevents duplicate entries.",
        "The array is mutable and can be changed.",
        "The string is immutable once created.",
        "Use a queue to process tasks in order.",
        "The existing data must be updated before proceeding."
    ]
    
    // 状態・ライフサイクル
    var lifecycleSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "suspended", "persistent", "embed", "fetch", "unbounded",
            "invoked", "asynchronous", "inherited", "ancestor", "permanent"
        ].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var lifecycleSentence = [
        "suspended", "persistent", "embed", "fetch", "unbounded",
        "invoked", "asynchronous", "inherited", "ancestor", "permanent"
    ]

    var lifecyclePronunciation = [
        "səˈspɛndɪd", "ˈpɝːsɪstənt", "ɪmˈbɛd", "fɛtʃ", "ʌnˈbaʊndɪd",
        "ɪnˈvoʊkt", "ˌeɪsɪŋˈkrɒnəs", "ɪnˈhɛrɪtɪd", "ˈænˌsɛstɚ", "ˈpɝːmənənt"
    ]

    var lifecycleEnglish = [
        NSLocalizedString("suspended_meaning", comment: ""),
        NSLocalizedString("persistent_meaning", comment: ""),
        NSLocalizedString("embed_meaning", comment: ""),
        NSLocalizedString("fetch_meaning", comment: ""),
        NSLocalizedString("unbounded_meaning", comment: ""),
        NSLocalizedString("invoked_meaning", comment: ""),
        NSLocalizedString("asynchronous_meaning", comment: ""),
        NSLocalizedString("inherited_meaning", comment: ""),
        NSLocalizedString("ancestor_meaning", comment: ""),
        NSLocalizedString("permanent_meaning", comment: "")
    ]

    let lifecycleExampleSentence = [
        "The task was suspended due to user inactivity.",
        "The bug was caused by a persistent memory leak.",
        "You can embed metadata inside the image file.",
        "The app uses fetch to load remote resources.",
        "An unbounded queue may cause memory overflow.",
        "The function is invoked after the event fires.",
        "Asynchronous tasks allow non-blocking execution.",
        "The child class inherited methods from the parent.",
        "The ancestor element defines the layout structure.",
        "The user has a permanent login session."
    ]

    // 設定・条件
    var settingSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "assume", "specify", "determines", "intended", "prerequisites", "identifiable", "absolute", "contained"
        ].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]
    var settingSentence = [
        "assume", "specify", "determines", "intended", "prerequisites", "identifiable", "absolute", "contained"
    ]
    var settingPronunciation = [
        "əˈsjuːm", "spəˈsɪfaɪ", "dɪˈtɜːmɪnz", "ɪnˈtɛndɪd", "ˈprɪrɪkwəzɪts", "ˌaɪˈdɛntɪfaɪəbəl", "ˈæbsəluːt", "kənˈteɪnd"
    ]

    var settingEnglish = [
        NSLocalizedString("assume_meaning", comment: ""),
        NSLocalizedString("specify_meaning", comment: ""),
        NSLocalizedString("determines_meaning", comment: ""),
        NSLocalizedString("intended_meaning", comment: ""),
        NSLocalizedString("prerequisites_meaning", comment: ""),
        NSLocalizedString("identifiable_meaning", comment: ""),
        NSLocalizedString("absolute_meaning", comment: ""),
        NSLocalizedString("contained_meaning", comment: "")
    ]

    let settingExampleSentence = [
        "We assume the file exists in the default directory.",
        "You must specify the path to the file before processing.",
        "The configuration determines the application's behavior.",
        "The intended result of the function is to return the sum.",
        "Make sure all prerequisites are met before running the script.",
        "The object is identifiable by its unique ID.",
        "The position is absolute, meaning it is placed precisely.",
        "The value contained in the variable will be used for processing."
    ]

    // コーディングテスト
    var testSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "indices", "constraint", "expression", "decreasing order", "non-decreasing order",
            "calculation", "palindrome number", "depth", "absolute", "prerequisites"
        ].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]

    var testSentence = [
        "indices", "constraint", "expression", "decreasing order", "non-decreasing order",
        "calculation", "palindrome number", "depth", "absolute", "prerequisites"
    ]

    var testPronunciation = [
        "ˈɪndɪsiːz", "kənˈstreɪnt", "ɪkˈsprɛʃən", "dɪˈkriːsɪŋ ˈɔːrdər", "nɒn dɪˈkriːsɪŋ ˈɔːrdər",
        "ˌkælkjʊˈleɪʃən", "ˈpælɪndroʊm ˈnʌmbər", "dɛpθ", "ˈæbsəluːt", "priːˈrɛkwəzɪts"
    ]

    var testEnglish = [
        NSLocalizedString("index_indices_meaning", comment: ""),
        NSLocalizedString("constraint_meaning", comment: ""),
        NSLocalizedString("expression_meaning", comment: ""),
        NSLocalizedString("decreasing_order_meaning", comment: ""),
        NSLocalizedString("non_decreasing_order_meaning", comment: ""),
        NSLocalizedString("calculation_meaning", comment: ""),
        NSLocalizedString("palindrome_number_meaning", comment: ""),
        NSLocalizedString("depth_meaning", comment: ""),
        NSLocalizedString("absolute_meaning", comment: ""),
        NSLocalizedString("prerequisites_meaning", comment: "")
    ]

    let testExampleSentence = [
        "The array indices must be integers starting from zero.",
        "A foreign key constraint failed during the insert operation.",
        "This regular expression matches all lowercase letters.",
        "Sort the data in decreasing order before calculating the average.",
        "The list must be sorted in non-decreasing order.",
        "The final price is the result of a simple tax calculation.",
        "121 is a palindrome number, which reads the same backward.",
        "The depth of the directory tree can affect performance.",
        "Set the position to absolute to remove it from the normal flow.",
        "Installing Node.js is one of the prerequisites for running this tool."
    ]

    // その他・補足
    var otherSentenceArray = [
        ExpandableNames(isExpanded: true, names: ["related", "invoked", "modify", "verify", "indeed", "instead", "shorthand notation"].map {
            Contact(name: $0,
                    hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]
    var otherSentence = ["related", "invoked", "modify", "verify", "indeed", "instead", "shorthand notation"]
    var otherPronunciation = ["rɪˈleɪtɪd", "ɪnˈvoʊkt", "ˈmɒdɪˌfaɪ", "ˈvɛrɪˌfaɪ", "ɪnˈdiːd", "ɪnˈstɛd", "ˈʃɔːrtˌhænd noʊˈteɪʃən"]
    var otherEnglish = [
        NSLocalizedString("related_meaning", comment: ""),
        NSLocalizedString("invoked_meaning", comment: ""),
        NSLocalizedString("modify_meaning", comment: ""),
        NSLocalizedString("verify_meaning", comment: ""),
        NSLocalizedString("indeed_meaning", comment: ""),
        NSLocalizedString("instead_meaning", comment: ""),
        NSLocalizedString("shorthand_notation_meaning", comment: "")
    ]

    let otherExampleSentence = [
        "These two issues are closely related.",
        "The function is invoked automatically during startup.",
        "You can modify the configuration file to change behavior.",
        "Please verify the input before proceeding.",
        "This result is indeed surprising.",
        "Use 'else' instead of another 'if' when appropriate.",
        "CSS allows shorthand notation for margins and padding."
    ]

}

