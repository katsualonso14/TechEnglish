
// WebView検索結果切り分け用のEnum

enum WebContentType {
    case word(String)  // 単語検索用
    case url(String)   // URL直接表示用
}
