[TOP](../../README.md#top)　> API ガイド

コンテンツ
* [Rakuten Reward](#rakutenreward)<br>
* [Rakuten Reward Configuration](#rakutenrewardconfiguration)<br>
* [ミッショントークンプロバイダー](#ミッショントークンプロバイダー)<br>
* [楽天リワードのページを開く](#楽天リワードのページを開く)<br>
* [SDKUser](#sdkuser)<br>
* [RakutenRewardStatus](#rakutenrewardstatus)<br>
* [RakutenRewardConsentStatus](#rakutenrewardconsentstatus)<br>
* [TokenType](#tokentype)<br>
* [RakutenRewardRegion](#rakutenrewardregion)<br>
* [SDKEnvironment](#sdkenvironment)<br>
* [LoginPageCompletion](#loginpagecompletion)<br>
* [PointClaimScreenEvent](#pointclaimscreenevent)<br>
* [API データ](#API-データ)<br>
  * [Mission](#mission)<br>
  * [MissionLite](#missionlite)<br>
  * [PointHistory](#pointhistory)<br>
  * [PointRecord](#pointrecord)<br>
  * [UnclaimedItem](#unclaimeditem)<br>
  * [MemberPointRank](#memberpointrank)<br>
  * [RewardRedeemRequest](#rewardredeemrequest)<br>
  * [LinkShareItemPointHistory](#linkshareitempointhist ory)<br>
  * [LinkShareProcessingPoint](#linkshareprocessingpoint)<br>
* [API エラー](#API-エラー)<br>
* [ミッションの一覧を取得](#ミッションの一覧を取得)<br>
* [クッキーをセットする](#クッキーをセットする)<br>
* [イベントアナリティクス](#イベントアナリティクス)<br>
* [ミッション達成後のカスタムUIの作り方](#ミッション達成後のカスタムUIの作り方)<br><br>

# API ガイド

## RakutenReward
---
RakutenReward クラスはリワードSDKの主要な設定を提供しております

| API 名 | 説明 | 例
| --- | --- | ---
| バージョンを取得する | Rakuten Reward SDKのバージョンを取得 | `RakutenReward.shared.getVersion()`
| サードパーティ向けSDK初期化 | サードパーティログイン用にアプリコードでSDKを初期化する | `RakutenReward.shared.initSdkThirdParty(appCode: "your_app_code")`
| SDK初期化 | アプリコード、トークンタイプ、トークンプロバイダーでSDKを初期化する | `RakutenReward.shared.initSdk(appCode: "your_app_code", tokenType: .rid, tokenProvider: yourTokenProvider)`
| セッション開始（新規） | トークンプロバイダーでセッションを開始する | `RakutenReward.shared.startSession(appCode: "your_app_code", tokenType: .rid, tokenProvider: yourTokenProvider, completion: { r in })`
| セッション開始（非推奨） | アクセストークンでセッション開始（非推奨、トークンプロバイダーを使用してください） | `RakutenReward.shared.startSession(appCode: "your_app_code", accessToken: "token", tokenType: .rid, completion: { r in })`
| SDKポータルを開く | SDKポータルを開く | `RakutenReward.shared.openPortal(completionHandler: { r in })`
| SPSポータルを開く | Rzクッキーを使用してSPSポータルを開く | `RakutenReward.shared.openSpsPortal(rzCookie: "cookie", completionHandler: { r in })`
| ヘルプページを開く | ヘルプページをSDKのミニブラウザーで開く | `RakutenReward.shared.openSupportPage(.help)`
| 利用規約を開く | 利用規約をSDKのミニブラウザーで開く | `RakutenReward.shared.openSupportPage(.termsCondition)`
| プライバシーポリシーを開く | プライバシーポリシーをSDKのミニブラウザーで開く | `RakutenReward.shared.openSupportPage(.privacyPolicy)`
| SPS利用規約を開く | SPS利用規約をSDKのミニブラウザーで開く | `RakutenReward.shared.openSupportPage(.spsTermsCondition)`
| SPSプライバシーポリシーを開く | SPSプライバシーポリシーをSDKのミニブラウザーで開く | `RakutenReward.shared.openSupportPage(.spsPrivacyPolicy)`
| ミッションリストを取得する | ミッションリストを取得する | `RakutenReward.shared.getMissionListWithProgress(completion: { r in })`
| ミッションライトを取得 | ミッションライトを取得（progress とreachedCapなし）| `RakutenReward.shared.getMissionLiteList(completion: { r in })`
| ミッション詳細を取得 | アクションコードで特定のミッションの詳細を取得 | `RakutenReward.shared.getMissionDetails(actionCode: "actionCode", completion: { r in })`
| ポイント履歴を取得する | 3ヶ月前までのポイント履歴を取得する | `RakutenReward.shared.getPointHistory(completion: { r in })`
| アクションを送信する | ミッションを達成するためにアクションを送信する | `RakutenReward.shared.logAction(actionCode: "xxxxxx", completionHandler: { r in })`
| 未獲得ミッションを取得する | 未獲得ミッションリストを取得する | `RakutenReward.shared.getUnclaimedMission(completion: { r in })`
| ミッションをクレームする | 未獲得ミッションのポイントをクレームする | `RakutenReward.shared.claim(unclaimedItem: item, completion: { event in })`
| Ichibaコールバック付きクレーム | Ichibaディープリンクサポート付きでミッションポイントをクレームする | `RakutenReward.shared.claim(unclaimedItem: item, enableIchibaCallback: true, completion: { event in })`
| 楽天ランクとポイントを取得する | 楽天ランクとポイントを取得する | `RakutenReward.shared.loadMemberInfoRank({ r in })` |
| Link Shareポイント履歴を取得 | Link Shareアイテムのポイント履歴を取得 | `RakutenReward.shared.getLSPointHistory(requestData: request, offset: 0, limit: 20, completion: { r in })`
| Link Share処理中ポイントを取得 | Link Share処理中ポイントを取得 | `RakutenReward.shared.getLSProcessingPoint(requestData: request, completion: { r in })`
| ログイン | ログインページを開く | `RakutenReward.shared.openLoginPage({ completion in })`
| ログイン状態を取得する | ログインしているかどうか状態を取得する | `RakutenReward.shared.isLogin()`
| ログアウト | ログアウトする | `RakutenReward.shared.logout { }`
| アプリコード | 現在のアプリケーションコードを取得（読み取り専用） | `RakutenReward.shared.appCode`
| アクセストークン | 現在のアクセストークンを取得（読み取り専用） | `RakutenReward.shared.accessToken`
| ミッションリスト | 現在キャッシュされているミッションリストを取得（読み取り専用） | `RakutenReward.shared.missionList`
| 環境 | SDK環境を取得または設定（.stagingまたは.production） | `RakutenReward.shared.environment`
| トークンタイプ | トークンタイプを取得または設定（.rae、.rid、.rakutenAuth） | `RakutenReward.shared.tokenType`
| 地域 | SDKリージョンを取得または設定（.japan） | `RakutenReward.shared.region`
| ブロックリストURL | 特定URLへのアクセスをブロックする | `RakutenReward.shared.blacklistURLs`
| カスタムURLセッション | デフォルトのURLセッションの代わりにカスタムURLセッションを使用する | `RakutenReward.shared.customURLSession`
| ユーザー更新デリゲート | ユーザー情報が更新された時のコールバック | `RakutenReward.shared.didUpdateUser = { user in }`
| ユーザー更新通知 | ユーザーが更新された時に送信される通知 | `RakutenReward.userUpdatedNotification`
| ステータス更新デリゲート | SDKの状態が更新された場合のコールバック | `RakutenReward.shared.didUpdateStatus = { status in }`
| ミッション達成デリゲート | ユーザーがミッションを達成した時のコールバック | `RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in }`
| ポータル表示状態更新デリゲート | ポータル表示状態変更のコールバック | `RakutenReward.shared.didUpdateIsPortalPresentedStatus = { isPortalPresent in }`
| ユーザー同意リクエスト | ユーザー同意をリクエスト (Since v5.0) | `RakutenReward.shared.requestForConsent { status in }`
| 同意バナーを表示 | 同意バナーを表示する (Since v6.3.0) | `RakutenReward.shared.showConsentBanner { status in }`
| 同意UI表示時コールバック | 同意UIが表示された時のコールバック | `RakutenReward.shared.didPresentConsentUI = { }`
| 同意UI非表示時コールバック | 同意UIが閉じられた時のコールバック | `RakutenReward.shared.didDismissConsentUI = { }`
<br>

## RakutenRewardConfiguration
---
RakutenRewardConfiguration ユーザー設定のクラスです

| API 名 | 説明 | 例
| --- | --- | ---
| オプトアウトの取得 | オプトアウトの状態を取得する <br>true : オプトアウト (リワードSDKは動作しません) | `RewardConfiguration.isUserOptingOut`
| オプトアウトの設定 | オプトアウトの状態を設定する | `RewardConfiguration.isUserOptingOut = false`
| UI設定の取得 |  ミッションのUIのオン・オフ設定設定を取得する | `RewardConfiguration.isUserSettingUIEnabled`
| UI設定 | ミッションのUIのオン・オフ設定 | `RewardConfiguration.isUserSettingUIEnabled = true`
| ログをオンにする | デバッグログのオン・オフ設定 | `RewardConfiguration.isDebug = true`
| Rzクッキー | Rzクッキーをセットする | `RewardConfiguration.rzCookie = "example"`
| Rpクッキー | Rpクッキーをセットする | `RewardConfiguration.rpCookie = "example"`
| Raクッキー | Raクッキーをセットする | `RewardConfiguration.raCookie = "example"`
| SDKポータルが表示されているか? | SDKポータルが表示されているかどうかを取得する | `RewardConfiguration.isPortalPresent`
| ミッションイベント機能の有効化 | ミッションイベント機能の有効化状態を取得・設定する | `RewardConfiguration.isMissionEventFeatureEnabled = true`
| ミッション注目機能の有効化 | ミッション注目機能の有効化状態を取得・設定する | `RewardConfiguration.isMissionFeaturedEnabled = true`
| Ichibaアプリかどうか | アプリがIchibaアプリかどうかを取得・設定する | `RewardConfiguration.isIchibaApp = true`
| SDKポータルを使用するかどうか | アプリがSDKポータルを使用するかどうかを設定する | `RewardConfiguration.isUsingSDKPortal = true`
| テーマを取得 | 現在のアプリテーマを取得する | `RewardConfiguration.getTheme()`
| テーマを設定 | アプリテーマを設定する（simpleまたはpanda） | `RewardConfiguration.setTheme(.panda)`
| カスタムドメインを設定 | ステージング用のカスタムドメインを設定する | `RewardConfiguration.setCustomDomain("stg.test.com")`
| カスタムパスを設定 | ステージング用のカスタムパスを設定する | `RewardConfiguration.setCustomPath("/testPath/test/")`
| アプリ言語を設定 | アプリ内言語を手動で設定する。SDKがサポートする言語値は'ja'、'en'、'ko'、'zh-hans'、'zh-hant'。デバイス設定の言語を使用するには空文字列を設定。サポートされていない値はデフォルトで'ja'になります | `RewardConfiguration.setAppLanguage("en")`
<br>

## ミッショントークンプロバイダー
---
MissionTokenProviderはアクセストークンを管理するためのプロトコルです。RID/RAE認証のカスタムトークン管理を提供するために、このプロトコルを実装してください。

```swift
public protocol MissionTokenProvider {
    func getAccessToken() async throws -> String
}
```

### 使用例
プロトコルを実装してカスタムトークンプロバイダーを作成します：

```swift
class MyTokenProvider: MissionTokenProvider {
    func getAccessToken() async throws -> String {
        // ここにトークン取得ロジックを実装
        // 認証サービスからの取得、期限切れ時の更新などが可能
        return "your_access_token"
    }
}

// トークンプロバイダーでSDKを初期化
let tokenProvider = MyTokenProvider()
RakutenReward.shared.initSdk(
    appCode: "your_app_code",
    tokenType: .rid,
    tokenProvider: tokenProvider
)

// セッションを開始
RakutenReward.shared.startSession(
    appCode: "your_app_code",
    tokenType: .rid,
    tokenProvider: tokenProvider
) { result in
    switch result {
    case .success(let user):
        print("セッション開始成功")
    case .failure(let error):
        print("セッション開始失敗: \(error)")
    }
}
```

### メリット
- **トークン更新**: トークン更新ロジックを自動的に処理
- **エラーハンドリング**: 集中的なトークンエラー管理
- **柔軟性**: 認証フローのカスタム実装
- **移行パス**: 非推奨の`startSession(appCode:accessToken:tokenType:completion:)`メソッドを置き換え

<br>

## 楽天リワードのページを開く
---
SDK は各種SDKのページを開くためのAPIを提供しております


```swift
extension RakutenReward {
    public enum SupportPage : CaseIterable {
        case help
        case termsCondition
        case privacyPolicy
        case spsTermsCondition
        case spsPrivacyPolicy
    }
    public func openSupportPage(_ page: RakutenRewardNativeSDK.RakutenReward.SupportPage)
}
```
<br>

## SDKUser
---
SDKUser : ユーザークラス

```swift
RakutenReward.shared.user
```

| パラメータ | 説明
| --- | ---
| signIn | ユーザーがサインインしているかどうか
| unclaimedMissionCount | 未獲得ミッションの数
| point | リワードサービスで取得したポイント
| currentPointRank() | `MemberPointRank`を取得; 楽天ポイントと会員ランク、永続化され別途ロードされる
| getName() | 楽天会員名を取得
<br>

## RakutenRewardStatus
---
RakutenRewardStatus is Reward SDK の状態を表します  

| パラメータ | 説明
| --- | ---
| .online | SDKの初期化が完了 SDKのメンバー情報が正しく更新された(ポイントおよび未獲得ミッション数)
| .offline | SDKの初期化が未完了または失敗
| .appcodeInvalid | アプリケーションキーが間違っている
| .tokenExpired |トークンの期限切れ  `tokenType` が `RakutenAuth`, `.TokenExpired` の場合はユーザーは再ログインする必要があります
| .userNotConsent | User has not agree with RakutenReward terms of service and privacy policy agreement
<br>

## RakutenRewardConsentStatus
---

| RakutenRewardConsentStatus | 説明 |
| --- | --- |
| consentProvided | ユーザーは既に同意を提供しました |
| consentNotProvided | ユーザーはまだ同意を提供していません |
| consentUIAlreadyPresented | 同意UIは既に表示されています |
| consentFailed | APIリクエストでエラーが発生しました |
| consentProvidedRestartSessionFailed | ユーザーは同意を提供しましたが、SDKセッションの再起動に失敗しました |
<br>

## TokenType
---

| TokenType | 説明 |
| --- | --- |
| .rae | RAEトークンタイプ（非推奨） |
| .rid | RIDトークンタイプ |
| .rakutenAuth | Rakuten Authトークンタイプ（SDK提供のログイン） |
<br>

## RakutenRewardRegion
---

| RakutenRewardRegion | 説明 |
| --- | --- |
| .japan | 日本リージョン |
<br>

## SDKEnvironment
---

| SDKEnvironment | 説明 |
| --- | --- |
| .staging | ステージング環境（内部使用のみ） |
| .production | 本番環境 |
<br>

## LoginPageCompletion
---

| LoginPageCompletion | 説明 |
| --- | --- |
| failToShowLoginPage | ログインページの表示に失敗しました |
| dismissByUser | ユーザーがログインページを閉じました |
| logInCompleted | ユーザーがログインを完了しました |
<br>

## PointClaimScreenEvent
---

| PointClaimScreenEvent | 説明 |
| --- | --- |
| willPresent | クレーム画面が表示されます |
| didFailToShow(error: Error) | クレーム画面の表示に失敗しました |
| didDismiss | クレーム画面が閉じられました |
| didSelfDismiss | クレーム画面が自動的に閉じられました |
| didDismissByUser | ユーザーがクレーム画面を閉じました |
| didFailToClaim(error: Error) | ポイントのクレームに失敗しました |
| didClaimSuccessfully(item: UnclaimedItem) | ポイントのクレームに成功しました |
| didTriggerIchibaDeeplink(url: URL) | Ichibaディープリンクがトリガーされました |
<br>

### ステータスの確認
```swift
let status = RakutenReward.shared.status
```
<br>

## API データ
---
<br>

### Mission
| パラメータ | 説明 | 例
| --- | --- | ---
| name | ミッション名 | Mission A
| actionCode | アクションコード(キー) | ZIJCjBeQBHac8nJa
| iconurl | ミッションアイコンのURL | https://mprewardsdk.blob.core.windows.net/sdk-portal/appCode/actionCode.png
| instruction | ミッションの説明文 | 1日1回プレイする
| condition | ミッションの達成条件 | 毎日10回達成可能
| notificationtype | ミッションのノーティフィケーションタイプ | NONE, BANNER, MODAL, CUSTOM, BANNER_50, BANNER_250
| point | ミッションのポイント | 10
| enddatestr | ミッションの終了日 <br> 日次の場合 : Today<br> 週次 : 週の終わり<br> 月次 : 月の終わり<br> カスタム : 指定された日時<br> | 20190403
| till | ミッション終了日までの残り日数 | 残り3日
| additional | ミッションのための拡張データ |
| reachedCap | ミッション達成が上限に達したかどうか | true
| times | ミッション達成に必要なアクション数 | 3
| progress | 現在のアクションの状態 | 1
| unclaimed | 未獲得達成数 | 2
| achieveddatestr | ミッション達成日 | 2024-01-01
| getAchievedDate() | 達成日をDate形式で取得 |
<br>

### MissionLite
| パラメータ | 説明 | 例
| --- | --- | ---
| name | ミッション名 | Mission A
| actionCode | アクションコード(キー) | ZIJCjBeQBHac8nJa
| iconurl | ミッションアイコンのURL | https://mprewardsdk.blob.core.windows.net/sdk-portal/appCode/actionCode.png
| instruction | ミッションの説明文 | 1日1回プレイする
| condition | ミッションの達成条件 | 毎日10回達成可能
| notificationtype | ミッションのノーティフィケーションタイプ | NONE, BANNER, MODAL, CUSTOM, BANNER_50, BANNER_250
| point | ミッションのポイント | 10
| enddatestr | ミッションの終了日 <br> 日次の場合 : Today<br> 週次 : 週の終わり<br> 月次 : 月の終わり<br> カスタム : 指定された日時<br> | 20190403
| till | ミッション終了日までの残り日数 | 残り3日
| additional | ミッションのための拡張データ |
| times | ミッション達成に必要なアクション数 | 3
<br>

### PointHistory

| メソッド名 | 説明 | 例
| --- | --- | ---
| getPointHistory | ポイント履歴の取得 | RakutenReward.shared.getPointHistory { (result) in }
<br>

#### PointRecord

| パラメータ | 説明
| --- | --- 
| point | ポイント
| month | ポイント付与月 YYYYMM
<br>

### UnclaimedItem
| パラメータ | 説明
| --- | ---
| name | ミッション名
| iconurl | アイコンのURL
| instruction | ミッションの説明
| actionCode | アクションコード(キー)
| notificationtype | ミッションのノーティフィケーションタイプ
| point | クレームする合計ポイント
| pointsPerClaim | 各クレームのポイント（複数クレームの場合）
| unclaimedTimes | 未獲得達成数
| achieveddatestr | ミッション達成日
| getAchievedDate() | "yyyy/MM/dd"フォーマットで達成日を取得
<br>

### MemberPointRank
| パラメータ | 説明
| --- | ---
| memberPoints | ユーザーの楽天会員ポイント合計
| memberRank | ユーザーの楽天会員ランク
<br>

### RewardRedeemRequest
| パラメータ | 説明
| --- | ---
| tenantId | Link Share報酬のテナントID
| appName | Link Share報酬のアプリケーション名
<br>

### LinkShareItemPointHistory
| パラメータ | 説明
| --- | ---
| total | ポイント履歴レコードの総数
| offset | ページネーションのオフセット
| limit | ページネーションの制限
| history | LinkShareItemPointオブジェクトの配列
<br>

#### LinkShareItemPoint
| パラメータ | 説明
| --- | ---
| point | ポイント値
| isPointGranted | ポイントが付与されているかどうか
| advertiser | 広告主名
| grantDate | ポイントが付与される/された日付（yyyy-MM-dd）
| transactionDate | 取引日（yyyy-MM-dd）
| orderId | 注文ID
| advertiserId | 広告主ID
<br>

### LinkShareProcessingPoint
| パラメータ | 説明
| --- | ---
| count | 処理中ポイントの合計
<br>

## API エラー
---
<br>

### RewardSDKSessionError

| 名前 | 説明
| --- | --- 
| userNotFound |  startSessionに失敗した
| appcodeInvalid | SDKの状態がAPPCODEINVALID
| bundleError |  パラメータが間違っている
| loginRequired | (SDK提供のログインの場合のみ) SDK APIを使用するにはログインが必要です 
| invalidTokenType | (SDK提供のログインの場合のみ) トークンのタイプが間違っている
| cannotRetrieveSessionToken | (SDK提供のログインの場合のみ) トークンの取得に失敗しました、再度ログインしてください
| cannotLogOutOnServer | (SDK提供のログインの場合のみ) ログアウトに失敗した
<br>

### RPGRequestError  

| 名前 | 説明
| --- | ---
| tokenExpire | トークンの期限切れ
| serverError | 接続に失敗した
| badRequest | Bad request
| unavailableForLegalReasons | Error because of legal reason (for example, user has not consent to RewardSDK's terms and condition)
<br>

### SDKError

| 名前 | 説明
| --- | ---
| noMissionFound | ミッションを取得できませんでした
| missionReachedCap | ミッション達成が既に上限に達しました
| noUnclaimedItemFound | 未獲得ミッションを取得できませんでした
| sessionNotInitialized | SDKが初期化されていません
| featureDisabledByUser | ユーザーによってSDK機能が無効化されています
| sdkStatusNotOnline | SDKステータスがオンラインではありません
| sdkStatusUserNotConsent | ユーザーがRewardSDKの利用規約とプライバシーポリシーに同意していません
| checkIsSpsUserError | SPSユーザーかどうかの確認エラー
| unexpectedError(message: String) | 予期しないエラーが発生しました
| spsFeatureIsDisabled | SPS機能が無効化されています
| spsRegisterUserDidNotFinish | SPSユーザー登録が完了していません
| spsRegisterUserError | SPSユーザー登録中にエラーが発生しました
| onMaintenanceMode | SDKはメンテナンスモードです
<br>

## ミッションの一覧を取得
---
```swift
RakutenReward.shared.getMissionListWithProgress(completion: {r in
                    switch r {
                    case .success(let mList): // mission List to display
		            case .failure(let err): // handling the error
		    }
}
```
<br>

## RakutenRewardAdConfiguration
---
こちらの機能は台湾でのみご利用になれます
```swift
RakutenRewardAdConfiguration.shared
```
| パラメータ名 | 説明 | 例 
| --- | --- | ---
| bcat | 広告のコンテンツをIABのコンテンツに基づきブロックする  | RakutenRewardAdConfiguration.shared.bcat
| badv | 広告のドメインレベルでのブロック | RakutenRewardAdConfiguration.shared.badv
| appDomain |  アプリのドメイン(アプリの紹介ページのトップなど) | RakutenRewardAdConfiguration.shared.appDomain
| storeUrl | アプリストアのURL | RakutenRewardAdConfiguration.shared.storeUrl
| privacyPolicy | プライバシーポリシーの有無　 0　= 用意していない、 1 = 用意している | RakutenRewardAdConfiguration.shared.privacyPolicy
| paid | アプリが無料か有料かどうか 0 = 無料、 1 = 有料 | RakutenRewardAdConfiguration.shared.paid
| keywords | アプリのキーワード | RakutenRewardAdConfiguration.shared.keywords
| test | テストモードの切り替え(デバッグ用) | RakutenRewardAdConfiguration.shared.test
<br>

| メソッド | 説明 | 例 
| --- | --- | ---
| addBlockCategory | 広告のコンテンツブロックの対象を追加する<br>フォーマット: IAB(Number)-(Number) | addBlockCategory(str: "IAB7-17")
| addBlockDomain | 広告のドメインレベルでのブロックの対象を追加する | addBlockCategory(str: "www.example.com")
| addKeywords | 広告キーワードを追加する | addKeywords(str: "製品")
<br>

## クッキーをセットする
---
この機能はSDK v2.2.0　からサポートしています。
この機能は楽天のアプリケーションですでに広告のためのクッキーを取得している場合に推奨される機能となります。
もし、デフォルトのログインオプション(TokenType.RakutenAuth)をご使用の場合にはこちらの処理はSDKで行いますので、実装する必要はありません。 もし他のオプションをご利用の場合、このAPIをご利用されるとクッキーを上書きいたします。

Rpクッキーをセットする
```swift
RewardConfiguration.rpCookie = "example"
```

Rzクッキーをセットする
```swift
RewardConfiguration.rzCookie = "example"
```

Raクッキーをセットする (version 5.1.0)
```swift
RewardConfiguration.rzCookie = "example"
```

<br>

## イベントアナリティクス
---
この機能はSDK v3.3.0　からサポートしています。<br>
```swift
RakutenMissionEvent.shared.logAction(eventCode: "exampleEventCode", eventTrackingType: .ratSpecificEvent, parameters: nil) { error in
    if let error = error {
        // Error
        return
    }
    // Success
}
```

### パラメーター
| ステータス | 説明 |
| --- | --- |
| eventCode | Analytics SDK のイベントコード |
| eventTrackingType | RakutenMissionEvent トラッキングタイプ / Analytics SDK トラッキングタイプ |
| parameters (optional) | Analytics SDK パラメーター |

### Enum RakutenMissionEventTrackingType
| トラッキングタイプ | 説明 |
| --- | --- |
| genericEvent | 通常イベントのトラッキング |
| ratSpecificEvent | カスタムイベントのトラッキング |


<br>

## ミッション達成後のカスタムUIの作り方
---
ユーザーがミッションを達成すると、コールバックを受け取れます

```swift
// From RakutenReward class
public var didUpdateUnclaimedAchievement: ((UnclaimedItem) -> Void)?
  
// Example
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in }
```
こちらのコールバックをOverrideしてイベントを受け取りカスタムUIを表示します<br>
Note : SDKポータル上でミッション達成のノーティフィケーションを表示することは推奨されていません。(デフォルトのバナーとモーダルはSDKで対応済み) カスタムでUIを作るときは、RewardConfiguration.isPortalPresent APIで状態を確認し、ポータルが表示(true)の場合は表示しないようにお願いいたします。
この機能はSDK 2.3.0から使用可能です。

```swift
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in
    guard unclaimedItem.notificationType == .CUSTOM, // Check notification type
          RewardConfiguration.isUserSettingUIEnabled, // Check if user enable the UI setting or not
          !RewardConfiguration.isPortalPresent else { // Check if Portal is currently showing, not support for showing notification inside Portal.
            
        return
    }
  
    // Show Custom UI in Main thread
}
```

ポイントを獲得するには、MissionAchievementDataクラスの claim API を使います。
ユーザーに対して達成のノーティフィケーションを見せた後、クレームの処理を上記のAPIを呼び出して行います。

```swift
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in
    RakutenReward.shared.claim(unclaimedItem: unclaimedItem, completion: { pointClaimScreenEvent in }
}
```
<br>

---
言語 :
> [![en](../../lang/en.png)](../../APIReference/README.md)
