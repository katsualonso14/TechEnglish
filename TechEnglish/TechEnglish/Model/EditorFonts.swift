import UIKit

// MARK: - Editor Fonts
// Monospace and UI fonts for code editor aesthetic

enum EditorFonts {
    
    // MARK: - Font Family Names
    
    /// Primary monospace font (SF Mono - Apple's coding font)
    private static let monospaceFontName = "SFMono-Regular"
    private static let monospaceBoldFontName = "SFMono-Bold"
    private static let monospaceSemiboldFontName = "SFMono-Semibold"
    private static let monospaceMediumFontName = "SFMono-Medium"
    
    /// Fallback monospace (Menlo - pre-installed on all iOS)
    private static let fallbackMonoFontName = "Menlo"
    
    // MARK: - Monospace Fonts (for code display)
    
    /// Regular monospace font
    static func mono(size: CGFloat) -> UIFont {
        if let font = UIFont(name: monospaceFontName, size: size) {
            return font
        }
        return UIFont(name: fallbackMonoFontName, size: size) ?? .monospacedSystemFont(ofSize: size, weight: .regular)
    }
    
    /// Bold monospace font
    static func monoBold(size: CGFloat) -> UIFont {
        if let font = UIFont(name: monospaceBoldFontName, size: size) {
            return font
        }
        return UIFont(name: "\(fallbackMonoFontName)-Bold", size: size) ?? .monospacedSystemFont(ofSize: size, weight: .bold)
    }
    
    /// Semibold monospace font
    static func monoSemibold(size: CGFloat) -> UIFont {
        if let font = UIFont(name: monospaceSemiboldFontName, size: size) {
            return font
        }
        return .monospacedSystemFont(ofSize: size, weight: .semibold)
    }
    
    /// Medium monospace font
    static func monoMedium(size: CGFloat) -> UIFont {
        if let font = UIFont(name: monospaceMediumFontName, size: size) {
            return font
        }
        return .monospacedSystemFont(ofSize: size, weight: .medium)
    }
    
    // MARK: - UI Fonts (SF Pro for interface elements)
    
    /// Regular UI font
    static func uiRegular(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .regular)
    }
    
    /// Bold UI font
    static func uiBold(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .bold)
    }
    
    /// Semibold UI font
    static func uiSemibold(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .semibold)
    }
    
    /// Medium UI font
    static func uiMedium(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .medium)
    }
    
    /// Light UI font
    static func uiLight(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .light)
    }
    
    // MARK: - Predefined Sizes
    
    enum Size {
        /// Caption text - 11pt
        static let caption: CGFloat = 11
        /// Small text - 13pt
        static let small: CGFloat = 13
        /// Body text - 15pt
        static let body: CGFloat = 15
        /// Subheadline - 17pt
        static let subheadline: CGFloat = 17
        /// Headline - 20pt
        static let headline: CGFloat = 20
        /// Title - 24pt
        static let title: CGFloat = 24
        /// Large title - 28pt
        static let largeTitle: CGFloat = 28
        /// Code block - 14pt
        static let code: CGFloat = 14
        /// Terminal - 13pt
        static let terminal: CGFloat = 13
        /// Line number - 12pt
        static let lineNumber: CGFloat = 12
    }
    
    // MARK: - Convenience Properties
    
    /// Code display font (14pt monospace)
    static var code: UIFont {
        return mono(size: Size.code)
    }
    
    /// Code display font bold
    static var codeBold: UIFont {
        return monoBold(size: Size.code)
    }
    
    /// Terminal font (13pt monospace)
    static var terminal: UIFont {
        return mono(size: Size.terminal)
    }
    
    /// Line number font
    static var lineNumber: UIFont {
        return mono(size: Size.lineNumber)
    }
    
    /// Word/Vocabulary display (larger monospace)
    static var word: UIFont {
        return monoBold(size: Size.title)
    }
    
    /// Pronunciation display
    static var pronunciation: UIFont {
        return mono(size: Size.body)
    }
}

// MARK: - Label Styling Extensions

extension UILabel {
    
    /// Style as code/keyword display
    func applyCodeStyle() {
        font = EditorFonts.code
        textColor = EditorTheme.textDefault
    }
    
    /// Style as comment
    func applyCommentStyle() {
        font = EditorFonts.mono(size: EditorFonts.Size.body)
        textColor = EditorTheme.comment
    }
    
    /// Style as keyword
    func applyKeywordStyle() {
        font = EditorFonts.monoBold(size: EditorFonts.Size.body)
        textColor = EditorTheme.keyword
    }
    
    /// Style as string literal
    func applyStringStyle() {
        font = EditorFonts.mono(size: EditorFonts.Size.body)
        textColor = EditorTheme.string
    }
    
    /// Style as type name
    func applyTypeStyle() {
        font = EditorFonts.monoSemibold(size: EditorFonts.Size.body)
        textColor = EditorTheme.type
    }
    
    /// Style as line number
    func applyLineNumberStyle() {
        font = EditorFonts.lineNumber
        textColor = EditorTheme.lineNumber
        textAlignment = .right
    }
}
