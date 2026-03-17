# イベントアナリティクス

イベントアナリティクス（SDK v3.3.0 以降）は Analytics SDK のイベントと Reward SDK のミッションを連携させます。同じユーザーアクションでアナリティクスのデータとミッションのインセンティブの両方を同時に活用できます。

---

## 仕組み

1. アプリは Analytics SDK を直接使う代わりに `RakutenMissionEvent` を通じてアクションを記録します。
2. ミッションのマッピングが設定されていない場合、イベントは Analytics SDK にのみ送信されます。
3. Reward SDK 開発者ポータルでマッピング（Analytics イベント名 ↔ ミッションアクションコード）を設定すると、SDK は **Analytics SDK と Reward SDK の両方**にイベントを送信します。

アプリのコードを変更せずに、ポータルの設定だけでインセンティブを有効・無効にできます。

---

## インストール

Analytics SDK をプロジェクトに追加します：

**CocoaPods：**

```ruby
pod 'RAnalytics', :source => 'https://github.com/rakutentech/ios-analytics-framework.git'
```

**Swift Package Manager：**

```
SSH:   git@github.com:rakutentech/ios-analytics-framework.git
HTTPS: https://github.com/rakutentech/ios-analytics-framework.git
```

Analytics SDK の完全なドキュメント：https://documents.developers.rakuten.com/ios-sdk/analytics-9.1/

---

## 機能の有効化

```swift
RewardConfiguration.isMissionEventFeatureEnabled = true
```

---

## イベントの送信

```swift
RakutenMissionEvent.shared.logAction(
    eventCode: "YOUR_EVENT_CODE",
    eventTrackingType: .ratSpecificEvent,
    parameters: nil
) { error in
    if let error {
        // エラーを処理する
        return
    }
    // 成功
}
```

### パラメーター

| パラメーター | 型 | 説明 |
|---|---|---|
| `eventCode` | `String` | Analytics SDK のイベントコード |
| `eventTrackingType` | `RakutenMissionEventTrackingType` | 下記を参照 |
| `parameters` | `[String: Any]?` | 任意の Analytics SDK パラメーター |

### `RakutenMissionEventTrackingType`

| 値 | 説明 |
|---|---|
| `.genericEvent` | 通常イベントのトラッキング |
| `.ratSpecificEvent` | Analytics SDK RAT 固有イベントのトラッキング |

---

> [![en](../images/en.png)](../event-analytics.md) English version
