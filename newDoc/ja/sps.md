# Super Point Screen (SPS)

Super Point Screen（SPS）は広告ベースのオプション機能で、ユーザーが広告を閲覧・操作することで SPS ポイントを獲得できます。

---

## 前提条件

- SPS 機能は **SPS チームによるアプリへの有効化** が必要です。連携を始める前にご連絡ください。
- Reward SDK 7.0.0 以上が必要です。

---

## インストール

SPS には、メインの `RakutenRewardNativeSDK` に加えて `ScreenSDK` と `ScreenSDKCore` の 2 つの追加 XCFramework が必要です。

### CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS.git'

target 'YourApp' do
  pod 'RakutenRewardNativeSDK', '9.0.0'
end
```

---

## 認証

SPS はメインの Reward SDK とは異なる認証システムを使用します。CAT Exchange メカニズムで SPS 対応トークンを取得する必要があります。

### 必要な CAT スコープ

| オーディエンス | スコープ |
|---|---|
| `rakuten_sp_scr_web` | `sps-basic`、`sps-point`、`sps-register`、`sps-fast-reg` |

### `SdkTokenProvider` の実装

`SdkTokenProvider` は `ScreenSDKCore` のクラスです。使用するにはフレームワークをインポートしてください：

```swift
import ScreenSDKCore

class SPSTokenProvider: SdkTokenProvider {
    static let shared = SPSTokenProvider()

    func getSpsCompatToken(completionHandler: @escaping (SpsCompatToken?, Error?) -> Void) {
        // CAT Exchange トークンを渡します
        let token = SpsCompatToken.CatExchange(tokenValue: "YOUR_EXCHANGE_TOKEN")
        completionHandler(token, nil)
    }
}
```

---

## 初期化

メインの Reward SDK を初期化した後、アプリ起動時に SPS を一度初期化します：

```swift
RakutenMissionSps.shared.initSps(platform: "YOUR_PLATFORM_NAME") {
    SPSTokenProvider.shared
}
```

適切な `platform` 名については SPS チームにお問い合わせください。

---

## SPS ポータルを開く

```swift
RakutenReward.shared.openSpsPortal(rzCookie: yourRzCookie) { result in
    switch result {
    case .success:
        break
    case .failure(let error):
        // SDKError を処理する
    }
}
```

`rzCookie` パラメータは v8.5.0 から必須です。一元管理する場合：

```swift
RewardConfiguration.rzCookie = "your_rz_cookie"
```

### SPS 非会員の場合

ログインしているユーザーが SPS 会員でない場合、メインポータルの前に登録画面が表示されます。ユーザーはその画面から登録できます。

---

## クレイムポイント画面

SPS ライブラリが含まれている場合、標準の Reward SDK クレイムポイント画面が SPS 強化版に置き換わります。

---

## テーマの同期

ユーザーは SPS ポータルの設定画面で 2 つのテーマから選択できます：

| テーマ | 説明 |
|---|---|
| Panda | お買いものパンダのテーマ |
| Simple | シンプルなUIテーマ |

### テーマ変更の検知

SPS 内でユーザーがテーマを変更した際に反応します：

```swift
RakutenMissionSps.shared.didUpdateAppTheme = { theme in
    // 必要に応じてアプリの設定を同期する
}
```

### アプリからテーマを設定する

アプリ側のテーマ選択を SDK に反映します：

```swift
// パンダテーマ
RewardConfiguration.setTheme(.panda)

// シンプルテーマ
RewardConfiguration.setTheme(.simple)
```

---

> [![en](../../../docs/doc/lang/en.png)](../sps.md) English version
