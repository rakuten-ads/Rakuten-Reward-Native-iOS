# AdMob 連携ガイド（iOS）

> [![en](../images/en.png)](../admob.md) English version

このガイドでは、Rakuten Reward SDK のオプション機能として Google AdMob インタースティシャル広告をアプリに追加する方法を説明します。

---

## 概要

デフォルト構成では、アプリは次の SDK を使用します：

| SDK | 必須 | 用途 |
|---|---|---|
| `RakutenRewardNativeSDK` | はい | コア Reward SDK |
| `RakutenRewardAdMob` | **任意** | AdMob インタースティシャル広告サポート |
| `Google-Mobile-Ads-SDK` | **任意** | Google AdMob SDK（CocoaPods: 自動で取得、SPM: 手動で追加が必要） |

`RakutenRewardAdMob` を追加しない場合、SDK はこれまでと同じ動作をします。コードの変更は不要です。

---

## 機能の説明

ユーザーが SPS ポイントを獲得すると、SDK は自動的にフルスクリーンのインタースティシャル広告を表示します。ユーザーが広告を閉じると、SPS のフローが通常通り継続されます。広告ユニット ID はサーバーで管理されるため、アプリにハードコードする必要はありません。

---

## 要件

- iOS 14.0 以上
- `RakutenRewardNativeSDK` ~> 9.3.0
- Google-Mobile-Ads-SDK ~> 12.14（CocoaPods: 自動で取得、SPM: 手動で追加が必要 — 下記インストールを参照）
- `Info.plist` に `GADApplicationIdentifier` が必要（Google の要件 — この設定がないとアプリ起動時にクラッシュします）

---

## インストール

### CocoaPods

コア SDK と合わせて `RakutenRewardAdMob` を Podfile に追加します：

```ruby
pod 'RakutenRewardNativeSDK', '~> 9.3.0'
pod 'RakutenRewardAdMob',     '~> 9.3.0'
```

その後、以下を実行します：

```
pod install
```

`Google-Mobile-Ads-SDK` は依存ライブラリとして自動で取得されます。個別に追加する必要はありません。

### Swift Package Manager

SPM のバイナリターゲットは依存ライブラリを宣言できないため、`GoogleMobileAds` は自動で取得されません。2 つのパッケージを手動で追加する必要があります。

**ステップ 1** — Xcode で **File > Add Package Dependencies** を選択し、Rakuten Reward SDK を追加します：
```
https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS-SPM
```
プロダクト一覧から `RakutenRewardNativeSDK` と `RakutenRewardAdMob` を選択します。

**ステップ 2** — Google Mobile Ads パッケージを追加します：
```
https://github.com/googleads/swift-package-manager-google-mobile-ads.git
```
プロダクト一覧から `GoogleMobileAds` を選択します。バージョンルールは `>= 12.14.0` を推奨します（SPM では強制されないため、アプリの要件に合わせて設定してください）。

---

## セットアップ

以下の 3 つのステップで連携を完了します。

### ステップ 1 — Info.plist に AdMob アプリ ID を追加する

Google は SDK 初期化前に `GADApplicationIdentifier` を必要とします。**このキーがない場合、アプリ起動時にクラッシュします。**

[AdMob コンソール](https://admob.google.com)から取得した実際のアプリ ID を追加します：

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy</string>
```

> **開発・テスト時のみ**、Google の公式テスト用アプリ ID を使用できます：
> ```xml
> <key>GADApplicationIdentifier</key>
> <string>ca-app-pub-3940256099942544~1458002511</string>
> ```
> App Store に申請する前に、実際のアプリ ID に置き換えてください。

### ステップ 2 — 起動時に `configure()` を呼び出す

アプリのエントリポイントで、Reward SDK の呼び出しよりも前に `RakutenRewardAdMobAdapter.configure()` を呼び出します：

**SwiftUI アプリ：**

```swift
import RakutenRewardAdMob

@main
struct MyApp: App {
    init() {
        RakutenRewardAdMobAdapter.configure()
    }
    // ...
}
```

**UIKit AppDelegate：**

```swift
import RakutenRewardAdMob

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    RakutenRewardAdMobAdapter.configure()
    return true
}
```

以上で連携は完了です。広告ユニット ID はサーバーから自動的に取得されます。追加の設定は不要です。

---

## すでに AdMob を使用している場合

追加の手順は不要です。Podfile または SPM に `RakutenRewardAdMob` を追加し、`configure()` を呼び出すだけです。

| 懸念事項 | 対応内容 |
|---|---|
| Podfile にすでに `Google-Mobile-Ads-SDK` がある | CocoaPods が自動的に単一のコピーに解決します |
| SPM にすでに `GoogleMobileAds` がある | 競合なし — 既存のパッケージエントリをそのまま使用できます。再追加は不要です |
| 既存のバージョンが 12.14 より古い | 更新が必要です：`pod 'Google-Mobile-Ads-SDK', '~> 12.14'`。標準的な広告ロードの API は後方互換性があります |
| 既存のバージョンが 12.x より新しい | 対応不要 — `RakutenRewardAdMob` は安定した非推奨でない API のみを使用しており、新しいバージョンでも動作します |
| すでに `MobileAds.shared.start(completionHandler:)` を呼び出している | 問題ありません — `configure()` 内で呼び出されますが、Google の `start()` は冪等です |

---

## AdMob サポートを削除する

Podfile または SPM から `RakutenRewardAdMob` を削除し、`configure()` の呼び出しを削除します。Reward SDK は引き続き正常に動作します — SPS フローへの影響はありません。
