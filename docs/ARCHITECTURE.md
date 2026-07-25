# TechEnglish — 目標アーキテクチャ（実装部署の受け皿）

TechEnglish の実装は katy-company の実装部署（`swift-implement`）が行う。
このファイルは、実装部署がスムーズに・保守性高く書くための **目標アーキテクチャと参照テンプレート**。
日々効かせる要点は repo root の `CLAUDE.md`、背景と型の全体像はここ。

## 前提

- **既存は現状の UIKit MVC（厚い VC ＋ Manager シングルトン）。移設はしない。**
- **新規コードからこの「薄いレイヤード MVC」を適用する。** 触るついでの小さな寄せはOK、大掛かりな既存リファクタは依頼があるときだけ。

## レイヤー（薄いレイヤード MVC）

```
┌──────────────────────────────────────────────┐
│ Controller/  ViewController                   │  表示・画面遷移・入力受け（薄く）
└───────────────┬──────────────────────────────┘
                │ 呼ぶ
┌───────────────▼──────────────────────────────┐
│ Service/  ロジック・UseCase                    │  判断・加工・組み立て（UIKit非依存）
│   ※既存の Model/Manager/ シングルトンも同役割   │
└───────────────┬──────────────────────────────┘
                │ プロトコル越しに参照（DI）
┌───────────────▼──────────────────────────────┐
│ Repository/  データ入出力の集約                 │  永続化の詳細をここに閉じ込める
└───────────────┬──────────────────────────────┘
                │
┌───────────────▼──────────────────────────────┐
│ Realm（ローカル）/ Firestore（リモート）/       │
│ UserDefaults（設定・フラグ）                    │
└──────────────────────────────────────────────┘
```

### 各層の責務と禁止事項

| 層 | やること | やらないこと |
|----|---------|------------|
| ViewController | View 構築・遷移・入力を Service に渡す・結果を表示 | Realm/Firestore/UserDefaults を直接触る／ビジネス判断 |
| Service | 判断・加工・複数 Repository の組み立て。純粋ロジック | UIKit の import（原則）／永続化の詳細 |
| Repository | Realm/Firestore/UserDefaults の read/write を隠蔽。プロトコルで公開 | ビジネス判断／UI |
| Model | 値オブジェクト・Realm オブジェクト | ロジック |

**保守性の肝：**
1. VC からデータ層を直接触らない（必ず Repository 越し）。
2. Repository は**プロトコルで公開して DI**（テストで mock 差し替え）。
3. Service は UIKit 非依存に寄せる（単体テストしやすい）。

## ディレクトリ配置

`TechEnglish/TechEnglish/TechEnglish/` 配下：

| 種類 | 置き場 | 例 |
|------|--------|----|
| 画面（薄い VC） | `Controller/<機能>/` | `Quiz/QuizViewController.swift` |
| ロジック（新規） | `Service/` | `QuizService.swift` |
| 既存ロジック | `Model/Manager/`（レガシー） | `DailyWordManager.swift` |
| データ入出力 | `Repository/` | `RealmMyCardRepository.swift` |
| データモデル | `Model/` | `MyCard.swift` |
| 再利用 View・セル | `View/Parts/` | `MyCardsCell.swift` |

> `Service/` `Repository/` は最初にそこへ書く機能が作る。Xcode 16 の synchronized group なので
> フォルダに置けば基本自動でターゲットに入る（`CLAUDE.md` の sync-group 注意点参照）。

## 参照テンプレート（新規機能の型）

新しく「単語カード（MyCard）一覧」を作る想定の最小スライス。**この形をコピーして機能名を差し替える。**
※ 命名・型は既存コードの実体に合わせること（下は型の説明用サンプル）。

### 1. Repository（プロトコル＋具象）

```swift
// Repository/MyCardRepository.swift
protocol MyCardRepository {
    func fetchAll() -> [MyCard]
    func add(_ card: MyCard) throws
}

// Repository/RealmMyCardRepository.swift
import RealmSwift

final class RealmMyCardRepository: MyCardRepository {
    private let realm: Realm
    init(realm: Realm = try! Realm()) { self.realm = realm }

    func fetchAll() -> [MyCard] {
        // Realm オブジェクト → 値オブジェクトへ変換して返す（Realm 型を外に漏らさない）
        realm.objects(MyCardObject.self).map { $0.toDomain() }
    }

    func add(_ card: MyCard) throws {
        try realm.write {                       // ← 書き込みは必ず transaction 内
            realm.add(MyCardObject(from: card), update: .modified)
        }
    }
}
```

### 2. Service（ロジック・UIKit 非依存）

```swift
// Service/MyCardService.swift
final class MyCardService {
    private let repository: MyCardRepository   // ← プロトコルに依存（DI）
    init(repository: MyCardRepository = RealmMyCardRepository()) {
        self.repository = repository
    }

    func cards() -> [MyCard] { repository.fetchAll() }

    func save(word: String, sentence: String) throws {
        // 判断・バリデーションはここ（VC ではなく Service）
        let trimmed = word.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { throw AppError.emptyWord }
        try repository.add(MyCard(word: trimmed, sentence: sentence))
    }
}
```

### 3. ViewController（薄く）

```swift
// Controller/MyCards/MyCardsViewController.swift
final class MyCardsViewController: UIViewController {
    private let service = MyCardService()      // 本番は既定 DI、テストは差し替え

    private func reload() {
        let cards = service.cards()
        DispatchQueue.main.async { [weak self] in   // ← UI 更新はメインスレッド
            self?.render(cards)
        }
    }

    private func onSaveTapped(word: String, sentence: String) {
        do {
            try service.save(word: word, sentence: sentence)
            reload()
        } catch {
            presentError(error)                 // 表示だけ。判断は Service 済み
        }
    }
}
```

VC は「表示・遷移・入力を Service に渡す」だけ。判断とデータ入出力は下の層に降りている。

## 技術スタック

UIKit / SnapKit / FSCalendar / Realm(RealmSwift) / Firebase(Firestore, Analytics) /
RevenueCat（entitlement `"ad_free"`）/ Google Mobile Ads / SwiftLinkPreview。
正は `Podfile`。

## 既存の主要な仕組み（現状把握）

- **起動フロー（AppDelegate）**：通知許可 → `FirebaseApp.configure()` → `PurchaseManager.shared.configure()`。
- **Manager パターン（レガシー Service）**：`static let shared` + `private init()`。設定は `UserDefaults` プロパティで公開、
  状態変化は `NotificationCenter` の named notification で伝播（例：`PurchaseManager.adFreeStatusChangedNotification`）。
- **課金**：RevenueCat Non-Consumable。`PurchaseManager.shared.isAdFree`（UserDefaults キャッシュ）で同期参照。

新規実装ではこれらを「Service 層の先例」として踏襲しつつ、データ入出力は Repository に寄せる。

## Git 運用

`main` 凍結。`develop` 中心。作業ブランチの起点・PR base は常に `develop`。

## 正のドキュメント

規約・チェックリスト・ビルド/アップロードの完全手順は
katy-company `docs/implementation/swift-guide.md`。
