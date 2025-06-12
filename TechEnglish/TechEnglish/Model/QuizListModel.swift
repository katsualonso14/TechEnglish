import Foundation

class QuizListModel {
    let errorHandlingQuestions: [(question: String, choices: [String], correctIndex: Int, explanation: String)] = [
        (
            NSLocalizedString("quiz_unexpected_error_occurred", comment: "「予期せぬエラーが〇〇〇〇しました」の正しい語を選ぶクイズ"),
            ["occurred", "disposed", "attempted", "deprecated"],
            0,
            "「occurred」は「発生した・起こった」という意味。エラーが発生したときによく使われる表現です。"
        ),
        (
            NSLocalizedString("quiz_old_api_deprecated", comment: "「古いAPIはすでに〇〇〇〇されています」の正しい語を選ぶクイズ"),
            ["detected", "terminated", "deprecated", "expected"],
            2,
            "「deprecated」は「廃止された」「非推奨になった」を意味し、古いAPIや機能の説明によく使われます。"
        ),
        (
            NSLocalizedString("quiz_function_invoked_automatically", comment: "「この関数は自動的に〇〇〇〇されます」の正しい語を選ぶクイズ"),
            ["attempted", "invoked", "disposed", "occurred"],
            1,
            "「invoked」は「呼び出された」という意味で、関数やメソッドが実行されたときに使います。"
        ),
        (
            NSLocalizedString("quiz_session_terminated_by_timeout", comment: "「セッションはタイムアウトにより〇〇〇〇されました」の正しい語を選ぶクイズ"),
            ["detected", "terminated", "expected", "occurred"],
            1,
            "「terminated」は「終了した」という意味で、プロセスやセッションの終了に使用されます。"
        ),
        (
            NSLocalizedString("quiz_memory_leak_detected", comment: "「ログによるとメモリリークが〇〇〇〇されました」の正しい語を選ぶクイズ"),
            ["disposed", "attempted", "detected", "deprecated"],
            2,
            "「detected」は「検出された」という意味で、ログや監視ツールが問題を見つけたときに使われます。"
        )
    ]
    
    let docsWordQuestions: [(question: String, choices: [String], correctIndex: Int, explanation: String)] = [
        (
            NSLocalizedString("quiz_superseded_feature", comment: "新しいものに置き換えられたことを表す単語を選ぶクイズ"),
            ["outdated", "obsolete", "superseded", "invoked"],
            2,
            "「superseded」は「新しいものに置き換えられた」という意味で、古い機能の置き換えに使われます。"
        ),
        (
            NSLocalizedString("quiz_deprecated_method", comment: "非推奨になったメソッドを表す単語を選ぶクイズ"),
            ["deprecated", "stable", "invoked", "verify"],
            0,
            "「deprecated」は古くなったため「使用が推奨されなくなった」という意味。ドキュメントによく出てきます。"
        ),
        (
            NSLocalizedString("quiz_experimental_api", comment: "まだ安定していないAPIの状態を表す単語を選ぶクイズ"),
            ["outdated", "experimental", "stable", "superseded"],
            1,
            "「experimental」はテスト段階の状態であり、本番環境での使用には注意が必要です。"
        ),
        (
            NSLocalizedString("quiz_obsolete_code", comment: "事実上使われなくなったコードの状態を表す単語を選ぶクイズ"),
            ["obsolete", "stable", "invoked", "modify"],
            0,
            "「obsolete」は「もはや使用されていない」という意味で、使用が避けられるべきコードに対して使います。"
        ),
        (
            NSLocalizedString("quiz_verify_after_change", comment: "変更後に確認することを表す単語を選ぶクイズ"),
            ["instead", "invoked", "verify", "modify"],
            2,
            "「verify」は「確認・検証する」という意味で、テスト・品質確認の場面で使われます。"
        )
    ]
    
    let lifecycleQuestions: [(question: String, choices: [String], correctIndex: Int, explanation: String)] = [
        (
            NSLocalizedString("quiz_process_suspended", comment: "一時停止された状態を表す単語を選ぶクイズ"),
            ["persistent", "inherited", "suspended", "fetch"],
            2,
            "「suspended」はプロセスやタスクが一時停止中であることを意味します。"
        ),
        (
            NSLocalizedString("quiz_persistent_storage", comment: "永続的に保持されることを表す単語を選ぶクイズ"),
            ["embedded", "persistent", "asynchronous", "ancestor"],
            1,
            "「persistent」はデータが永続的に保存されることを意味します。"
        ),
        (
            NSLocalizedString("quiz_async_function", comment: "非同期に動作する関数を表す単語を選ぶクイズ"),
            ["suspended", "inherited", "asynchronous", "unbounded"],
            2,
            "「asynchronous」は非同期で動作し、すぐには完了しない処理を指します。"
        ),
        (
            NSLocalizedString("quiz_inherited_style", comment: "親から継承された属性を表す単語を選ぶクイズ"),
            ["fetch", "embed", "inherited", "permanent"],
            2,
            "「inherited」はスタイルやプロパティなどが親要素から受け継がれたことを表します。"
        ),
        (
            NSLocalizedString("quiz_fetch_data", comment: "データを取得する操作を表す単語を選ぶクイズ"),
            ["ancestor", "embed", "fetch", "unbounded"],
            2,
            "「fetch」は主にAPIなどからデータを取得する操作として使われます。"
        )
    ]

    let coreWordsQuestions: [(question: String, choices: [String], correctIndex: Int, explanation: String)] = [
        (
            NSLocalizedString("quiz_occurred", comment: "occurredの意味を問うクイズ"),
            ["試みる", "発生する・起こる", "継承する", "無効にする"],
            1,
            "「occurred」は何かが起こった、発生したことを意味します。"
        ),
        (
            NSLocalizedString("quiz_attempt", comment: "attemptの意味を問うクイズ"),
            ["表現する", "起動する", "試みる・試す", "一時停止する"],
            2,
            "「attempt」は「挑戦する・試す」ことを意味します。"
        ),
        (
            NSLocalizedString("quiz_suspended", comment: "suspendedの意味を問うクイズ"),
            ["保護された", "削除された", "一時停止中", "関連付けられた"],
            2,
            "「suspended」は一時的に停止されている状態を表します。"
        ),
        (
            NSLocalizedString("quiz_ancestor", comment: "ancestorの意味を問うクイズ"),
            ["デバッグ対象", "祖先・先祖", "対象外", "一時的な値"],
            1,
            "「ancestor」は親や上位構造の要素を意味します。"
        ),
        (
            NSLocalizedString("quiz_permanent", comment: "permanentの意味を問うクイズ"),
            ["仮の", "暫定的", "永続的な", "失効した"],
            2,
            "「permanent」は変更されない、恒久的な状態を指します。"
        )
    ]
    
    let coreWordsQuestions2: [(question: String, choices: [String], correctIndex: Int, explanation: String)] = [
        (
            NSLocalizedString("quiz_existing", comment: "existingの意味を問うクイズ"),
            ["既存の", "拡張された", "特定の", "作成中の"],
            0,
            "「existing」はすでに存在しているものを意味します。"
        ),
        (
            NSLocalizedString("quiz_related", comment: "relatedの意味を問うクイズ"),
            ["不明な", "関連している", "絶対の", "無効の"],
            1,
            "「related」は何かに関連している、関係があることを意味します。"
        ),
        (
            NSLocalizedString("quiz_opposed", comment: "opposedの意味を問うクイズ"),
            ["承認された", "優先された", "反対した", "保護された"],
            2,
            "「opposed」はある意見や提案に反対することを意味します。"
        ),
        (
            NSLocalizedString("quiz_absolute", comment: "absoluteの意味を問うクイズ"),
            ["相対的な", "絶対的な", "限定的な", "単純な"],
            1,
            "「absolute」は完全で例外のない、絶対的な状態を意味します。"
        ),
        (
            NSLocalizedString("quiz_illegal", comment: "illegalの意味を問うクイズ"),
            ["複雑な", "関連のある", "違法な", "永続的な"],
            2,
            "「illegal」は法に反していることを意味します。"
        )
    ]

    let coreWordsQuestions3: [(question: String, choices: [String], correctIndex: Int, explanation: String)] = [
        (
            NSLocalizedString("quiz_embed", comment: "embedの意味を問うクイズ"),
            ["削除する", "埋め込む", "再構成する", "無効化する"],
            1,
            "「embed」はデータやコードを内部に埋め込むことを意味します。"
        ),
        (
            NSLocalizedString("quiz_detected", comment: "detectedの意味を問うクイズ"),
            ["設定された", "選択された", "検出された", "保存された"],
            2,
            "「detected」は何かを感知・検出したことを意味します。"
        ),
        (
            NSLocalizedString("quiz_assume", comment: "assumeの意味を問うクイズ"),
            ["仮定する", "測定する", "追加する", "無視する"],
            0,
            "「assume」は事実として受け入れる仮定を意味します。"
        ),
        (
            NSLocalizedString("quiz_specify", comment: "specifyの意味を問うクイズ"),
            ["検証する", "割り当てる", "特定する", "回避する"],
            2,
            "「specify」は条件や内容を明確に指定することを意味します。"
        ),
        (
            NSLocalizedString("quiz_expression", comment: "expressionの意味を問うクイズ"),
            ["構文", "式・表現", "変数", "戻り値"],
            1,
            "「expression」は演算式や記述の表現そのものを意味します。"
        )
    ]


}
