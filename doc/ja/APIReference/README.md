[TOP](../../README.md#top)　> API ガイド

コンテンツ
* [Rakuten Reward](#rakutenreward)<br>
* [Rakuten Reward Configuration](#rakutenrewardconfiguration)<br>
* [楽天リワードのページを開く](#楽天リワードのページを開く)<br>
* [SDKUser](#sdkuser)<br>
* [RakutenRewardStatus](#rakutenrewardstatus)<br>
* [API データ](#API-データ)<br>
  * [Mission](#mission)<br>
  * [PointHistory](#pointhistory)<br>
  * [PointRecord](#pointrecord)<br>
  * [UnclaimedItem](#unclaimeditem)<br>
* [API エラー](#API-エラー)<br>
* [ミッションの一覧を取得](#ミッションの一覧を取得)<br>
* [Rakuten Reward Ad Configuration](#rakutenrewardadconfiguration)<br>
* [クッキーをセットする](#クッキーをセットする)<br>
* [ミッション達成後のカスタムUIの作り方](#ミッション達成後のカスタムUIの作り方)<br><br>

# API ガイド

## RakutenReward
---
RakutenReward クラスはリワードSDKの主要な設定を提供しております

| API 名 | 説明 | 例
| --- | --- | ---
| バージョンを取得する | Get Rakuten Reward SDK Version | `RakutenReward.shared.getVersion()`
| SDKポータルを開く | SDKポータルを開く | `RakutenReward.shared.openPortal(completionHandler: {r in})`
| ヘルプページを開く | ヘルプページをSDKのミニブラウザーで開く | `RakutenReward.shared.openSupportPage(.Help)`
| 利用規約を開く | 利用規約をSDKのミニブラウザーで開く | `RakutenReward.shared.openSupportPage(.TermsCondition)`
| プライバシーポリシーを開く | プライバシーポリシーをDKのミニブラウザーで開く | `RakutenReward.shared.openSupportPage(.PrivacyPoilicy)`
| ミッションリストを取得する | ミッションリストを取得する | `RakutenReward.shared.getMissionListWithProgress(completion: { r in })`
| ポイント履歴を取得する | 3ヶ月前までのポイント履歴を取得する | `RakutenReward.shared.getPointHistory(completion: { r in })`
| アクションを送信する | ミッションを達成するためにアクションを送信する | `RakutenReward.shared.logAction(actionCode: "xxxxxx", completionHandler: { r in})`
| 未獲得ミッションを取得する | 未獲得ミッションリストを取得する | `RakutenReward.shared.getUnclaimedMission({ completion: { r in })`
| 最後にエラーの発生したダイナミックAPIの情報 | 最後にエラーの発生したダイナミックAPIの情報を取得する | `RakutenReward.shared.retryLastFailedFunctionByNewToken`
| 楽天ランクとポイントを取得する | 楽天ランクとポイントを取得する | `RakutenReward.shared.loadMemberInfoRank({_ in })` |
| ログイン | ログインページを開く | `RakutenReward.shared.openLoginPage({_ in })` |
| ログイン状態を取得する | ログインしているかどうか状態を取得する | `RakutenReward.shared.isLogin()` |
| ログアウト | ログアウトする | `RakutenReward.shared.logout { }` |
| 開くURLを制限 | 表示を抑制するURLを追加する(Apple審査で特定の広告等でのリジェクトを抑制するため) | `RakutenReward.shared.blacklistURLs` |
| カスタムURLセッション |  カスタムURLセッション | `RakutenReward.shared.customURLSession` |
| IDFA | IDFAをセットする | `RakutenReward.shared.advertisingID` |
| ミッションユーザー情報の更新のデリゲートメソッド | ユーザー情報が更新された時のコールバック | `RakutenReward.shared.didUpdateUser = { user in }` |
| SDKの状態の更新のデリケートメソッド | SDKの状態が更新された場合のコールバック | `RakutenReward.shared.didUpdateStatus = { status in }` |
<br>

## RakutenRewardConfiguration
---
RakutenRewardConfiguration ユーザー設定のクラスです

| API 名 | 説明 | 例 
| --- | --- | ---
| オプトアウトの取得 | オプトアウトの状態を取得する <br>true : オプトアウト (リワードSDKは動作しません) | RewardConfiguration.isUserOptingOut
| オプトアウトの設定 | オプトアウトの状態を設定する | RewardConfiguration.isUserOptingOut = false
| UI設定の取得 |  ミッションのUIのオン・オフ設定設定を取得する | RewardConfiguration.isUserSettingUIEnabled
| UI設定 | ミッションのUIのオン・オフ設定 | RewardConfiguration.isUserSettingUIEnabled = true
| ログをオンにする | デバッグログのオン・オフ設定 | RewardConfiguration.isDebug = true
| Rzクッキー | Rzクッキーをセットする | RewardConfiguration.rzCookie = "example"
| Rpクッキー | Rpクッキーをセットする | RewardConfiguration.rpCookie = "example"
<br>

## 楽天リワードのページを開く
---
SDK は各種SDKのページを開くためのAPIを提供しております


```swift
extension RakutenReward {
    public enum SupportPage : CaseIterable {
 
        case Help
        case TermsCondition
        case PrivacyPolicy
 
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
| signIn | ユーザーがサインインしているかどうか？
| unclaimedMissionCount | 未獲得ミッションの数
| point | リワードサービスで取得したポイント
| currentPointRank | `MemberPointRank`; 楽天ポイントと会員ランク
| getName | 楽天会員名
<br>

## RakutenRewardStatus
---
RakutenRewardStatus is Reward SDK の状態を表します  

| パラメータ | 説明
| --- | ---
| .Online | SDKの初期化が完了 SDKのメンバー情報が正しく更新された(ポイントおよび未獲得ミッション数)
| .Offline | SDKの初期化が未完了または失敗
| .AppcodeInvalid | アプリケーションキーが間違っている
| .TokenExpired |トークンの期限切れ  `tokenType` が `RakutenAuth`, `.TokenExpired` の場合はユーザーは再ログインする必要があります
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
| notificationtype | ミッションのノーティフィケーションタイプ | NONE, BANNER, MODAL, CUSTOM
| point | ミッションのポイント | 10
| enddatestr | ミッションの終了日 <br> 日次の場合 : Today<br> 週次 : 週の終わり<br> 月次 : 月の終わり<br> カスタム : 指定された日時<br> | 20190403
| till | ミッション終了日までの残り日数 | 残り3日
| addtional | ミッションのための拡張データ |
| reachedCap | ミッション達成が上限に達したかどうか？ | true
| times | ミッション達成に必要なアクション数 | 3
| progress | 現在のアクションの状態 | 1
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
| name | ミッション名 |
| iconurl | アイコンのURL |
| instruction | ミッションの説明 |
| actionCode | アクションコード(キー) |
| notificationtype | ミッションのノーティフィケーションタイプ |
| point | ポイント |
| unclaimedTimes | 未獲得ミッション件数 |
| achieveddatestr | ミッション達成日 |
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
<br>

### SDKError  

| 名前 | 説明
| --- | ---
| NoMissionFound | ミッションの取得できなかった
| NoUnclaimedItemFound | 未獲得ミッションが取得できなかった
| SessionNotInitialized | SDKが初期化されていない
| FeatureDisabledByUser | SDK function is not active by user
| SDKStatusNotOnline | SDK status is not online
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

<br>

## ミッション達成後のカスタムUIの作り方
---
ユーザーがミッションを達成すると、コールバックを受け取れます

```swift
public var didUpdateUnclaimedAchievement: ((RakutenRewardNativeSDK.Mission) -> Void)?
```
こちらのコールバックをOverrideしてイベントを受け取りカスタムUIを表示します

```swift
RakutenReward.shared.didUpdateUnclaimedAchievement = { m in
	guard m.notificationtype == .CUSTOM else { return }
	// 達成通知を表示する
	}
```

ポイントを獲得するには、MissionAchievementDataクラスの claim API を使います。
ユーザーに対して達成のノーティフィケーションを見せた後、クレームの処理を上記のAPIを呼び出して行います。

```swift
RakutenReward.shared.claim(unclaimedItem: m, completion: nil)
```
<br>

---
言語 :
> [![en](../../lang/en.png)](../../APIReference/README.md)
