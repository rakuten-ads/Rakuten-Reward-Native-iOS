# v9 移行ガイド

SDK v9.0.0 では `MissionTokenProvider` が導入されました。これは手動セッション管理を不要にする新しいトークン管理パターンです。このガイドでは何が変わったか、どのように更新するかを説明します。

> 旧来の `startSession` API は引き続き動作します。今日から移行は必須ではありませんが、より簡潔でロバストな連携のために強く推奨します。

---

## 変更点のまとめ

| 課題 | v9 以前 | v9 以降 |
|---|---|---|
| トークンの提供 | 毎回 `startSession` にトークンを渡す | `MissionTokenProvider` を一度実装するだけ |
| トークン期限切れ | `.tokenExpired` ステータスを手動で処理する | SDK が自動でトークンをリフレッシュ |
| セッション開始 | トークン提供後に `startSession` を呼び出す必要あり | `initSdk` 後に SDK が自動でセッションを開始 |
| ONLINE ステータスの確認 | API 呼び出し前に `.online` を待つ必要あり | 不要 — API を直接呼び出せる |

---

## 移行手順

### ステップ 1 — `MissionTokenProvider` を実装する

プロトコルに準拠したクラスを作成します：

```swift
class RIDTokenProvider: MissionTokenProvider {
    static let shared = RIDTokenProvider()

    func getAccessToken() async throws -> String {
        // 現在の有効なトークンを返します。ログインしていない場合は "" を返します
        return yourAuthSystem.currentToken ?? ""
    }
}
```

実装のポイント：
- **ログイン中：** 有効な期限内のトークンを返す
- **未ログイン：** `""` を返す（throw しない）
- **トークンリフレッシュ：** 認証 SDK がサポートする場合は、このメソッド内でリフレッシュを処理する

### ステップ 2 — `startSession` を `initSdk` に置き換える

```swift
// 移行前
RakutenReward.shared.tokenType = .rid
RakutenReward.shared.startSession(
    appCode: "YOUR_APP_CODE",
    accessToken: currentToken,
    completion: { result in }
)

// 移行後
RakutenReward.shared.initSdk(
    appCode: "YOUR_APP_CODE",
    tokenType: .rid,
    tokenProvider: RIDTokenProvider.shared
)
```

### ステップ 3 — トークン期限切れの処理を削除する

SDK はトークン期限切れを検知すると自動で `getAccessToken()` を呼び出します。以下のパターンは削除できます：

```swift
// 削除してください
RakutenReward.shared.didUpdateStatus = { status in
    if status == .tokenExpired {
        // ... 手動のトークンリフレッシュ処理
    }
}
```

このコールバックで `.userNotConsent` の監視は引き続き行ってください。

### ステップ 4 — ONLINE ステータスの確認を削除する

API を呼び出す前に `.online` を待つ必要はなくなりました：

```swift
// 以下のパターンを削除してください
if RakutenReward.shared.status == .online {
    RakutenReward.shared.logAction(actionCode: "code") { _ in }
}

// こちらも削除してください
RakutenReward.shared.didUpdateStatus = { status in
    if status == .online {
        RakutenReward.shared.logAction(actionCode: "code") { _ in }
    }
}
```

```swift
// 移行後 — 直接呼び出す
RakutenReward.shared.logAction(actionCode: "code") { _ in }
```

---

## Objective-C について

`MissionTokenProvider` は Swift の `async/await` プロトコルであり、**Objective-C では使用できません**。Objective-C アプリでは引き続き `startSession` を使用してください。手動のトークン期限切れ処理も引き続き必要です。

---

## まとめ

| 削除するもの | 置き換えるもの |
|---|---|
| `startSession(appCode:accessToken:tokenType:completion:)` | `initSdk(appCode:tokenType:tokenProvider:)` |
| `.tokenExpired` の処理 | 不要 — SDK が自動処理 |
| API 呼び出し前の `status == .online` 確認 | 不要 — 直接呼び出せる |

---

> [![en](../images/en.png)](../migration-to-v9.md) English version
