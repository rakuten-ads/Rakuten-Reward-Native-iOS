# ミッションとポイントのクレイム

ミッションはユーザーがリワードポイントを獲得するために完了すべきアクションです。ミッションとアクションコードは楽天リワード SDK 開発者ポータルで設定します。

---

## ミッションの仕組み

1. ミッションには**アクションコード**と**必要回数**があります（例：「ボタンを3回タップ」）。
2. ユーザーがアクションを行うたびにアプリが `logAction` を呼び出します。
3. 回数に達すると、SDKはミッションを達成済みとしてマークし、通知を送ります。
4. ユーザーは**クレイム**を行うことでポイントを受け取ります。

---

## アクションの送信

```swift
RakutenReward.shared.logAction(actionCode: "YOUR_ACTION_CODE") { result in
    switch result {
    case .success:
        break
    case .failure(let error):
        // SDKError / RPGRequestError を処理する
    }
}
```

`actionCode` の値は楽天リワード SDK 開発者ポータルで設定します。

---

## ミッション達成の通知

ミッションが達成されると、SDKが `didUpdateUnclaimedAchievement` を発火し、ミッションの通知タイプに応じてUIが表示されます。

### 通知タイプ

| タイプ | 動作 |
|---|---|
| `MODAL` | SDKがフルスクリーンのモーダルを表示 |
| `BANNER` | SDKがトップバナーを表示 |
| `BANNER_50` | SDKが小さい広告バナーを表示 |
| `BANNER_250` | SDKが大きい広告バナーを表示 |
| `CUSTOM` | SDKはUIを表示しない — 開発者が独自のUIを作成 |
| `NONE` | UIを表示しない |

通知タイプはポータルの各ミッションごとに設定します。

---

## カスタム通知UI

ミッションが `CUSTOM` 通知タイプを使用している場合、コールバックを実装して独自のUIを表示します：

```swift
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in
    guard unclaimedItem.notificationType == .CUSTOM,
          RewardConfiguration.isUserSettingUIEnabled,
          !RewardConfiguration.isPortalPresent else {
        return
    }

    // メインスレッドでカスタム通知を表示する
    DispatchQueue.main.async {
        // UIを表示する
    }
}
```

> SDKはポータルが表示されている間は通知を表示しません。`RewardConfiguration.isPortalPresent` を必ず確認してください。

---

## ポイントのクレイム

通知を表示した後、ユーザーにポイントのクレイムを促します：

```swift
RakutenReward.shared.claim(unclaimedItem: unclaimedItem) { event in
    switch event {
    case .willPresent:
        break
    case .didClaimSuccessfully(let item):
        print("\(item.point) ポイントをクレイムしました")
    case .didFailToClaim(let error):
        print("クレイム失敗: \(error)")
    case .didDismiss, .didSelfDismiss, .didDismissByUser:
        break
    case .didFailToShow(let error):
        print("クレイム画面を表示できません: \(error)")
    case .didTriggerIchibaDeeplink(let url):
        // 楽天市場のディープリンクを開く
        UIApplication.shared.open(url)
    }
}
```

楽天市場ディープリンクのコールバックを有効にする場合：

```swift
RakutenReward.shared.claim(
    unclaimedItem: unclaimedItem,
    enableIchibaCallback: true
) { event in
    // 上記と同じ switch 処理
}
```

---

## ミッションリストの取得

### 進捗付きフルリスト

アクション回数や上限達成状況を含むミッションリストを取得します：

```swift
RakutenReward.shared.getMissionListWithProgress { result in
    switch result {
    case .success(let missions):
        // [Mission]
    case .failure(let error):
        break
    }
}
```

### ライトリスト（軽量版）

進捗や `reachedCap` を含まないミッションリストを取得します（カタログ表示に便利）：

```swift
RakutenReward.shared.getMissionLiteList { result in
    switch result {
    case .success(let missions):
        // [MissionLite]
    case .failure(let error):
        break
    }
}
```

### ミッション詳細

```swift
RakutenReward.shared.getMissionDetails(actionCode: "ACTION_CODE") { result in
    switch result {
    case .success(let mission):
        // Mission
    case .failure(let error):
        break
    }
}
```

### キャッシュリスト（同期）

最後に取得したミッションリストはネットワーク通信なしで利用できます：

```swift
let missions = RakutenReward.shared.missionList
```

---

## 未獲得ミッション

達成済みだがまだクレイムしていないミッションを取得します：

```swift
RakutenReward.shared.getUnclaimedMission { result in
    switch result {
    case .success(let items):
        // [UnclaimedItem] — 各アイテムを RakutenReward.shared.claim(...) でクレイムする
    case .failure(let error):
        break
    }
}
```

---

## ポイント履歴

過去3ヶ月分のユーザーのリワードポイント履歴を取得します：

```swift
RakutenReward.shared.getPointHistory { result in
    switch result {
    case .success(let history):
        // PointHistory — history.getPointHistory() で [PointRecord] を取得
    case .failure(let error):
        break
    }
}
```

各 `PointRecord` には以下が含まれます：
- `point` — 獲得ポイント
- `month` — 月（文字列形式）

---

> [![en](../images/en.png)](../missions.md) English version
