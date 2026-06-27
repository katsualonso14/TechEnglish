import UIKit

// MARK: - Editor Theme
// VS Code Dark+ inspired color palette for engineer-focused UI

enum EditorTheme {
    
    // MARK: - Background Colors (Editor backgrounds)
    
    /// Main editor background - #1E1E1E
    static let editorBackground = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
    
    /// Sidebar/Activity bar background - #252526
    static let sidebarBackground = UIColor(red: 37/255, green: 37/255, blue: 38/255, alpha: 1.0)
    
    /// Tab bar background - #2D2D2D
    static let tabBarBackground = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
    
    /// Active tab background - #1E1E1E
    static let activeTabBackground = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
    
    /// Status bar background - #007ACC
    static let statusBarBackground = UIColor(red: 0/255, green: 122/255, blue: 204/255, alpha: 1.0)
    
    /// Terminal background - #1E1E1E
    static let terminalBackground = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
    
    /// Line highlight - #2A2D2E
    static let lineHighlight = UIColor(red: 42/255, green: 45/255, blue: 46/255, alpha: 1.0)
    
    /// Selection background - #264F78
    static let selectionBackground = UIColor(red: 38/255, green: 79/255, blue: 120/255, alpha: 1.0)
    
    // MARK: - Text Colors (Syntax highlighting)
    
    /// Default text - #D4D4D4
    static let textDefault = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1.0)
    
    /// Comment text - #6A9955
    static let comment = UIColor(red: 106/255, green: 153/255, blue: 85/255, alpha: 1.0)
    
    /// Keyword (if, else, func, class) - #569CD6
    static let keyword = UIColor(red: 86/255, green: 156/255, blue: 214/255, alpha: 1.0)
    
    /// String literals - #CE9178
    static let string = UIColor(red: 206/255, green: 145/255, blue: 120/255, alpha: 1.0)
    
    /// Numbers - #B5CEA8
    static let number = UIColor(red: 181/255, green: 206/255, blue: 168/255, alpha: 1.0)
    
    /// Function names - #DCDCAA
    static let function = UIColor(red: 220/255, green: 220/255, blue: 170/255, alpha: 1.0)
    
    /// Type names (class, struct, enum) - #4EC9B0
    static let type = UIColor(red: 78/255, green: 201/255, blue: 176/255, alpha: 1.0)
    
    /// Variable names - #9CDCFE
    static let variable = UIColor(red: 156/255, green: 220/255, blue: 254/255, alpha: 1.0)
    
    /// Property names - #9CDCFE
    static let property = UIColor(red: 156/255, green: 220/255, blue: 254/255, alpha: 1.0)
    
    /// Constant values - #4FC1FF
    static let constant = UIColor(red: 79/255, green: 193/255, blue: 255/255, alpha: 1.0)
    
    /// Operators (+, -, *, /) - #D4D4D4
    static let operatorColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1.0)
    
    // MARK: - Accent Colors
    
    /// Primary accent (VS Code blue) - #007ACC
    static let accentPrimary = UIColor(red: 0/255, green: 122/255, blue: 204/255, alpha: 1.0)
    
    /// Secondary accent (Green for success) - #4EC9B0
    static let accentSuccess = UIColor(red: 78/255, green: 201/255, blue: 176/255, alpha: 1.0)
    
    /// Warning accent - #CCA700
    static let accentWarning = UIColor(red: 204/255, green: 167/255, blue: 0/255, alpha: 1.0)
    
    /// Error accent - #F14C4C
    static let accentError = UIColor(red: 241/255, green: 76/255, blue: 76/255, alpha: 1.0)
    
    /// Info accent - #3794FF
    static let accentInfo = UIColor(red: 55/255, green: 148/255, blue: 255/255, alpha: 1.0)
    
    // MARK: - UI Element Colors
    
    /// Border/Separator color - #3C3C3C
    static let border = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1.0)
    
    /// Inactive text - #808080
    static let textInactive = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
    
    /// Line numbers - #858585
    static let lineNumber = UIColor(red: 133/255, green: 133/255, blue: 133/255, alpha: 1.0)
    
    /// Scrollbar - #5A5A5A with alpha
    static let scrollbar = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 0.5)
    
    /// Badge/Notification background - #4D4D4D
    static let badge = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
    
    // MARK: - Git Colors (Gutter decorations)
    
    /// Git added - #587C0C
    static let gitAdded = UIColor(red: 88/255, green: 124/255, blue: 12/255, alpha: 1.0)
    
    /// Git modified - #0C7D9D
    static let gitModified = UIColor(red: 12/255, green: 125/255, blue: 157/255, alpha: 1.0)
    
    /// Git deleted - #94151B
    static let gitDeleted = UIColor(red: 148/255, green: 21/255, blue: 27/255, alpha: 1.0)
    
    // MARK: - Semantic Colors
    
    /// Primary button background
    static let buttonPrimary = accentPrimary
    
    /// Primary button text
    static let buttonPrimaryText = UIColor.white
    
    /// Secondary button background
    static let buttonSecondary = sidebarBackground
    
    /// Secondary button text
    static let buttonSecondaryText = textDefault
    
    /// Card/Panel background
    static let cardBackground = sidebarBackground
    
    /// Hover/Focus state
    static let hoverBackground = UIColor(red: 42/255, green: 45/255, blue: 46/255, alpha: 1.0)
}

// MARK: - Theme Application Helpers

extension EditorTheme {
    
    /// Apply editor theme to navigation bar
    static func applyToNavigationBar(_ navigationBar: UINavigationBar) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = tabBarBackground
        appearance.titleTextAttributes = [
            .foregroundColor: textDefault,
            .font: EditorFonts.uiSemibold(size: 17)
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: textDefault,
            .font: EditorFonts.uiBold(size: 34)
        ]
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = accentPrimary
    }
    
    /// Apply editor theme to tab bar
    static func applyToTabBar(_ tabBar: UITabBar) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = tabBarBackground
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = textInactive
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: textInactive]
        itemAppearance.selected.iconColor = accentPrimary
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: accentPrimary]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    /// Configure view with editor background
    static func applyEditorBackground(to view: UIView) {
        view.backgroundColor = editorBackground
    }
    
    /// Apply editor theme to UIAlertController
    static func styleAlert(_ alert: UIAlertController) {
        alert.view.tintColor = accentPrimary
        
        if let subview = alert.view.subviews.first?.subviews.first?.subviews.first {
            subview.backgroundColor = sidebarBackground
        }
    }
    
    /// Apply editor theme to modal view controller
    static func applyToModalViewController(_ viewController: UIViewController) {
        viewController.overrideUserInterfaceStyle = .dark
        viewController.view.backgroundColor = editorBackground
        
        if let sheet = viewController.sheetPresentationController {
            sheet.preferredCornerRadius = 12
        }
    }
    
    /// Create styled text field for editor theme
    static func createStyledTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = editorBackground
        textField.textColor = textDefault
        textField.font = EditorFonts.mono(size: EditorFonts.Size.body)
        textField.layer.borderColor = border.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 6
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        textField.leftViewMode = .always
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [.foregroundColor: textInactive]
        )
        
        return textField
    }
}
