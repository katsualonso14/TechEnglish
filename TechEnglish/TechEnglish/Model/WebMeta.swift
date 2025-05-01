

// User stock web information
struct WebMeta: Codable {
    let title: String       // ページタイトル
    let url: String         // 実際のURL
    let domain: String      // ドメイン（例: qiita.com）
    let faviconURL: String? // Favicon画像のURL（nilの可能性あり）
}
