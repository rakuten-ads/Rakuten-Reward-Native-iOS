[TOP](../../README.md#top)　> API Reference

Table of Contents
* [Rakuten Reward](#rakutenreward)<br>
* [Rakuten Reward Configuration](#rakutenrewardconfiguration)<br>
* [Open Reward Web Page](#open-reward-web-page)<br>
* [SDKUser](#sdkuser)<br>
* [RakutenRewardStatus](#rakutenrewardstatus)<br>
* [API Data](#api-data)<br>
  * [Mission](#mission)<br>
  * [PointHistory](#pointhistory)<br>
  * [PointRecord](#pointrecord)<br>
  * [UnclaimedItem](#unclaimeditem)<br>
* [API Errors](#api-errors)<br>
* [Get current user action status](#get-current-user-action-status)<br>
* [Rakuten Reward Ad Configuration (TW only)](#rakutenrewardadconfiguration)<br>
* [How to create custom mission UI](#how-to-create-custom-mission-ui)<br><br>

# API Reference

## RakutenReward
---
RakutenReward class is to provide main settings and main functions of Reward SDK  

| API Name | Description | Example
| --- | --- | ---
| Get version |  Get Rakuten Reward SDK Version | `[RakutenReward.shared getVersion];`
| Open SDK Portal | For detail, please check sample application implementation | `[RakutenReward.shared openPortalObjc:^(SDKErrorObjc * _Nullable error) { }];`
| Open Help Page | Open Reward SDK Help page with mini browser | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPageHelp];`
| Open Terms and Condition Page | Open Reward SDK Terms and Conditions Page with mini browser | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPageTermsCondition];`
| Open Privacy Policy Page | Open Reward SDK Privacy Policy Page with mini browser | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPagePrivacyPolicy];`
| Get Missions | Get missions | `[RakutenReward.shared getMissionListWithProgressObjcWithCompletion:^(NSArray<MissionObject *> * _Nullable missions, NSError * _Nullable error) { }];`
| Get Point history | Get 3 month user's point history | `[RakutenReward.shared getPointHistoryObjcWithCompletion:^(PointHistoryObject * _Nullable pointHistoryObject, NSError * _Nullable error) {}];` 
| Log Action | Post user action | `[RakutenReward.shared logActionObjcWithActionCode:@"ActionCodeExample" completion:^(NSError * _Nullable error) { }];`
| Get Unclaimed Items | Get Unclaim item list | `[RakutenReward.shared getUnclaimedMissionWithCompletion:^(NSArray<UnclaimedItemObject *> * _Nullable unclaimedItems, NSError * _Nullable error) { }];`
| Get Dynamic API last failed info | Get last failed API info(paremeter) | `[RakutenReward.shared retryLastFailedFunctionByNewTokenWithNewAccessToken:@"NewTokenExample"];`
| Get Point & Rank | Load latest point & rank from server | `[RakutenReward.shared loadMemberInfoRankObjc:^(MemberPointRankObject * _Nullable memberPointRank, NSError * _Nullable error) { }];` |
| Log In | Open Log In page | `[RakutenReward.shared openLoginPage:^(enum LoginPageCompletion completion) { }];` |
| Check Log In | Check if user is logged in with internal system (token not expired) | `[RakutenReward.shared isLogin];` |
| Log Out | Log out from Rakuten Auth, you might force removing session even if server sync up failed | `[RakutenReward.shared logoutObjcWithForceRemoveToken:true completion:^(NSError * _Nullable completion) {}];` |
<br>

## RakutenRewardConfiguration
---
RakutenRewardConfiguration is user setting class.

| API Name | Description | Example 
| --- | --- | ---
| Get Optout | Get Optout status <br>true : Optout (Reward SDK function does not work) | RewardConfiguration.isUserOptingOut;
| Set Optout | Set Optout status | RewardConfiguration.isUserOptingOut = false;
| UI Enabled |  Get whether Notification UI is enabled or not | RewardConfiguration.isUserSettingUIEnabled;
| Set UI Enabled | Set whether Notification UI is enabled or not | RewardConfiguration.isUserSettingUIEnabled = true;
| Enable Logging | Set value to true to receive additional Debug log info | RewardConfiguration.isDebug = true;
<br>

## Open Reward Web page
---
SDK provide page open with API

```objective-c
// Support page types
SupportPagePrivacyPolicy;
SupportPageTermsCondition;
SupportPageHelp;

// Example of showing help page
[RakutenReward.shared openSupportPageObjcWithPage:SupportPageHelp];
```
<br>

## SDKUser
---
SDKUser : User class

```objective-c
SDKUserObject *user = RakutenReward.shared.getUserObjc;
```

| Parameter | Description
| --- | ---
| signIn | Whether the user is singin or not
| unclaimedMissionCount | Number of unclaim mission
| point | Reward SDK Point
| currentPointRank | `MemberPointRank`; member points and rank, persistent & loaded separately
| getName | Get user's username
<br>

## RakutenRewardStatus
---
RakutenRewardStatus is Reward SDK status  

| Parameter | Description
| --- | ---
| RakutenRewardStatusOnline | Finished SDK initialization(Update User info correctly)
| RakutenRewardStatusOffline | Not finished SDK initialization or initialization failed
| RakutenRewardStatusAppcodeInvalid | Wrong Application Code
| RakutenRewardStatusTokenExpired | Expired Token. If `tokenType` is `RakutenAuth`, `.TokenExpired` means user should log in again
<br>

### Checking the status
```objective-c
RakutenReward.shared.status;
```
<br>

## API Data
---
<br>

### Mission
```objective-c
MissionObject *mission = [MissionObject alloc]; // Example
```

| Parameter | Description | Example
| --- | --- | ---
| name | Mission name | Mission A
| actionCode | Mission Action Key | ZIJCjBeQBHac8nJa
| iconurl | Mission icon URL | https://mprewardsdk.blob.core.windows.net/sdk-portal/appCode/actionCode.png
| instruction | Mission instruction | One day one play
| condition | Descritpion about mission max achievable | 10 times achievable
| notificationtype | Mission UI Type | NONE, BANNER, MODAL, CUSTOM
| point | Mission Point | 10
| enddatestr | Mission End Date <br> Daily : Today<br> Weekly : End of week<br> Monthly : Endof Month<br> Custom : Custom End Date<br> | 20190403
| till | Mission End date | 3 days
| addtional | Additional messages |
| reachedCap | Whether mission reached max cap or not | true
| times | Required action times | 3
| progress | Current action times | 1
<br>

### PointHistory

| Method | Description | Example
| --- | --- | ---
| getPointHistory | Get a list of point history | [RakutenReward.shared getPointHistoryObjcWithActionCode:@"ActionCodeExample" completion:^(PointHistoryObject * _Nullable pointHistory, NSError * _Nullable error) { }];
<br>

#### PointRecord
```objective-c
PointRecordObject *pointRecord = [PointRecordObject alloc]; // Example
```
| Parameter | Description
| --- | --- 
| point | Point
| month | Point Date(Month)
<br>

### UnclaimedItem
```objective-c
UnclaimedItemObject *unclaimedItem = [UnclaimedItemObject alloc]; // Example
```
| Parameter | Description
| --- | --- 
| name | Mission name |
| iconurl | Mission icon URL |
| instruction | Mission Instruction |
| actionCode | Mission Action Code |
| notificationtype | Mission UI Type |
| point | Point |
| unclaimedTimes | Number of Unclaim Item |
| achieveddatestr | Mission Achievement Date |
<br>

## API Errors
---
<br>

### RewardSDKSessionError

|  Name | Description
| --- | --- 
| RewardSDKSessionErrorObjcUserNotFound | Failed startSession
| RewardSDKSessionErrorObjcAppcodeInvalid | SDK status is APPCODEINVALID
| RewardSDKSessionErrorObjcBundleError | Parameters are wrong
| RewardSDKSessionErrorObjcLoginRequired | (internal log-in only) start session or use API before log in 
| RewardSDKSessionErrorObjcInvalidTokenType | (internal log-in only) Token type is not valid
| RewardSDKSessionErrorObjcCannotRetrieveSessionToken | (internal log-in only) failed to get token to use APIs, please start session again
| RewardSDKSessionErrorObjcCannotLogOutOnServer | (internal log-in only) failed to log out
<br>

### RPGRequestError  

| Name | Description
| --- | ---
| RPGRequestErrorObjcTokenExpire | Access token is expired
| RPGRequestErrorObjcServerError | Cannot connect
<br>

### SDKError  

| Name | Description
| --- | ---
| SDKErrorObjcNoMissionFound | Mission list is empty
| SDKErrorObjcNoUnclaimedItemFound | UnclaimedItem list is empty
| SDKErrorObjcSessionNotInitialized | SDK is not initialized
| SDKErrorObjcFeatureDisabledByUser | SDK function is not active by user
| SDKErrorObjcSDKStatusNotOnline | SDK status is not online
<br>

## Get current user action status
---
```objective-c
[RakutenReward.shared getMissionListWithProgressObjcWithCompletion:^(NSArray<MissionObject *> * _Nullable missions, NSError * _Nullable error) {
    if (error != nil) {
        // Error
    }
    // Successful
}];
}
```
<br>

## RakutenRewardAdConfiguration
---
This configuration is only for TW region.
```objective-c
RakutenRewardAdConfiguration.shared;
```
| Property Name | Description | Example 
| --- | --- | ---
| bcat | Blocked advertiser categories using the IAB content | RakutenRewardAdConfiguration.shared.bcat;
| badv | Block list of advertisers by their domains | RakutenRewardAdConfiguration.shared.badv;
| appDomain |  Domain of the app | RakutenRewardAdConfiguration.shared.appDomain;
| storeUrl | App store URL | RakutenRewardAdConfiguration.shared.storeUrl;
| privacyPolicy | Indicates if the app has a privacy policy, where 0 = no, 1 = yes | RakutenRewardAdConfiguration.shared.privacyPolicy;
| paid | Indicates if the app is free or paid, where 0 = free, 1 = paid | RakutenRewardAdConfiguration.shared.paid;
| keywords | Keywords about the app | RakutenRewardAdConfiguration.shared.keywords;
| test | To enable Ads testing. Set to true if debug only. | RakutenRewardAdConfiguration.shared.test;
<br>

| Method | Description | Example 
| --- | --- | ---
| addBlockCategory | Append block category string to bcat array<br>Format: IAB(Number)-(Number).| [RakutenRewardAdConfiguration.shared addBlockCategoryWithStr:@"IAB7-17"];
| addBlockDomain | Append domain string to badv array. | [RakutenRewardAdConfiguration.shared addBlockDomainWithStr:@"www.example.com"];
| addKeywords | Append keyword string to keywords array. | [RakutenRewardAdConfiguration.shared addKeywordsWithStr:@"productivity"];
<br>

## How to create custom mission UI
---
When the user achieved the mission, following callback is invoked

```objective-c
@property (nonatomic, copy) void (^ _Nullable didUpdateUnclaimedAchievementObjc)(UnclaimedItemObject * _Nonnull);
```
Override this method and create UI under this

```objective-c
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = ^(UnclaimedItemObject * _Nonnull unclaimedItem) {
    if ([unclaimedItem.notificationType isKindOfClass:[NotificationTypeObjcCUSTOM class]]) {
        // Show custom notification from here
    }
};
```
Claim 
```objective-c
UnclaimedItemObject *unclaimedItemObject = [UnclaimedItemObject alloc]; // Test object

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
LANGUAGE :
> [![ja](../../lang/ja.png)](../ja/APIReference/README.md)
