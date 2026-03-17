# 認証と初期化

このガイドでは、ユーザー認証とSDKの初期化方法をすべて説明します。他のSDK APIを呼び出す前に必ず初期化を完了してください。

---

## 認証方法の選択

| 方法 | 使用タイミング | ステータス |
|---|---|---|
| **RakutenAuth** | アプリに楽天ログインがない場合。SDKが独自のログインUIを提供します。 | サポート中 |
| **RID**（楽天 ID SDK） | RID/API-Cトークンを使用する楽天 ID SDK を利用している場合。 | サポート中（推奨） |
| **RAE**（楽天 User SDK） | RAEトークンを使用する楽天 User SDK を利用している場合。 | **非推奨** — 2025年までにRIDへ移行してください |

---

## ステップ1 — リージョンの設定

他のSDKメソッドを呼び出す前に、必ずリージョンを設定してください。

```swift
RakutenReward.shared.region = .japan
```

---

## ステップ2 — SDKの初期化

### オプション A: RakutenAuth（SDK 提供のログイン）

楽天ログイン SDK を使用しない場合はこちらを使用してください。

```swift
// アプリ起動時に一度だけ呼び出す（AppDelegate または App struct 等）
RakutenReward.shared.initSdkThirdParty(appCode: "YOUR_APP_CODE")
```

初期化後、ログイン状態を確認し、必要であればログインページを表示します：

```swift
if !RakutenReward.shared.isLogin() {
    RakutenReward.shared.openLoginPage { result in
        switch result {
        case .logInCompleted:
            // ログイン成功。SDKセッションは自動で管理されます
        case .dismissByUser:
            // ユーザーがログインページを閉じました。後でもう一度試してください
        case .failToShowLoginPage:
            // ログインUIの表示に失敗しました
        }
    }
}
```

### オプション B: RID トークン（v9 推奨）

楽天 ID SDK を使用している場合はこちらを使用してください。

**1. `MissionTokenProvider` を実装します：**

```swift
class RIDTokenProvider: MissionTokenProvider {
    static let shared = RIDTokenProvider()

    func getAccessToken() async throws -> String {
        // 現在の API-C アクセストークンを返します。
        // ユーザーがログインしていない場合は "" を返します。
        return yourIDSDK.currentAccessToken ?? ""
    }
}
```

**2. SDKを初期化します：**

```swift
RakutenReward.shared.initSdk(
    appCode: "YOUR_APP_CODE",
    tokenType: .rid,
    tokenProvider: RIDTokenProvider.shared
)
```

SDKはトークンが必要な時に自動で `getAccessToken()` を呼び出します。手動で `.tokenExpired` ステータスを監視したり `startSession` を呼び出したりする必要はありません。

### オプション C: RAE トークン（非推奨）

RAE でも同じ `MissionTokenProvider` パターンが使用できます：

```swift
class RAETokenProvider: MissionTokenProvider {
    static let shared = RAETokenProvider()

    func getAccessToken() async throws -> String {
        return yourUserSDK.currentAccessToken ?? ""
    }
}

RakutenReward.shared.initSdk(
    appCode: "YOUR_APP_CODE",
    tokenType: .rae,
    tokenProvider: RAETokenProvider.shared
)
```

> **警告：** RAEは将来のリリースで削除されます。今すぐRIDへの移行を計画してください。

---

## ログアウト

ユーザーがサインアウトする際は必ずログアウトを呼び出してください。SDKのトークンとセッションデータがクリアされます。

```swift
RakutenReward.shared.logout { }
```

---

## SDK ステータス

SDKの現在の状態は `RakutenReward.shared.status` および `didUpdateStatus` コールバックで確認できます：

| ステータス | 説明 |
|---|---|
| `.online` | SDKの準備ができています。ユーザー情報が最新の状態です |
| `.offline` | 初期化が完了していないか、失敗しました |
| `.appcodeInvalid` | アプリコードが間違っています |
| `.tokenExpired` | トークンの期限切れ（RakutenAuthのみ — ユーザーに再ログインを促してください） |
| `.userNotConsent` | ユーザーがリワードの利用規約に同意していません |

`MissionTokenProvider` を使用した場合（オプション B/C）、SDKがトークンの期限切れを自動処理します。`.userNotConsent` の監視のみ必要です。

```swift
RakutenReward.shared.didUpdateStatus = { status in
    if status == .userNotConsent {
        RakutenReward.shared.requestForConsent { _ in }
    }
}
```

---

## ユーザー情報の取得

```swift
// 現在のユーザーオブジェクトにアクセス
let user = RakutenReward.shared.user

// ユーザーの表示名
user?.getName()

// リワードSDKポイントと楽天会員ランク
user?.currentPointRank()
```

ユーザー情報の更新を購読します：

```swift
RakutenReward.shared.didUpdateUser = { user in
    // 最新のポイント・ランクでUIを更新する
}
```

---

## MissionTokenProvider プロトコルリファレンス

```swift
public protocol MissionTokenProvider {
    /// 有効なアクセストークンを返します。ユーザーがログインしていない場合は "" を返します。
    func getAccessToken() async throws -> String
}
```

SDKはこのメソッドをオンデマンドで呼び出します。実装のポイント：
- ログイン中は最新の有効なトークンを返す
- ログインしていない場合は `""` を返す（throwしない）
- 認証SDKがサポートする場合は、実装内でリフレッシュを処理する

---

## ID SDK スコープ要件

楽天 ID SDK（RID）を使用する場合、クライアント ID に `mission-sdk` スコープが必要です：

1. [ID Client Support](https://confluence.rakuten-it.com/confluence/display/id/ID+Client+Support+Ticket+Creation) にチケットを申請し、CATオーディエンス `https://prod.api-catalogue.gateway-api.global.rakuten.com` と `mission-sdk` スコープの追加を依頼してください。
2. API Catalogue ダッシュボードでスコープを有効にしてください。
3. Exchange Token 取得時にスコープを追加します：

```swift
let request = try ArtifactRequestBuilder()
    .set(specifications: ExchangeTokenConfigurationBuilder()
        .set(audience: audience)
        .set(scope: ["mission-sdk"])
        .build())
    .build()
```

4. 以下のエンドポイントでアクセストークンを取得します：`https://gateway-api.global.rakuten.com/RWDSDK/rpg-api/access_token`

楽天 User SDK（RAE）を使用する場合は、[RAE スコープ登録ガイド](https://confluence.rakuten-it.com/confluence/x/z5nNkQ) に従って `mission-sdk` スコープを登録し、ログインワークフローに追加します：

```swift
RBuiltinLoginWorkflow(
    authenticationSettings: settings,
    loginDialog: loginDialog,
    accountSelectionDialog: accountSelectionDialog,
    authenticatorFactory: RBuiltinJapanIchibaUserAuthenticatorFactory(["mission-sdk"]),
    presentationConfiguration: presentationConfiguration
)
```

---

> [![en](../../../docs/doc/lang/en.png)](../authentication.md) English version
