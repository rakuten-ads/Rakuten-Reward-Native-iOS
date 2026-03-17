# API リファレンス（Swift）

Objective-C の API については [Objective-C ガイド](../objective-c.md) を参照してください。

---

## RakutenReward

すべての SDK 操作のメインエントリーポイントです。`RakutenReward.shared` 経由でアクセスします。

### 初期化

| メソッド | 説明 |
|---|---|
| `initSdk(appCode:tokenType:tokenProvider:)` | `MissionTokenProvider` で初期化（v9 推奨） |
| `initSdkThirdParty(appCode:)` | RakutenAuth（SDK 提供ログイン）向けに初期化 |
| `startSession(appCode:accessToken:tokenType:completion:)` | *（非推奨）* トークンを直接渡してセッションを開始 |

### 認証

| メソッド | 説明 |
|---|---|
| `openLoginPage(_:)` | SDK 提供のログインページを表示（RakutenAuth のみ） |
| `isLogin()` | ユーザーがログイン済みかつトークンが有効な場合 `true` を返す |
| `logout(_:)` | ログアウトしてセッションをクリアする |

### ミッション API

| メソッド | 説明 |
|---|---|
| `logAction(actionCode:completionHandler:)` | ミッションに向けたユーザーアクションを記録する |
| `getMissionListWithProgress(completion:)` | 進捗・上限状況を含むミッションを取得する |
| `getMissionLiteList(completion:)` | 進捗なしの軽量ミッションを取得する |
| `getMissionDetails(actionCode:completion:)` | 特定ミッションの詳細を取得する |
| `getUnclaimedMission(completion:)` | クレイム待ちの達成済みミッションを取得する |
| `claim(unclaimedItem:completion:)` | 未クレイムのミッション達成に対してクレイム UI を表示する |
| `claim(unclaimedItem:enableIchibaCallback:completion:)` | 楽天市場ディープリンクサポート付きでクレイムする |
| `missionList` | 最後に取得したミッションリストの同期キャッシュ |

### ポイント・ユーザーデータ

| メソッド / プロパティ | 説明 |
|---|---|
| `user` | 現在の `SDKUser` オブジェクト（オフライン時は `nil` の場合あり） |
| `loadMemberInfoRank(_:)` | サーバーから会員ポイントとランクを再取得する |
| `getPointHistory(completion:)` | 3ヶ月分のポイント履歴を取得する |
| `getLSPointHistory(requestData:offset:limit:completion:)` | Link Share アイテムのポイント履歴を取得する |
| `getLSProcessingPoint(requestData:completion:)` | Link Share の処理中ポイント合計を取得する |

### ポータル

| メソッド | 説明 |
|---|---|
| `openPortal(completionHandler:)` | SDK ポータルを開く |
| `openSpsPortal(rzCookie:completionHandler:)` | SPS ポータルを開く（v8.5.0 以降） |
| `openSupportPage(_:)` | ヘルプ・法的ページをミニブラウザで開く |

### ユーザー同意

| メソッド | 説明 |
|---|---|
| `requestForConsent(_:)` | ユーザー同意をリクエストする（未提供の場合はダイアログを表示） |
| `showConsentBanner(_:)` | 同意通知バナーを表示する |

### コールバック・通知

| プロパティ | トリガー |
|---|---|
| `didUpdateUser: ((SDKUser) -> Void)?` | ユーザーデータが更新された時 |
| `didUpdateStatus: ((RakutenRewardStatus) -> Void)?` | SDK ステータスが変化した時 |
| `didUpdateUnclaimedAchievement: ((UnclaimedItem) -> Void)?` | ミッションが達成された時 |
| `didUpdateIsPortalPresentedStatus: ((Bool) -> Void)?` | ポータルが表示・非表示になった時 |
| `didPresentConsentUI: (() -> Void)?` | 同意ダイアログが表示された時 |
| `didDismissConsentUI: (() -> Void)?` | 同意ダイアログが閉じられた時 |
| `RakutenReward.userUpdatedNotification` | ユーザー更新時に `NotificationCenter` から通知 |

### プロパティ

| プロパティ | 説明 |
|---|---|
| `status` | 現在の `RakutenRewardStatus` |
| `appCode` | アプリコード（初期化後は読み取り専用） |
| `accessToken` | 現在のアクセストークン（読み取り専用） |
| `tokenType` | トークンタイプ（`.rid`、`.rae`、`.rakutenAuth`） |
| `region` | SDKリージョン（`.japan`） |
| `environment` | `.staging` または `.production` |
| `blacklistURLs` | SDK がアクセスしない URL |
| `customURLSession` | SDK の URLSession を上書きする |

---

## RakutenRewardConfiguration

グローバルな SDK 設定です。すべてのプロパティは static です。

| プロパティ / メソッド | 説明 |
|---|---|
| `isUserOptingOut` | `true` = ユーザーがオプトアウト済み、すべての SDK 機能が無効 |
| `isUserSettingUIEnabled` | `true` = 通知 UI が有効 |
| `isDebug` | `true` = 詳細なデバッグログを出力 |
| `rzCookie` | Rz クッキーの値 |
| `rpCookie` | Rp クッキーの値 |
| `raCookie` | Ra クッキーの値（v5.1.0 以降） |
| `isPortalPresent` | ポータルが現在表示中かどうか（読み取り専用） |
| `isMissionEventFeatureEnabled` | イベントアナリティクス機能の有効・無効 |
| `isMissionFeaturedEnabled` | ミッション注目機能の有効・無効 |
| `isIchibaApp` | 楽天市場アプリの場合 `true` に設定 |
| `isUsingSDKPortal` | SDK ポータルを使用する場合 `true` に設定 |
| `getTheme()` | 現在の `AppTheme` を取得 |
| `setTheme(_:)` | テーマを設定（`.panda` または `.simple`） |
| `setCustomDomain(_:)` | API ドメインを上書き（ステージングのみ） |
| `setCustomPath(_:)` | API パスを上書き（ステージングのみ） |
| `setAppLanguage(_:)` | UI 言語を強制設定（`"ja"`、`"en"`、`"ko"`、`"zh-hans"`、`"zh-hant"`、またはデバイス設定に従う場合は `""`） |

---

## MissionTokenProvider プロトコル

```swift
public protocol MissionTokenProvider {
    func getAccessToken() async throws -> String
}
```

RID または RAE 認証のトークン提供のためにこのプロトコルを実装してください。実装のガイドは [認証と初期化](authentication.md) を参照してください。

---

## SDKUser

`RakutenReward.shared.user` 経由でアクセスします。

| プロパティ / メソッド | 説明 |
|---|---|
| `signIn` | ユーザーがサインイン中かどうか |
| `point` | リワード SDK のポイント残高 |
| `unclaimedMissionCount` | 未クレイムの達成数 |
| `getName()` | ユーザーの表示名 |
| `currentPointRank()` | 会員ポイントとランクを含む `MemberPointRank` を返す |

---

## 列挙型

### RakutenRewardStatus

| ケース | 説明 |
|---|---|
| `.online` | SDK 準備完了・ユーザーデータが最新 |
| `.offline` | SDK が未初期化または初期化失敗 |
| `.appcodeInvalid` | アプリコードが間違っている |
| `.tokenExpired` | トークン期限切れ（RakutenAuth: 再ログインが必要） |
| `.userNotConsent` | ユーザーが利用規約に同意していない |

### RakutenRewardConsentStatus

| ケース | 説明 |
|---|---|
| `.consentProvided` | 同意が提供された |
| `.consentNotProvided` | 同意がまだ提供されていない |
| `.consentUIAlreadyPresented` | 同意 UI が現在表示中 |
| `.consentFailed` | 同意確認中に API エラーが発生 |
| `.consentProvidedRestartSessionFailed` | 同意されたがセッション再起動に失敗 |

### TokenType

| ケース | 説明 |
|---|---|
| `.rid` | 楽天 ID SDK トークン |
| `.rae` | 楽天 User SDK トークン *（非推奨）* |
| `.rakutenAuth` | SDK 提供ログイントークン |

### RakutenRewardRegion

| ケース | 説明 |
|---|---|
| `.japan` | 日本 |

### SDKEnvironment

| ケース | 説明 |
|---|---|
| `.production` | 本番環境（デフォルト） |
| `.staging` | ステージング環境（内部使用のみ） |

### LoginPageCompletion

| ケース | 説明 |
|---|---|
| `.logInCompleted` | ユーザーが正常にログインした |
| `.dismissByUser` | ユーザーがログインページを閉じた |
| `.failToShowLoginPage` | ログイン UI を表示できなかった |

### SupportPage

| ケース | 説明 |
|---|---|
| `.help` | Reward SDK ヘルプページ |
| `.termsCondition` | リワード利用規約 |
| `.privacyPolicy` | リワードプライバシーポリシー |
| `.spsTermsCondition` | SPS 利用規約 |
| `.spsPrivacyPolicy` | SPS プライバシーポリシー |

### PointClaimScreenEvent

| ケース | 説明 |
|---|---|
| `.willPresent` | クレイム画面が表示されようとしている |
| `.didFailToShow(error:)` | クレイム画面を表示できなかった |
| `.didDismiss` | クレイム画面が閉じられた（原因問わず） |
| `.didSelfDismiss` | クレイム画面が自動で閉じられた |
| `.didDismissByUser` | ユーザーが手動でクレイム画面を閉じた |
| `.didFailToClaim(error:)` | ポイントクレイムリクエストが失敗した |
| `.didClaimSuccessfully(item:)` | ポイントが正常にクレイムされた |
| `.didTriggerIchibaDeeplink(url:)` | 楽天市場のディープリンクがトリガーされた |

---

## データモデル

### Mission

| プロパティ | 型 | 説明 |
|---|---|---|
| `name` | `String` | ミッション名 |
| `actionCode` | `String` | アクションコード |
| `iconurl` | `String` | ミッションアイコンのURL |
| `instruction` | `String` | ユーザー向けの説明文 |
| `condition` | `String` | 達成上限の説明 |
| `notificationtype` | `NotificationType` | `NONE`、`BANNER`、`MODAL`、`CUSTOM`、`BANNER_50`、`BANNER_250` |
| `point` | `Int` | 付与ポイント |
| `enddatestr` | `String` | 終了日の文字列 |
| `till` | `String` | 残り日数 |
| `additional` | `String?` | 追加メッセージ |
| `reachedCap` | `Bool` | 達成上限に達したかどうか |
| `times` | `Int` | 必要アクション回数 |
| `progress` | `Int` | 現在のアクション回数 |
| `unclaimed` | `Int` | 未クレイムの達成数 |
| `achieveddatestr` | `String?` | 達成日の文字列 |
| `getAchievedDate()` | `Date?` | 達成日を `Date` 型で取得 |

### MissionLite

`progress` と `reachedCap` を含まない軽量版の `Mission` です。他のプロパティはすべて同じです。

### UnclaimedItem

| プロパティ | 型 | 説明 |
|---|---|---|
| `name` | `String` | ミッション名 |
| `iconurl` | `String` | ミッションアイコンのURL |
| `instruction` | `String` | ミッションの説明 |
| `actionCode` | `String` | ミッションアクションコード |
| `notificationtype` | `NotificationType` | 通知タイプ |
| `point` | `Int` | クレイムする合計ポイント |
| `pointsPerClaim` | `Int` | 1回のクレイムあたりのポイント |
| `unclaimedTimes` | `Int` | 未クレイムの達成数 |
| `achieveddatestr` | `String` | 達成日の文字列 |
| `getAchievedDate()` | `Date?` | 達成日を `Date` 型で取得（フォーマット：`yyyy/MM/dd`） |

### MemberPointRank

| プロパティ | 型 | 説明 |
|---|---|---|
| `memberPoints` | `Int` | ユーザーの楽天会員ポイント合計 |
| `memberRank` | `String` | ユーザーの楽天会員ランク |

### PointHistory / PointRecord

`PointHistory` は `PointRecord` のリストをラップします：

| `PointRecord` プロパティ | 説明 |
|---|---|
| `point` | 獲得ポイント |
| `month` | 月の文字列（YYYYMM） |

### RewardRedeemRequest

Link Share API で使用します：

| プロパティ | 型 | 説明 |
|---|---|---|
| `tenantId` | `String` | テナントID |
| `appName` | `String` | アプリケーション名 |

### LinkShareItemPointHistory

| プロパティ | 説明 |
|---|---|
| `total` | 総レコード数 |
| `offset` | ページネーションのオフセット |
| `limit` | ページネーションの上限 |
| `history` | `[LinkShareItemPoint]` |

### LinkShareItemPoint

| プロパティ | 説明 |
|---|---|
| `point` | ポイント値 |
| `isPointGranted` | ポイントが付与されているかどうか |
| `advertiser` | 広告主名 |
| `grantDate` | ポイントが付与される/された日付（`yyyy-MM-dd`） |
| `transactionDate` | 取引日（`yyyy-MM-dd`） |
| `orderId` | 注文ID |
| `advertiserId` | 広告主ID |

### LinkShareProcessingPoint

| プロパティ | 説明 |
|---|---|
| `count` | 処理中ポイントの合計 |

---

## エラー

### RewardSDKSessionError

セッション関連の API で返されます。

| ケース | 説明 |
|---|---|
| `userNotFound` | セッション開始失敗 — ユーザーが見つかりません |
| `appcodeInvalid` | SDK ステータスが `appcodeInvalid` |
| `bundleError` | パラメーターが間違っています |
| `loginRequired` | 先にログインが必要です（RakutenAuth のみ） |
| `invalidTokenType` | トークンタイプが無効です（RakutenAuth のみ） |
| `cannotRetrieveSessionToken` | セッショントークンを取得できません — セッションを再起動してください |
| `cannotLogOutOnServer` | サーバーでのログアウトが失敗しました（RakutenAuth のみ） |

### RPGRequestError

ネットワーク・API 呼び出しで返されます。

| ケース | 説明 |
|---|---|
| `tokenExpire` | アクセストークンの期限切れ |
| `serverError` | サーバーに接続できません |
| `badRequest` | リクエストが不正です |
| `unavailableForLegalReasons` | ユーザーが同意していません（法的ブロック） |

### SDKError

ほとんどの SDK 機能 API で返されます。

| ケース | 説明 |
|---|---|
| `noMissionFound` | ミッションリストが空です |
| `missionReachedCap` | ミッションが上限に達しました |
| `noUnclaimedItemFound` | 未クレイムのミッションがありません |
| `sessionNotInitialized` | SDK が初期化されていません |
| `featureDisabledByUser` | ユーザーがオプトアウトしています |
| `sdkStatusNotOnline` | SDK ステータスが `.online` ではありません |
| `sdkStatusUserNotConsent` | ユーザーが同意していません |
| `checkIsSpsUserError` | SPS 会員確認中にエラーが発生しました |
| `unexpectedError(message:)` | 予期しないエラー |
| `spsFeatureIsDisabled` | SPS がこのアプリで有効になっていません |
| `spsRegisterUserDidNotFinish` | SPS 登録が完了していません |
| `spsRegisterUserError` | SPS 登録中にエラーが発生しました |
| `onMaintenanceMode` | SDK がメンテナンスモードです |

---

> [![en](../images/en.png)](../api-reference.md) English version
