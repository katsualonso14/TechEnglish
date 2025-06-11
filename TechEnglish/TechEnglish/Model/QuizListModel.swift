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



}
