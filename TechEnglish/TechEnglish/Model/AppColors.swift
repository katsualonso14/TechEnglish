import Foundation
import UIKit

// MARK: - App Colors (Legacy + Editor Theme Bridge)
// Maintains backward compatibility while integrating EditorTheme

enum AppColors {
    
    // MARK: - Legacy Colors (Backward Compatibility)
    
    static let textColor = EditorTheme.textDefault
    
    static let backgroundColorCheckMode = EditorTheme.editorBackground
    
    static let appMainColor = EditorTheme.accentPrimary
    
    // MARK: - Editor Theme Shortcuts
    
    static var editorBackground: UIColor { EditorTheme.editorBackground }
    static var sidebarBackground: UIColor { EditorTheme.sidebarBackground }
    static var tabBarBackground: UIColor { EditorTheme.tabBarBackground }
    
    static var syntaxKeyword: UIColor { EditorTheme.keyword }
    static var syntaxString: UIColor { EditorTheme.string }
    static var syntaxComment: UIColor { EditorTheme.comment }
    static var syntaxType: UIColor { EditorTheme.type }
    static var syntaxFunction: UIColor { EditorTheme.function }
    static var syntaxVariable: UIColor { EditorTheme.variable }
    static var syntaxNumber: UIColor { EditorTheme.number }
    
    static var accentPrimary: UIColor { EditorTheme.accentPrimary }
    static var accentSuccess: UIColor { EditorTheme.accentSuccess }
    static var accentWarning: UIColor { EditorTheme.accentWarning }
    static var accentError: UIColor { EditorTheme.accentError }
    
    static var border: UIColor { EditorTheme.border }
    static var lineHighlight: UIColor { EditorTheme.lineHighlight }
}



