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
* [イベントアナリティクス](#イベントアナリティクス)<br>
* [ミッション達成後のカスタムUIの作り方](#ミッション達成後のカスタムUIの作り方)<br><br>

# API ガイド

## RakutenReward
---
RakutenReward クラスはリワードSDKの主要な設定を提供しております

| API 名 | 説明 | 例
| --- | --- | ---
| バージョンを取得する | バージョンを取得する | `[RakutenReward.shared getVersion];`
| SDKポータルを開く | SDKポータルを開く | `[RakutenReward.shared openPortalObjc:^(SDKErrorObjc * _Nullable error) { }];`
| 広告ポータルを開く(Jp のみ) | 広告ポータルを開 | `[RakutenReward.shared openAdPortalWithCompletionHandler:^(OpenAdPortalCompletion * _Nonnull error) { }];`
| ヘルプページを開く | ヘルプページをSDKのミニブラウザーで開く | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPageHelp];`
| 利用規約を開く | 利用規約をSDKのミニブラウザーで開く | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPageTermsCondition];`
| プライバシーポリシーを開く | プライバシーポリシーをDKのミニブラウザーで開く | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPagePrivacyPolicy];`
| ミッションリストを取得する | ミッションリストを取得する | `[RakutenReward.shared getMissionListWithProgressObjcWithCompletion:^(NSArray<MissionObject *> * _Nullable missions, NSError * _Nullable error) { }];`
| ポイント履歴を取得する | 3ヶ月前までのポイント履歴を取得する | `[RakutenReward.shared getPointHistoryObjcWithCompletion:^(PointHistoryObject * _Nullable pointHistoryObject, NSError * _Nullable error) {}];`
| アクションを送信する | ミッションを達成するためにアクションを送信する | `[RakutenReward.shared logActionObjcWithActionCode:@"ActionCodeExample" completion:^(NSError * _Nullable error) { }];`
| 未獲得ミッションを取得する | 未獲得ミッションリストを取得する | `[RakutenReward.shared getUnclaimedMissionWithCompletion:^(NSArray<UnclaimedItemObject *> * _Nullable unclaimedItems, NSError * _Nullable error) { }];`
| 最後にエラーの発生したダイナミックAPIの情報 | 最後にエラーの発生したダイナミックAPIの情報を取得する | `[RakutenReward.shared retryLastFailedFunctionByNewTokenWithNewAccessToken:@"NewTokenExample"];`
| 楽天ランクとポイントを取得する | 楽天ランクとポイントを取得する | `[RakutenReward.shared loadMemberInfoRankObjc:^(MemberPointRankObject * _Nullable memberPointRank, NSError * _Nullable error) { }];` |
| ログイン状態を取得する | ログインしているかどうか状態を取得する | `[RakutenReward.shared isLogin];` |
| ログアウト | ログアウトする | `[RakutenReward.shared logoutWithCompletion:^{ }];` |
| 開くURLを制限 | 表示を抑制するURLを追加する(Apple審査で特定の広告等でのリジェクトを抑制するため) | `RakutenReward.shared.blacklistURLs;` |
| カスタムURLセッション |  カスタムURLセッション | `RakutenReward.shared.customURLSession;` |
| IDFA | IDFAをセットする | `RakutenReward.shared.advertisingID;` |
| ミッションユーザー情報の更新のデリゲートメソッド | ユーザー情報が更新された時のコールバック | `RakutenReward.shared.didUpdateUserObjc = ^(SDKUserObject * _Nullable user) { };` |
| SDKの状態の更新のデリケートメソッド | SDKの状態が更新された場合のコールバック | `RakutenReward.shared.didUpdateStatus = ^(enum RakutenRewardStatus status) { };` |
| ポータルの表示状態が更新された場合のデリゲート | ポータルを表示状態変更のコールバック | RakutenReward.shared.didUpdateIsPortalPresentedStatus = ^(BOOL isPortalPresent) { }; |
| 広告ポータルの表示ステータスの更新情報を取得する | 広告ポータルが表示されているかどうかのコールバック | RakutenReward.shared.didUpdateIsAdPortalPresentedStatus = ^(BOOL isAdPortalPresent) { }; |
<br>

## RakutenRewardConfiguration
---
RakutenRewardConfiguration ユーザー設定のクラスです

| API 名 | 説明 | 例 
| --- | --- | ---
| オプトアウトの取得 | オプトアウトの状態を取得する <br>true : オプトアウト (リワードSDKは動作しません) | RewardConfiguration.isUserOptingOut;
| オプトアウトの設定 | オプトアウトの状態を設定する | RewardConfiguration.isUserOptingOut = false;
| UI設定の取得 |  ミッションのUIのオン・オフ設定設定を取得する | RewardConfiguration.isUserSettingUIEnabled;
| UI設定 | ミッションのUIのオン・オフ設定 | RewardConfiguration.isUserSettingUIEnabled = true;
| ログをオンにする | デバッグログのオン・オフ設定 | RewardConfiguration.isDebug = true;
| Rzクッキー | Rzクッキーをセットする | RewardConfiguration.rzCookie = @"example";
| Rpクッキー | Rpクッキーをセットする | RewardConfiguration.rpCookie = @"example";
| アクション失敗時の履歴保存設定 | LogActionが失敗した場合にアクションを保存する | RewardConfiguration.actionHistoryEnabled = true;
| SDKポータルが表示されているか? | SDKポータルが表示されているかどうかを取得する | RewardConfiguration.isPortalPresent;
| 広告ポータルが表示されているか? | 広告ポータルが表示されているかどうかを取得 | RewardConfiguration.isAdPortalPresent;
| ミッションイベント機能をサポートしているかどうかを取得する | ミッションイベント機能をサポートしているかどうかを取得する | RewardConfiguration.isMissionEventFeatureEnabled = true;
<br>

## 楽天リワードのページを開く
---
SDK は各種SDKのページを開くためのAPIを提供しております


```objective-c
// サポートページタイプ
SupportPagePrivacyPolicy;
SupportPageTermsCondition;
SupportPageHelp;

// ヘルプページを表示する例
[RakutenReward.shared openSupportPageObjcWithPage:SupportPageHelp];
```
<br>

## SDKUser
---
SDKUser : ユーザークラス

```objective-c
SDKUserObject *user = RakutenReward.shared.getUserObjc;
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
```objective-c
RakutenReward.shared.status;
```
<br>

## API データ
---
<br>

### Mission
```objective-c
MissionObject *mission = [MissionObject alloc]; // 例
```
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
| getPointHistory | ポイント履歴の取得 | [RakutenReward.shared getPointHistoryObjcWithActionCode:@"ActionCodeExample" completion:^(PointHistoryObject * _Nullable pointHistory, NSError * _Nullable error) { }];
<br>

#### PointRecord
```objective-c
PointRecordObject *pointRecord = [PointRecordObject alloc]; // 例
```
| パラメータ | 説明
| --- | --- 
| point | ポイント
| month | ポイント付与月 YYYYMM
<br>

### UnclaimedItem
```objective-c
UnclaimedItemObject *unclaimedItem = [UnclaimedItemObject alloc]; // 例
```
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
| getAchievedDate() | “yyyy/MM/dd” フォーマットで達成日を取得できるように変更 |
<br>

## API エラー
---
<br>

### RewardSDKSessionError

| 名前 | 説明
| --- | --- 
| RewardSDKSessionErrorObjcUserNotFound |  startSessionに失敗した
| RewardSDKSessionErrorObjcAppcodeInvalid | SDKの状態がAPPCODEINVALID
| RewardSDKSessionErrorObjcBundleError |  パラメータが間違っている
| RewardSDKSessionErrorObjcLoginRequired | (SDK提供のログインの場合のみ) SDK APIを使用するにはログインが必要です 
| RewardSDKSessionErrorObjcInvalidTokenType | (SDK提供のログインの場合のみ) トークンのタイプが間違っている
| RewardSDKSessionErrorObjcCannotRetrieveSessionToken | (SDK提供のログインの場合のみ) トークンの取得に失敗しました、再度ログインしてください
| RewardSDKSessionErrorObjcCannotLogOutOnServer | (SDK提供のログインの場合のみ) ログアウトに失敗した
<br>

### RPGRequestError  

| 名前 | 説明
| --- | ---
| RPGRequestErrorObjcTokenExpire | トークンの期限切れ
| RPGRequestErrorObjcServerError | 接続に失敗した
<br>

### SDKError  

| 名前 | 説明
| --- | ---
| SDKErrorObjcNoMissionFound | ミッションの取得できなかった
| SDKErrorObjcNoUnclaimedItemFound | 未獲得ミッションが取得できなかった
| SDKErrorObjcSessionNotInitialized | SDKが初期化されていない
| SDKErrorObjcFeatureDisabledByUser | SDK function is not active by user
| SDKErrorObjcSDKStatusNotOnline | SDK status is not online
<br>

## ミッションの一覧を取得
---
```objective-c
[RakutenReward.shared getMissionListWithProgressObjcWithCompletion:^(NSArray<MissionObject *> * _Nullable missions, NSError * _Nullable error) {
    if (error != nil) {
        // エラー
    }
    // 成功
}];
}
```
<br>

## RakutenRewardAdConfiguration
---
こちらの機能は台湾でのみご利用になれます
```objective-c
RakutenRewardAdConfiguration.shared;
```
| パラメータ名 | 説明 | 例 
| --- | --- | ---
| bcat | 広告のコンテンツをIABのコンテンツに基づきブロックする  | RakutenRewardAdConfiguration.shared.bcat;
| badv | 広告のドメインレベルでのブロック | RakutenRewardAdConfiguration.shared.badv;
| appDomain |  アプリのドメイン(アプリの紹介ページのトップなど) | RakutenRewardAdConfiguration.shared.appDomain;
| storeUrl | アプリストアのURL | RakutenRewardAdConfiguration.shared.storeUrl;
| privacyPolicy | プライバシーポリシーの有無　 0　= 用意していない、 1 = 用意している | RakutenRewardAdConfiguration.shared.privacyPolicy;
| paid | アプリが無料か有料かどうか 0 = 無料、 1 = 有料 | RakutenRewardAdConfiguration.shared.paid;
| keywords | アプリのキーワード | RakutenRewardAdConfiguration.shared.keywords;
| test | テストモードの切り替え(デバッグ用) | RakutenRewardAdConfiguration.shared.test;
<br>

| メソッド | 説明 | 例 
| --- | --- | ---
| addBlockCategory | 広告のコンテンツブロックの対象を追加する<br>フォーマット: IAB(Number)-(Number) | [RakutenRewardAdConfiguration.shared addBlockCategoryWithStr:@"IAB7-17"];
| addBlockDomain | 広告のドメインレベルでのブロックの対象を追加する | [RakutenRewardAdConfiguration.shared addBlockDomainWithStr:@"www.example.com"];
| addKeywords | 広告キーワードを追加する | [RakutenRewardAdConfiguration.shared addKeywordsWithStr:@"productivity"];
<br>

## クッキーをセットする
---
この機能はSDK v2.2.0　からサポートしています。
この機能は楽天のアプリケーションですでに広告のためのクッキーを取得している場合に推奨される機能となります。
もし、デフォルトのログインオプション(TokenTypeRakutenAuth)をご使用の場合にはこちらの処理はSDKで行いますので、実装する必要はありません。 もし他のオプションをご利用の場合、このAPIをご利用されるとクッキーを上書きいたします。

Rpクッキーをセットする
```swift
RewardConfiguration.rpCookie = @"example";
```

Rzクッキーをセットする
```swift
RewardConfiguration.rzCookie = @"example";
```

<br>

## イベントアナリティクス
---
この機能はSDK v3.3.0　からサポートしています。<br>
```objc
[RakutenMissionEvent.shared logActionWithEventCode:@"exampleEventCode" eventTrackingType: RakutenMissionEventTrackingTypeGenericEvent parameters:NULL completionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
        // Error
        return;
    }

    // Success
}];
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
| RakutenMissionEventTrackingTypeGenericEvent | 通常イベントのトラッキング |
| RakutenMissionEventTrackingTypeRatSpecificEvent | カスタムイベントのトラッキング |

<br>Analytics SDK  リファレンス: https://documents.developers.rakuten.com/ios-sdk/analytics-9.1/

## ミッション達成後のカスタムUIの作り方
---
ユーザーがミッションを達成すると、コールバックを受け取れます

```objective-c
@property (nonatomic, copy) void (^ _Nullable didUpdateUnclaimedAchievementObjc)(UnclaimedItemObject * _Nonnull);
```
こちらのコールバックをOverrideしてイベントを受け取りカスタムUIを表示します<br>
Note : SDKポータル上でミッション達成のノーティフィケーションを表示することは推奨されていません。(デフォルトのバナーとモーダルはSDKで対応済み) カスタムでUIを作るときは、RewardConfiguration.isPortalPresent APIで状態を確認し、ポータルが表示(true)の場合は表示しないようにお願いいたします。
この機能はSDK 2.3.0から使用可能です。

```objective-c
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = ^(UnclaimedItemObject * _Nonnull unclaimedItem) {
    if ([unclaimedItem.notificationType isKindOfClass:[NotificationTypeObjcCUSTOM class]] && // Check notification type
        RewardConfiguration.isUserSettingUIEnabled && // Check if user enable the UI setting or not
        !RewardConfiguration.isPortalPresent) { // Check if Portal is currently showing, not support for showing notification inside Portal.

        // Show Custom UI in Main thread
    }
};
```

ポイントを獲得するには、MissionAchievementDataクラスの claim API を使います。
ユーザーに対して達成のノーティフィケーションを見せた後、クレームの処理を上記のAPIを呼び出して行います。

```objective-c
UnclaimedItemObject *unclaimedItemObject = [UnclaimedItemObject alloc]; // テストオブジェクト

[RakutenReward.shared claimObjcWithUnclaimedItemObject:unclaimedItemObject completion:^(PointClaimScreenEventObjc * _Nonnull pointClaimScreenEvent) {
    if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcWillPresent class]]) {}
    else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidFailToShow class]]) {}
    else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidSelfDismiss class]]) {}
    else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidDismissByUser class]]) {}
    else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidFailToClaim class]]) {}
    else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidClaimSuccessfully class]]) {}
}];
```
<br>

---
言語 :
> [![en](../../../lang/en.png)](../../APIReference/README.md)
