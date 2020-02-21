[TOP](../README.md#top)　> 応用ガイド

---
# 応用ガイド
## RakutenReward
RakutenReward クラスはリワードSDKのメインの設定や機能を提供しています　  

| API Name | Description | Example
| --- | --- | ---
| バージョンの取得 |  リワードSDKのバージョンを取得する | RakutenReward.shared.getVersion()
| SDK ポータルを開く | SDK ポータルを開く | RakutenReward.shared.openPortal(completionHandler : nil)
| ヘルプページを開く | ヘルプページをSDKのミニブラウザーで開く | RakutenReward.shared.openSupportPage(.Help)
| 利用規約を開く | 利用規約をSDKのミニブラウザーで開く | RakutenReward.shared.openSupportPage(.TermsCondition)
| プライバシーポリシーを開く |プライバシーポリシーをSDKのミニブラウザーで開く | RakutenReward.shared.openSupportPage(.PrivacyPolicy)
| ミッションリストを取得する | ミッションリストを取得する | RakutenReward.shared.getMissionListWithProgress(completion: {result in <br>}))
| ポイント履歴を取得する | 3ヶ月前までのポイント履歴を取得する | RakutenReward.shared.getPointHistory(completion: { result in <br>}))
| アクションを送信する | ミッションを達成するためにアクションを送信する | RakutenReward.shared.logAction("xxxxx", completionHandler: { _ in <br>})
| 未獲得ミッションを取得する | 未獲得ミッションリストを取得する | RakutenReward.shared.getUnclaimedMission(completion: { result in <br>})
| 最後にエラーの発生したダイナミックAPIの情報 | 最後にエラーの発生したダイナミックAPIの情報を取得する | RakutenReward.retryLastFailedFunctionByNewToken

## RakutenRewardConfiguration
RakutenRewardConfiguration はユーザー設定を管理するクラスです

| API Name | Description | Example 
| --- | --- | ---
| オプトアウトの取得 | オプトアウトの状態を取得する <br>true : オプトアウト (リワードSDKは動作しません) | RewardConfiguration.isUserOptingOut
| オプトアウトの設定 | オプトアウトの状態を設定する | RewardConfiguration.isUserOptingOut = false
| UI設定の取得 | ミッションのUIのオン・オフ設定設定を取得する | RewardConfiguration.isUserSettingUIEnabled
| UI設定 | ミッションのUIのオン・オフ設定 | RewardConfiguration.isUserSettingUIEnabled = true

## リワードに関連するウェブページを開く
SDKではSDKに関連するページをAPIとして提供しております

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

## SDKUser
SDKUser ユーザデータのクラスです

| パラメータ名 | 説明 |
| --- | ---
| unclaimedMissionCount | 未獲得ミッションの数
| point | リワードサービスで取得したポイント

### RakutenRewardSDKStatus
RakutenRewardSDKStatus は Reward SDKの 状態を表します
| パラメータ名 | 説明
| --- | ---
| ONLINE | SDKの初期化が完了 SDKのメンバー情報が正しく更新された(ポイントおよび未獲得ミッション数)
| OFFLINE | SDKの初期化が未完了または失敗
| APPCODEINVALID | アプリケーションキーが間違っている
| TOKENEXPIRED | トークンの期限切れ |

#### Checking the status
```swift
let status = RakutenReward.shared.status
```

## Addtional Configuration
### SDK Setting
Enable Logging: setting the following isDebug to true
```swift
@objc public class RakutenReward {
public var isDebug: Bool
}
```

## API Data 

### Mission
| パラメータ名 | 説明 | 例
| --- | --- | ---
| name | ミッション名 | Mission A
| actionCode | ミッションアクションキー | ZIJCjBeQBHac8nJa
| iconurl | ミッションアイコンのURL | https://mprewardsdk.blob.core.windows.net/sdk-portal/appCode/actionCode.png
| instruction | ミッションの説明 | 1日1回プレイする
| condition | ミッションの達成上限などの説明 | 毎日10回達成可能
| notificationtype | ミッションのUIタイプ | NONE, BANNER, MODAL, CUSTOM
| point | ミッションのポイント | 10
| enddatestr | ミッションの終了日 <br> 日次の場合 : 本日の日付<br> 週次ミッションの場合 : 週の末日<br> Monthly : 月の末日<br> Custom : カスタムの　終了日<br> | 20190403
| till | ミッションの終了日までの日 | 残り3日
| addtional | 追加のメッセージなど |
| reachedCap | ミッションが上限に達しているかどうか | true
| times | ミッション達成に必要なアクション数 | 3
| progress | ミッションの現在のアクション数 | 1

### PointHistory

ポイント履歴

#### PointRecord

| パラメータ名 | 説明
| --- | --- 
| point | ポイント
| month | ポイントの日付(月)

### UnclaimedItem
| パラメータ名 | 説明
| --- | --- 
| name | ミッション名 |
| iconurl | ミッションアイコンのURL |
| instruction | ミッションの説明 |
| actionCode | ミッションアクションキー |
| notificationtype | ミッションのUIタイプ |
| point | ポイント |
| unclaimedTimes | 未獲得アイテムの数 |
| achieveddatestr | ミッション達成日 |

## API Errors
RewardSDKSessionError

|  名前 | 説明
| --- | --- 
| userNotFound | startSession に失敗
| appcodeInvalid | SDK の状態が APPCODEINVALID
| bundleError | パラメータが間違っている

RPGRequestError
| 名前 | 説明
| --- | ---
| tokenExpire | Access token is expired
| serverError | Cannot connect

SDKError
| 名前 | 説明
| --- | ---
| SessionNotInitialized | SDK is not initialized
| FeatureDisabledByUser | SDK function is not active by user

## 現在のユーザーのアクションの状態を取得する
```swift
RakutenReward.shared.getMissionListWithProgress(completion: {r in
                    switch r {
                    case .success(let mList): // mission List to display
		            case .failure(let err): // handling the error
		    }
}
```

## ミッション達成後のカスタムUIの作り方
ユーザがミッションを達成すると以下のコールバックが呼ばれます　

```swift
public var didUpdateUnclaimedAchievement: ((RakutenRewardNativeSDK.Mission) -> Void)?
```
開発者は このclosure をオーバーライドすることによりカスタムUIを実現できます

```swift
RakutenReward.shared.didUpdateUnclaimedAchievement = { m in
	guard m.notificationtype == .CUSTOM else { return }
	// show custom notification from `m`
	}
```
Claim 
```swift
RakutenReward.shared.claim(unclaimedItem: m, completion: nil)
```

---
LANGUAGE :
> [![en](../../lang/en.png)](../../advanced/README.md)