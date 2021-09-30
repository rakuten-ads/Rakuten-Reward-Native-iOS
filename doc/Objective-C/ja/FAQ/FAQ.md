[TOP](../../../../README.md#top)　>　FAQ

FAQ
* [カステムでミッションのノーティフィケーションを作りたい](#カステムでミッションのノーティフィケーションを作りたい)<br>
* [ミッション達成後はどのようにポイントをクレイムすれば良いですか？](#ミッション達成後はどのようにポイントをクレイムすれば良いですか)<br>
* [IDFAをRewardSDKにどのように設定すれば良いですか?](#idfaをrewardsdkにどのように設定すれば良いですか)<br>
* [開発/テストのために、ステージング環境にはアクセスできますか？](#開発テストのためにステージング環境にはアクセスできますか)<br>
* [IDSDKとJIDでログインはできますか？](#idsdkとjidでログインはできますか)<br>
* [Rakuten auth loginとはなんですか？](#rakuten-auth-loginとはなんですか)<br>
* [SDKのセッションをスタートさせるのにどのAPIを使用すれば良いですか？](#sdkのセッションをスタートさせるのにどのapiを使用すれば良いですか)<br>

# FAQ

## カステムでミッションのノーティフィケーションを作りたい

<details>
  <summary>回答</summary>
  
例えば、 Mission A は 3 回のアクションを必要とします。
```
[RakutenReward.shared logActionObjcWithActionCode:@"Example actioncode" completion:^(NSError * _Nullable error) { }];
```

logAction API が3回呼ばれると Mission A は達成します。　アプリケーションは達成の delegate　を受け取ります。
```
// RakutenReward class
public var didUpdateUnclaimedAchievementObjc: ((UnclaimedItemObject) -> Void)?
 
// 例
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = { unclaimedItem in }
```

カスタムノーティフィケーションを表示する例
```
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = ^(UnclaimedItemObject * _Nonnull unclaimedItem) {
    if ([unclaimedItem.notificationType isKindOfClass:[NotificationTypeObjcCUSTOM class]] && // タイプを確認
          RewardConfiguration.isUserSettingUIEnabled, // ユーザのUI設定を確認
        RewardConfiguration.isUserSettingUIEnabled && // 
        !RewardConfiguration.isPortalPresent) { // ポータルにUIがないかどうかを確認する（ポータル上での表示はおすすめいたしません）

       // UIを Main スレッドで表示する
    }
};
```
</details>

<br>

## ミッション達成後はどのようにポイントをクレイムすれば良いですか？

<details>
  <summary>回答</summary>
  
例えば、 Mission A は 3 回のアクションを必要とします。
```
[RakutenReward.shared logActionObjcWithActionCode:@"Example actioncode" completion:^(NSError * _Nullable error) { }];
```

logAction API が3回呼ばれると Mission A は達成します。　アプリケーションは達成の delegate　を受け取ります。
```
// RakutenReward class
public var didUpdateUnclaimedAchievementObjc: ((UnclaimedItemObject) -> Void)?
 
// 例
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = { unclaimedItem in }
```

RakutenReward shared objectの claim メソッドを呼ぶことでポイントをクレイムします。
```
[RakutenReward.shared claimObjcWithUnclaimedItemObject:unclaimedItemObject completion:^(PointClaimScreenEventObjc * _Nonnull pointClaimScreenEvent) {
    if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcWillPresent class]]) {}
    else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidFailToShow class]]) {}
    else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidSelfDismiss class]]) {}
    else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidDismissByUser class]]) {}
    else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidFailToClaim class]]) {}
    else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidClaimSuccessfully class]]) {}
}];
```
</details>

<br>

## IDFAをRewardSDKにどのように設定すれば良いですか?

<details>
  <summary>回答</summary>
  
IDFA/Advertising ID は下記のAPIで設定できます。
```
RakutenReward.sharedInstance.advertisingID
```

例
```
// ATTracking パーミッションを要求する
if (ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusAuthorized) {
    RakutenReward.shared.advertisingID = ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
}
```
</details>

<br>

## 開発/テストのために、ステージング環境にはアクセスできますか？

<details>
  <summary>回答</summary>
  
現在、開発/テストのために、ステージング環境は提供しておりません。<br/>
開発モードかもしくはテスト用のアカウントをご利用ください。
</details>

<br>

## IDSDKとJIDでログインはできますか？

<details>
  <summary>回答</summary>
  
IDSDK と JID でログインすることができます, その場合 tokenTypeをRIDに設定します。
```
// iOS の例
RakutenReward.shared.tokenType = TokenTypeRID;
```

API-Cのアクセストークンを　startSession API に渡します。
```
// iOS example

[RakutenReward.shared startSessionObjcWithAppCode:@"Appcode" accessToken:@"sessionAccessToken" completion:^(SDKUserObject * _Nullable user, RewardSDKSessionErrorObjc * _Nullable error) { }];
```

</details>

<br>

## Rakuten auth loginとはなんですか？

<details>
  <summary>回答</summary>
  
RakutenAuth login オプションは楽天のログインをアプリで持っていらっしゃらないアプリケーション向けに提供しております(楽天のアプリケーションでログイン関連のSDKをご利用の場合はこちらを使用しなくても良いです)。
</details>

<br>

## SDKのセッションをスタートさせるのにどのAPIを使用すれば良いですか？

<details>
  <summary>回答</summary>
  
SDK では セッションをスタートさせるのに、2 つの API を用意しています。<br>

もし、IDSDK/UserSDK (RID/RAE)、をご使用の場合はこちら
```
[RakutenReward.shared startSessionObjcWithAppCode:@"Appcode" accessToken:@"sessionAccessToken" completion:^(SDKUserObject * _Nullable user, RewardSDKSessionErrorObjc * _Nullable error) { }];
```

その他の場合はこちらになります。
```
[RakutenReward.shared startSessionObjcWithAppCode:@"Appcode" completion:^(SDKUserObject * _Nullable user, RewardSDKSessionErrorObjc * _Nullable error) { }];
```

</details>

<br>



---
言語 :
> [![en](../../../lang/en.png)](../../FAQ/FAQ.md)
