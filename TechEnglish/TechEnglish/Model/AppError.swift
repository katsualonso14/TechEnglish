import Foundation

/// アプリケーション固有のエラータイプ
enum AppError: LocalizedError {
    case notificationError(String)
    case audioSessionError(String)
    case dataEncodingError(String)
    case dataDecodingError(String)
    case networkError(String)
    case userDefaultsError(String)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .notificationError(let message):
            return NSLocalizedString("error_notification", comment: "") + ": \(message)"
        case .audioSessionError(let message):
            return NSLocalizedString("error_audio_session", comment: "") + ": \(message)"
        case .dataEncodingError(let message):
            return NSLocalizedString("error_data_encoding", comment: "") + ": \(message)"
        case .dataDecodingError(let message):
            return NSLocalizedString("error_data_decoding", comment: "") + ": \(message)"
        case .networkError(let message):
            return NSLocalizedString("error_network", comment: "") + ": \(message)"
        case .userDefaultsError(let message):
            return NSLocalizedString("error_user_defaults", comment: "") + ": \(message)"
        case .unknown(let error):
            return NSLocalizedString("error_unknown", comment: "") + ": \(error.localizedDescription)"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .notificationError:
            return NSLocalizedString("error_notification_reason", comment: "")
        case .audioSessionError:
            return NSLocalizedString("error_audio_session_reason", comment: "")
        case .dataEncodingError, .dataDecodingError:
            return NSLocalizedString("error_data_reason", comment: "")
        case .networkError:
            return NSLocalizedString("error_network_reason", comment: "")
        case .userDefaultsError:
            return NSLocalizedString("error_user_defaults_reason", comment: "")
        case .unknown:
            return NSLocalizedString("error_unknown_reason", comment: "")
        }
    }
}

/// エラーハンドリングユーティリティ
class ErrorHandler {
    
    /// エラーを処理し、ログ記録とユーザー通知を行う
    /// - Parameters:
    ///   - error: 発生したエラー
    ///   - context: エラーが発生したコンテキスト（クラス名、メソッド名など）
    ///   - viewController: エラーメッセージを表示するViewController（オプション）
    ///   - showAlert: ユーザーにアラートを表示するかどうか
    static func handle(
        _ error: Error,
        context: String = "",
        in viewController: UIViewController? = nil,
        showAlert: Bool = true
    ) {
        let appError: AppError
        if let customError = error as? AppError {
            appError = customError
        } else {
            appError = .unknown(error)
        }
        
        // ログ記録
        logError(appError, context: context)
        
        // ユーザーへの通知
        if showAlert, let viewController = viewController {
            showErrorAlert(error: appError, in: viewController)
        }
    }
    
    /// エラーログを記録
    private static func logError(_ error: AppError, context: String) {
        let errorMessage = """
        ⚠️ Error Occurred
        Context: \(context.isEmpty ? "Unknown" : context)
        Error: \(error.localizedDescription)
        Reason: \(error.failureReason ?? "Unknown")
        Timestamp: \(Date())
        """
        
        // コンソールに出力（開発時）
        print(errorMessage)
        
        // 本番環境ではFirebase Crashlyticsなどに送信
        // Crashlytics.crashlytics().record(error: error)
    }
    
    /// エラーアラートを表示
    private static func showErrorAlert(error: AppError, in viewController: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: NSLocalizedString("error_alert_title", comment: ""),
                message: error.localizedDescription,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("ok_button", comment: ""),
                style: .default
            ))
            
            viewController.present(alert, animated: true)
        }
    }
    
    /// サイレントエラー（ユーザー通知なし）
    static func handleSilently(
        _ error: Error,
        context: String = ""
    ) {
        handle(error, context: context, in: nil, showAlert: false)
    }
}


