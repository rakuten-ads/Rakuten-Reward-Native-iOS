# Rakuten Reward SDK ネイティブ — iOS

[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://developer.apple.com/ios/)
[![iOS](https://img.shields.io/badge/iOS-14%2B-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-6.x-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-26.2-blue.svg)](https://developer.apple.com/xcode/)
[![Version](https://img.shields.io/badge/version-9.1.0-green.svg)](changelog.md)

Rakuten Reward SDK を使って楽天リワードのミッション機能をiOSアプリに組み込めます。
ユーザーはアプリ内のアクションを完了してポイントを獲得できます。ミッションの管理・ポイントのクレイム・組み込みUIはSDKが提供します。

---

## 動作要件

| 要件 | 値 |
|---|---|
| Xcode | 26.2 以上 |
| Swift | 6.x |
| iOS デプロイターゲット | 14.0 以上 |
| SDK バージョン | 9.1.0 |

### バージョン互換表

| SDK バージョン | 最低 iOS | Xcode |
|---|---|---|
| 1.x | 9 | 11 |
| 2.x | 9 | 12 |
| 3.x | 9 | 13 |
| 4.x | 11 | 14 |
| 5.x | 11 | 14 |
| 6.x | 11 | 15 |
| 7.x | 13 | 15 |
| 8.x | 13 | 16 |
| 9.x | 14 | 26 |

---

## SDKのインストール

### CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS.git'

target 'YourApp' do
  pod 'RakutenRewardNativeSDK', '9.1.0'
end
```

### Swift Package Manager

```swift
dependencies: [
    .package(
        url: "https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS-SPM",
        .exact("9.1.0")
    ),
]
```

### Carthage

`Cartfile` に以下を追加してください：

```
binary "https://raw.githubusercontent.com/rakuten-ads/Rakuten-Reward-Native-iOS/master/CarthageSpec.json" == 9.1.0
```

XCFramework を使って Carthage を実行します：

```bash
carthage update --platform ios --use-xcframeworks
```

Carthage でビルドされた `XCFramework` をターゲットの **Frameworks, Libraries, and Embedded Content** にドラッグ＆ドロップしてください。

---

## クイックスタート

```swift
// 1. リージョンを設定（現在は日本のみ）
RakutenReward.shared.region = .japan

// 2. トークンプロバイダーで初期化（v9 推奨方法）
RakutenReward.shared.initSdk(
    appCode: "YOUR_APP_CODE",
    tokenType: .rid,
    tokenProvider: MyTokenProvider.shared
)

// 3. ユーザーがアクションを行ったときにログを記録する
RakutenReward.shared.logAction(actionCode: "YOUR_ACTION_CODE") { _ in }
```

詳細については [認証と初期化](authentication.md) をご覧ください。

---

## ドキュメント

| 目的 | ドキュメント |
|---|---|
| SDKの初期化 | [認証と初期化](authentication.md) |
| ユーザーのポイント獲得 | [ミッションとポイントのクレイム](missions.md) |
| ユーザーのプライバシー同意 | [利用規約への同意](user-consent.md) |
| SDKポータル・SPSポータルの表示 | [ポータル](portal.md) |
| Super Point Screen 広告の組み込み | [Super Point Screen (SPS)](sps.md) |
| WebView から SDK API を呼び出す | [JavaScript 拡張機能](js-extension.md) |
| APIの詳細を調べる | [API リファレンス](api-reference.md) |
| バージョンアップ | [v9 移行ガイド](migration-to-v9.md) |
| リリース内容の確認 | [更新履歴](changelog.md) |

---

> [![en](../../docs/doc/lang/en.png)](../README.md) English version

---

## オープンソース

本 SDK は [KeychainSwiftWrapper](https://github.com/jrendel/SwiftKeychainWrapper) を使用しています。
Marcin Krzyzanowski (http://krzyzanowskim.com/) によって開発されたソフトウェアが含まれています。
