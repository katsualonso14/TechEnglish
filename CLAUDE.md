# CLAUDE.md

このリポジトリで Claude Code / katy-company 実装部署が作業するときのガイド。
実装前に最初に読むファイル。

## この repo の位置づけ

TechEnglish の実装は **katy-company の実装部署**（`company:implementation` → `swift-implement` スキル）が行う。
- ルール・ビルド/アップロード手順・チェックリストの「正」は katy-company `docs/implementation/swift-guide.md`。
- このファイルと `docs/ARCHITECTURE.md` は、そのスキルが読む **プロジェクト固有の受け皿**（構造・置き場・規約）。

## Platform

**iOS ネイティブ（UIKit）。** リリースは iOS のみ、IPA でアップロードする。

## Repository Layout

git repo ルートはこのファイルの場所。Xcode プロジェクトは 1 階層下。

```
TechEnglish/                 # ← git repo root（このCLAUDE.md）
└── TechEnglish/             # ← Xcode プロジェクトルート（.xcworkspace はここ）
    ├── TechEnglish.xcworkspace   # CocoaPods 使用 → 常にこれを開く（.xcodeproj ではない）
    ├── Podfile / Podfile.lock / Pods/
    └── TechEnglish/         # ← Swift ソース本体
        ├── App/             # AppDelegate, SceneDelegate（起動・DI・Firebase初期化）
        ├── Controller/      # 画面ごとの ViewController（機能別サブフォルダ）
        ├── Service/         # 【新規】ビジネスロジック／UseCase（新規実装はここ）
        ├── Repository/      # 【新規】データ入出力の集約（Realm/Firestore/UserDefaults）
        ├── Model/           # 値オブジェクト・Realm オブジェクト
        │   └── Manager/     # 既存のシングルトンService（レガシー。新規はService/へ）
        └── View/Parts/      # 再利用 View・セル
```

> `Service/` `Repository/` は目標アーキテクチャの置き場。最初にそこへ書く機能が
> ディレクトリを作る（既存の動いている画面は移設しない）。

## 目標アーキテクチャ（新規コードの基準）

**薄いレイヤード MVC。** 詳細と参照テンプレートは `docs/ARCHITECTURE.md`。

```
Controller/  ViewController … 薄く。表示・遷移・入力受けだけ
    ↓ 呼ぶ
Service/     ロジック・UseCase … 判断/加工はここ（既存 Manager シングルトンもこの役割）
    ↓ 参照（プロトコル越し）
Repository/  データ入出力を集約 … Realm / Firestore / UserDefaults をここに閉じ込める
    ↓
Realm（ローカル）/ Firestore（リモート）/ UserDefaults（設定）
```

**契約（守ると保守性が上がる要点）:**
- ViewController から Realm / Firestore / UserDefaults を**直接触らない**。必ず Repository 越し（多くは Service 経由）。
- Repository は**プロトコルで公開**し、具象（`RealmXxxRepository` 等）を DI する（テストで差し替え可能にする）。
- Service は UIKit に依存しない純粋ロジックを目指す（テストしやすさ）。

## 実装順序（下から上）

```
Model → Repository → Service → ViewController → View
```
触らない層はスキップする。

## Rules (Critical)

- **移行方針：新規コードからこの型を適用する。** 既存の動いている画面・Manager は現状維持（依頼が無ければリファクタしない）。
- **新規 `.swift` は Xcode ターゲット登録を確認する。** Xcode 16 の synchronized group（`objectVersion = 77`）でフォルダ内は基本自動登録されるが、`membershipExceptions`（PBXFileSystemSynchronizedBuildFileExceptionSet）で除外され得る。ビルドで `cannot find X in scope` が出たら `TechEnglish.xcodeproj/project.pbxproj` の除外リストを確認。
- **`main` は当面凍結。** 作業ブランチの起点・PR の base は常に `develop`。指示があるまで `main` は触らない。
- 既存パターンを踏襲。既存ファイルを優先して修正し、新規作成は最小限。関係ないコードはリファクタしない。
- `guard let`/`if let` で安全にアンラップ。強制アンラップ（`!`）を避ける。
- UI 更新は必ずメインスレッド（`DispatchQueue.main.async`）。
- クロージャのキャプチャは `[weak self]` を基本。
- Realm の書き込みは必ずトランザクション内（`realm.write { }`）。Firestore のリスナーは `deinit` で解除。
- Pod を追加したら `pod install` → `Podfile.lock` の差分をコミット。

## Commands

CocoaPods を使うため **必ず `.xcworkspace`**。コマンドは Xcode プロジェクトルート（`TechEnglish/TechEnglish/`）で実行。

```bash
cd TechEnglish
pod install
# ビルド（シミュレータ）
xcodebuild -workspace TechEnglish.xcworkspace -scheme TechEnglish \
  -destination 'platform=iOS Simulator,name=iPhone 16' build
```

ビルド/アーカイブ/IPA/アップロードの完全手順は katy-company `docs/implementation/swift-guide.md`。

## 参照

- 目標アーキテクチャの詳細と実装テンプレート：`docs/ARCHITECTURE.md`
- 実装ガイド・規約・チェックリスト・ビルド手順（正）：katy-company `docs/implementation/swift-guide.md`
