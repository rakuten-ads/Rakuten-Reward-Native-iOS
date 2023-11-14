[TOP](../../../README.md#top)　> FAQ

FAQ
* [Does the SDK support M1/arm64 simulator architecture?](#does-the-sdk-support-m1arm64-simulator-architecture)<br>
* [How can I implement the custom notification UI?](#how-can-i-implement-the-custom-notification-ui)<br>
* [How do I claim mission after a mission is achieved?](#how-do-i-claim-mission-after-a-mission-is-achieved)<br>
* [How to set IDFA in RewardSDK?](#how-to-set-idfa-in-rewardsdk)<br>
* [Can we access the Staging environment for development/testing?](#can-we-access-the-staging-environment-for-developmenttesting)<br>
* [Can we use ID SDK + JID backend to log in?](#can-we-use-id-sdk-jid-backend-to-log-in)<br>
* [What is Rakuten auth login for?](#what-is-rakuten-auth-login-for)<br>
* [Which API should I use to start/establish SDK session?](#which-api-should-i-use-to-startestablish-sdk-session)<br>

# FAQ

## Does the SDK support M1/arm64 simulator architecture?
<details>
  <summary>Answer</summary>
Yes, M1 (arm64 simulator arch) is supported starting from version 3.4.3

</details>

<br>

## How can I implement the custom notification UI?

<details>
  <summary>Answer</summary>
  
For example, Mission A needs 3 actions logged to be achieved.
```
[RakutenReward.shared logActionObjcWithActionCode:@"Example actioncode" completion:^(NSError * _Nullable error) { }];
```

After the above logAction API is called three times successfully, mission A is achieved. App can get the unclaimedItem from the delegate below
```
// From RakutenReward class
public var didUpdateUnclaimedAchievementObjc: ((UnclaimedItemObject) -> Void)?
 
// Example
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = { unclaimedItem in }
```

Example implementation for showing custom UI
```
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = ^(UnclaimedItemObject * _Nonnull unclaimedItem) {
    if ([unclaimedItem.notificationType isKindOfClass:[NotificationTypeObjcCUSTOM class]] && // Check notification type
        RewardConfiguration.isUserSettingUIEnabled && // Check if user enable the UI setting or not
        !RewardConfiguration.isPortalPresent) { // Check if Portal is currently showing, not support for showing notification inside Portal.

        // Show Custom UI in Main thread
    }
};
```
</details>

<br>

## How do I claim mission after a mission is achieved?

<details>
  <summary>Answer</summary>
  
For example, Mission A needs 3 actions logged to be achieved.
```
[RakutenReward.shared logActionObjcWithActionCode:@"Example actioncode" completion:^(NSError * _Nullable error) { }];
```

After the above logAction API is called three times successfully, mission A is achieved. App can get the unclaimedItem from the delegate below
```
// From RakutenReward class
public var didUpdateUnclaimedAchievementObjc: ((UnclaimedItemObject) -> Void)?
 
// Example
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = { unclaimedItem in }
```

Points can be claimed by calling the 'claim' method from RakutenReward shared object.
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

## How to set IDFA in RewardSDK?

<details>
  <summary>Answer</summary>
  
IDFA/Advertising ID can be set using below API
```
RakutenReward.sharedInstance.advertisingID
```

Example
```
// Requesting for ATTracking permission, if authorized
if (ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusAuthorized) {
    RakutenReward.shared.advertisingID = ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
}
```
</details>

<br>

## Can we access the Staging environment for development/testing?

<details>
  <summary>Answer</summary>
  
No, currently we do not provide Staging environment for developers. Please use development mode or test account for development/testing.
</details>

<br>

## Can we use ID SDK + JID backend to log in?

<details>
  <summary>Answer</summary>
  
Yes, with IDSDK and JID as backend, you can set the token type as RID
```
// iOS example
RakutenReward.shared.tokenType = TokenTypeRID;
```

Then can pass (API-C) token value in the startSession API 
```
// iOS example

[RakutenReward.shared startSessionObjcWithAppCode:@"Appcode" accessToken:@"sessionAccessToken" completion:^(SDKUserObject * _Nullable user, RewardSDKSessionErrorObjc * _Nullable error) { }];
```

</details>

<br>

## What is Rakuten auth login for?

<details>
  <summary>Answer</summary>
  
The RakutenAuth login option is for third-party. For example, apps outside Rakuten do not use Rakuten login SDK (RID or RAE). Therefore, they can use the RakutenAuth login option. If your app is using Rakuten login SDK already, then you don't need to use the Rakuten auth login option
</details>

<br>

## Which API should I use to start/establish SDK session?

<details>
  <summary>Answer</summary>
  
The SDK has 2 APIs for starting sessions. <br>

If you log in with IDSDK/UserSDK (RID/RAE),
```
[RakutenReward.shared startSessionObjcWithAppCode:@"Appcode" accessToken:@"sessionAccessToken" completion:^(SDKUserObject * _Nullable user, RewardSDKSessionErrorObjc * _Nullable error) { }];
```

Otherwise, if you're using Third Party login (non-Rakuten login),
```
[RakutenReward.shared startSessionObjcWithAppCode:@"Appcode" completion:^(SDKUserObject * _Nullable user, RewardSDKSessionErrorObjc * _Nullable error) { }];
```

</details>

<br>

LANGUAGE :
> [![ja](../../lang/ja.png)](../ja/FAQ/FAQ.md)
