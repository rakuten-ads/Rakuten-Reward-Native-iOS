[TOP](../../README.md#top)　> API Reference

Table of Contents
* [Rakuten Reward](#rakutenreward)<br>
* [Rakuten Reward Configuration](#rakutenrewardconfiguration)<br>
* [Mission Token Provider](#mission-token-provider)<br>
* [Open Reward Web Page](#open-reward-web-page)<br>
* [SDKUser](#sdkuser)<br>
* [RakutenRewardStatus](#rakutenrewardstatus)<br>
* [RakutenRewardConsentStatus](#rakutenrewardconsentstatus)<br>
* [TokenType](#tokentype)<br>
* [RakutenRewardRegion](#rakutenrewardregion)<br>
* [SDKEnvironment](#sdkenvironment)<br>
* [LoginPageCompletion](#loginpagecompletion)<br>
* [PointClaimScreenEvent](#pointclaimscreenevent)<br>
* [API Data](#api-data)<br>
  * [Mission](#mission)<br>
  * [MissionLite](#missionlite)<br>
  * [PointHistory](#pointhistory)<br>
  * [PointRecord](#pointrecord)<br>
  * [UnclaimedItem](#unclaimeditem)<br>
  * [MemberPointRank](#memberpointrank)<br>
  * [RewardRedeemRequest](#rewardredeemrequest)<br>
  * [LinkShareItemPointHistory](#linkshareitempointhis tory)<br>
  * [LinkShareProcessingPoint](#linkshareprocessingpoint)<br>
* [API Errors](#api-errors)<br>
* [Get current user action status](#get-current-user-action-status)<br>
* [Set Rakuten Cookie](#set-rakuten-cookie)<br>
* [Event Analytics](#event-analytics)<br>
* [How to create custom mission UI](#how-to-create-custom-mission-ui)<br><br>

# API Reference

## RakutenReward
---
RakutenReward class is to provide main settings and main functions of Reward SDK  

| API Name | Description | Example
| --- | --- | ---
| Get version |  Get Rakuten Reward SDK Version | `[RakutenReward.shared getVersion];`
| Open SDK Portal | Open SDK Portal | `[RakutenReward.shared openPortalObjc:^(SDKErrorObjc * _Nullable error) { }];`
| Open SPS Portal | Open SPS Portal with Rz cookie | `[RakutenReward.shared openSpsPortalWithRzCookie:@"cookie" completionHandler:^(SDKErrorObjc * _Nullable error) { }];`
| Open Help Page | Open Reward SDK Help page with mini browser | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPageHelp];`
| Open Terms and Condition Page | Open Reward SDK Terms and Conditions Page with mini browser | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPageTermsCondition];`
| Open Privacy Policy Page | Open Reward SDK Privacy Policy Page with mini browser | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPagePrivacyPolicy];`
| Open SPS Terms and Condition Page | Open SPS Terms and Conditions Page with mini browser | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPageSpsTermsCondition];`
| Open SPS Privacy Policy Page | Open SPS Privacy Policy Page with mini browser | `[RakutenReward.shared openSupportPageObjcWithPage:SupportPageSpsPrivacyPolicy];`
| Get Missions | Get missions | `[RakutenReward.shared getMissionListWithProgressObjcWithCompletion:^(NSArray<MissionObject *> * _Nullable missions, NSError * _Nullable error) { }];`
| Get Missions Lite | Get missions lite (without progress and reachedCap) | `[RakutenReward.shared getMissionLiteListObjcWithCompletion:^(NSArray<MissionLiteObject *> * _Nullable missionsLite, NSError * _Nullable error) { }];`
| Get Mission Details | Get details for a specific mission by action code | `[RakutenReward.shared getMissionDetails:@"actionCode" completion:^(MissionObject * _Nullable mission, NSError * _Nullable error) { }];`
| Get Point history | Get 3 month user's point history | `[RakutenReward.shared getPointHistoryObjcWithCompletion:^(PointHistoryObject * _Nullable pointHistoryObject, NSError * _Nullable error) { }];`
| Log Action | Post user action | `[RakutenReward.shared logActionObjcWithActionCode:@"ActionCodeExample" completion:^(NSError * _Nullable error) { }];`
| Get Unclaimed Items | Get Unclaim item list | `[RakutenReward.shared getUnclaimedMissionWithCompletion:^(NSArray<UnclaimedItemObject *> * _Nullable unclaimedItems, NSError * _Nullable error) { }];`
| Claim Mission | Claim unclaimed mission points | `[RakutenReward.shared claimObjcWithUnclaimedItemObject:unclaimedItem completion:^(PointClaimScreenEventObjc * _Nonnull event) { }];`
| Claim Mission with Ichiba callback | Claim unclaimed mission points with Ichiba deeplink support | `[RakutenReward.shared claimObjcWithUnclaimedItemObject:unclaimedItem enableIchibaCallback:YES completion:^(PointClaimScreenEventObjc * _Nonnull event) { }];`
| Get Point & Rank | Load latest point & rank from server | `[RakutenReward.shared loadMemberInfoRankObjc:^(MemberPointRankObject * _Nullable memberPointRank, NSError * _Nullable error) { }];`
| Get Link Share Point History | Get Link Share item point history | `[RakutenReward.shared getLSPointHistoryWithRequestData:request offset:0 limit:20 completion:^(LinkShareItemPointHistoryObjc * _Nullable history, NSError * _Nullable error) { }];`
| Get Link Share Processing Point | Get Link Share processing point | `[RakutenReward.shared getLSProcessingPointWithRequestData:request completion:^(LinkShareProcessingPointObjc * _Nullable point, NSError * _Nullable error) { }];`
| Log In | Open Log In page | `[RakutenReward.shared openLoginPage:^(enum LoginPageCompletion completion) { }];`
| Check Log In | Check if user is logged in with internal system (token not expired) | `[RakutenReward.shared isLogin];`
| Log Out | Log out from Rakuten Auth | `[RakutenReward.shared logoutWithCompletion:^{ }];`
| App Code | Get current application code (read-only) | `RakutenReward.shared.appCode;`
| Access Token | Get current access token (read-only) | `RakutenReward.shared.accessToken;`
| Mission List | Get current cached mission list (read-only) | `RakutenReward.shared.missionList;`
| Environment | Get or set SDK environment (.staging or .production) | `RakutenReward.shared.environment;`
| Token Type | Get or set token type (.rae, .rid, .rakutenAuth) | `RakutenReward.shared.tokenType;`
| Region | Get or set SDK region (.japan) | `RakutenReward.shared.region;`
| Blacklisted URLs | Add blacklist URL to block access specific URL | `RakutenReward.shared.blacklistURL;`
| Custom URL Session | To use custom URL session instead of default URL session | `RakutenReward.shared.customURLSession;`
| User updated delegate | Callback when user is updated | `RakutenReward.shared.didUpdateUserObjc = ^(SDKUserObject * _Nullable user) { };`
| User updated notification | Notification posted when user is updated | `RakutenReward.userUpdatedNotification;`
| Status updated delegate | Callback when Reward Status is updated | `RakutenReward.shared.didUpdateStatus = ^(enum RakutenRewardStatus status) { };`
| User achieved mission delegate | Callback when user has achieved a mission | `RakutenReward.shared.didUpdateUnclaimedAchievementObjc = ^(UnclaimedItemObject * _Nonnull unclaimedItem) { };`
| Is Portal Present status updated delegate | Callback when portal is present or hidden | `RakutenReward.shared.didUpdateIsPortalPresentedStatus = ^(BOOL isPortalPresent) { };`
| Request for user consent | Request User Consent (Since v5.0) | `[RakutenReward.shared requestForConsent:^(enum RakutenRewardConsentStatus status) { }];`
| Show user consent notification banner | Show consent banner (Since v6.3.0) | `[RakutenReward.shared showConsentBanner:^(enum RakutenRewardConsentStatus status) { }];`
| Did present consent UI | Callback when user consent UI is presented | `RakutenReward.shared.didPresentConsentUI = ^() { };`
| Did dismiss consent UI | Callback when user consent UI is dismissed | `RakutenReward.shared.didDismissConsentUI = ^() { };`
<br>

## RakutenRewardConfiguration
---
RakutenRewardConfiguration is user setting class.

| API Name | Description | Example
| --- | --- | ---
| Get Optout | Get Optout status <br>true : Optout (Reward SDK function does not work) | `RewardConfiguration.isUserOptingOut;`
| Set Optout | Set Optout status | `RewardConfiguration.isUserOptingOut = false;`
| UI Enabled |  Get whether Notification UI is enabled or not | `RewardConfiguration.isUserSettingUIEnabled;`
| Set UI Enabled | Set whether Notification UI is enabled or not | `RewardConfiguration.isUserSettingUIEnabled = true;`
| Enable Logging | Set value to true to receive additional Debug log info | `RewardConfiguration.isDebug = true;`
| Rz Cookie | Set value for the Rz cookie | `RewardConfiguration.rzCookie = @"example";`
| Rp Cookie | Set value for the Rp cookie | `RewardConfiguration.rpCookie = @"example";`
| Ra Cookie | Set value for the Ra cookie | `RewardConfiguration.raCookie = @"example";`
| Is Portal Present |  Get whether Portal is currently showing or not | `RewardConfiguration.isPortalPresent;`
| Is MissionEventFeatureEnabled | Get and set MissionEvent feature status | `RewardConfiguration.isMissionEventFeatureEnabled = true;`
| Is MissionFeaturedEnabled | Get and set Mission Featured feature status | `RewardConfiguration.isMissionFeaturedEnabled = true;`
| Is Ichiba App | Get and set whether app is Ichiba app | `RewardConfiguration.isIchibaApp = true;`
| Is Using SDK Portal | Set whether app using SDK Portal or not | `RewardConfiguration.isUsingSDKPortal = true;`
| Get Theme | Get current app theme | `[RewardConfiguration getTheme];`
| Set Theme | Set app theme (simple or panda) | `[RewardConfiguration setTheme:AppThemePanda];`
| Set Custom Domain | This setting is for setting custom domain for Staging | `[RewardConfiguration setCustomDomain:@"stg.test.com"];`
| Set Custom Path | This setting is for setting custom path for Staging | `[RewardConfiguration setCustomPath:@"/testpath/test/"];`
| Set App Language | Set in app language manually. SDK supported language value are 'ja', 'en', 'ko', 'zh-hans', 'zh-hant'. Set empty string value to use language from device settings. Unsupported value will be defaulted to 'ja' | `[RewardConfiguration setAppLanguage:@"en"];`
<br>

## Mission Token Provider
---
**Note:** MissionTokenProvider is a Swift-only protocol using async/await. It is not directly available in Objective-C. For Objective-C projects, continue using the existing `startSession` methods with access tokens.

For more information about the new token provider pattern, please refer to the [Swift API Reference](../../APIReference/README.md#mission-token-provider).

### Objective-C Usage
Continue using the current startSession methods:

```objective-c
// For RID or RAE token types
[RakutenReward.shared startSessionWithAppCode:@"your_app_code"
                                   accessToken:@"your_access_token"
                                     tokenType:TokenTypeRid
                                    completion:^(Result<SDKUser *, RewardSDKSessionError *> * result) {
    if (result.success) {
        // Session started successfully
    } else {
        // Handle error
    }
}];
```

<br>

## Open Reward Web page
---
SDK provide page open with API

```objective-c
// Support page types
SupportPagePrivacyPolicy;
SupportPageTermsCondition;
SupportPageHelp;
SupportPageSpsPrivacyPolicy;
SupportPageSpsTermsCondition;

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
| signIn | Whether the user is signed in or not
| unclaimedMissionCount | Number of unclaimed missions
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
| RakutenRewardStatusUserNotConsent | User has not agree with RakutenReward terms of service and privacy policy agreement
<br>

## RakutenRewardConsentStatus
---

| RakutenRewardConsentStatus | Description |
| --- | --- |
| RakutenRewardConsentStatusConsentProvided | User already provided consent |
| RakutenRewardConsentStatusConsentNotProvided | User has not provided consent |
| RakutenRewardConsentStatusConsentUIAlreadyPresented | Consent UI is already being presented |
| RakutenRewardConsentStatusConsentFailed | There is some error with API request |
| RakutenRewardConsentStatusConsentProvidedRestartSessionFailed | User provided consent but failed to restart SDK session |
<br>

## TokenType
---

| TokenType | Description |
| --- | --- |
| TokenTypeRae | RAE token type (deprecated) |
| TokenTypeRid | RID token type |
| TokenTypeRakutenAuth | Rakuten Auth token type (SDK provided login) |
<br>

## RakutenRewardRegion
---

| RakutenRewardRegion | Description |
| --- | --- |
| RakutenRewardRegionJapan | Japan region |
<br>

## SDKEnvironment
---

| SDKEnvironment | Description |
| --- | --- |
| SDKEnvironmentStaging | Staging environment (for internal use only) |
| SDKEnvironmentProduction | Production environment |
<br>

## LoginPageCompletion
---

| LoginPageCompletion | Description |
| --- | --- |
| LoginPageCompletionFailToShowLoginPage | Failed to show login page |
| LoginPageCompletionDismissByUser | User dismissed the login page |
| LoginPageCompletionLogInCompleted | User completed login successfully |
<br>

## PointClaimScreenEvent
---

| PointClaimScreenEventObjc | Description |
| --- | --- |
| PointClaimScreenEventObjcWillPresent | Claim screen will be presented |
| PointClaimScreenEventObjcDidFailToShow | Failed to show claim screen |
| PointClaimScreenEventObjcDidDismiss | Claim screen was dismissed |
| PointClaimScreenEventObjcDidSelfDismiss | Claim screen dismissed itself |
| PointClaimScreenEventObjcDidDismissByUser | User dismissed the claim screen |
| PointClaimScreenEventObjcDidFailToClaim | Failed to claim points |
| PointClaimScreenEventObjcDidClaimSuccessfully | Successfully claimed points |
| PointClaimScreenEventObjcDidTriggerIchibaDeeplink | Triggered Ichiba deeplink |
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
| condition | Description about mission max achievable | 10 times achievable
| notificationtype | Mission UI Type | NONE, BANNER, MODAL, CUSTOM, BANNER_50, BANNER_250
| point | Mission Point | 10
| enddatestr | Mission End Date <br> Daily : Today<br> Weekly : End of week<br> Monthly : End of Month<br> Custom : Custom End Date<br> | 20190403
| till | Mission End date | 3 days
| additional | Additional messages |
| reachedCap | Whether mission reached max cap or not | true
| times | Required action times | 3
| progress | Current action times | 1
| unclaimed | Number of unclaimed achievements | 2
| achieveddatestr | Mission achievement date | 2024-01-01
| getAchievedDate | Get achievement date in Date format |
<br>

### MissionLite
```objective-c
MissionLiteObject *mission = [MissionLiteObject alloc]; // Example
```

| Parameter | Description | Example
| --- | --- | ---
| name | Mission name | Mission A
| actionCode | Mission Action Key | ZIJCjBeQBHac8nJa
| iconurl | Mission icon URL | https://mprewardsdk.blob.core.windows.net/sdk-portal/appCode/actionCode.png
| instruction | Mission instruction | One day one play
| condition | Description about mission max achievable | 10 times achievable
| notificationtype | Mission UI Type | NONE, BANNER, MODAL, CUSTOM, BANNER_50, BANNER_250
| point | Mission Point | 10
| enddatestr | Mission End Date <br> Daily : Today<br> Weekly : End of week<br> Monthly : End of Month<br> Custom : Custom End Date<br> | 20190403
| till | Mission End date | 3 days
| additional | Additional messages |
| times | Required action times | 3
<br>

### PointHistory

| Method | Description | Example
| --- | --- | ---
| getPointHistory | Get a list of point history | `[RakutenReward.shared getPointHistoryObjcWithCompletion:^(PointHistoryObject * _Nullable pointHistory, NSError * _Nullable error) { }];`
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
| name | Mission name
| iconurl | Mission icon URL
| instruction | Mission Instruction
| actionCode | Mission Action Code
| notificationtype | Mission UI Type
| point | Total points to claim
| pointsPerClaim | Points per each claim (for multiple claims)
| unclaimedTimes | Number of unclaimed achievements
| achieveddatestr | Mission Achievement Date
| getAchievedDate | Get achievement date in "yyyy/MM/dd" format
<br>

### MemberPointRank
```objective-c
MemberPointRankObject *memberPointRank = [MemberPointRankObject alloc]; // Example
```
| Parameter | Description
| --- | ---
| memberPoints | User's total Rakuten member points
| memberRank | User's Rakuten member rank
<br>

### RewardRedeemRequest
```objective-c
RewardRedeemRequest *request = [[RewardRedeemRequest alloc] initWithTenantId:@"tenantId" appName:@"appName"]; // Example
```
| Parameter | Description
| --- | ---
| tenantId | Tenant ID for Link Share rewards
| appName | Application name for Link Share rewards
<br>

### LinkShareItemPointHistory
```objective-c
LinkShareItemPointHistoryObjc *history; // Returned from API
```
| Parameter | Description
| --- | ---
| total | Total number of point history records
| offset | Offset for pagination
| limit | Limit for pagination
| history | Array of LinkShareItemPointObjc objects
<br>

#### LinkShareItemPoint
```objective-c
LinkShareItemPointObjc *itemPoint; // Part of LinkShareItemPointHistory
```
| Parameter | Description
| --- | ---
| point | Point value
| isPointGranted | Whether the point has been granted
| advertiser | Advertiser name
| grantDate | Date when points will be/were granted (yyyy-MM-dd)
| transactionDate | Transaction date (yyyy-MM-dd)
| orderId | Order ID
| advertiserId | Advertiser ID
<br>

### LinkShareProcessingPoint
```objective-c
LinkShareProcessingPointObjc *processingPoint; // Returned from API
```
| Parameter | Description
| --- | ---
| count | Total processing points
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
| RPGRequestErrorObjcServerError | Server error
| RPGRequestErrorObjcBadRequest | Bad request
| RPGRequestErrorObjcLegalReason | Error because of legal reason (for example, user has not consent to RewardSDK's terms and condition)
<br>

### SDKError

| Name | Description
| --- | ---
| SDKErrorObjcNoMissionFound | Mission list is empty
| SDKErrorObjcMissionReachedCap | When a mission achievement is already reached its cap
| SDKErrorObjcNoUnclaimedItemFound | UnclaimedItem list is empty
| SDKErrorObjcSessionNotInitialized | SDK is not initialized
| SDKErrorObjcFeatureDisabledByUser | SDK function is not active by user
| SDKErrorObjcSDKStatusNotOnline | SDK status is not online
| SDKErrorObjcSDKStatusUserNotConsent | SDK status - user has not consent to RewardSDK's terms and condition
| SDKErrorObjcCheckIsSpsUserError | Error checking if user is SPS user
| SDKErrorObjcUnexpectedError | Unexpected error occurred
| SDKErrorObjcSpsFeatureIsDisabled | SPS feature is disabled
| SDKErrorObjcSpsRegisterUserDidNotFinish | SPS user registration did not finish
| SDKErrorObjcSpsRegisterUserError | Error during SPS user registration
| SDKErrorObjcOnMaintenanceMode | SDK is in maintenance mode
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

## Set Rakuten Cookie
---
This function can be used from SDK v2.2.0 This function is mainly for Rakuten App and use cookies which app keeps in App
If you use default login option(TokenTypeRakutenAuth), cookie is set by SDK.
If you use other options, can override cookie using this API

Set Rp cookie
```objective-c
RewardConfiguration.rpCookie = @"example";
```

Set Rz cookie
```objective-c
RewardConfiguration.rzCookie = @"example";
```

Set Ra cookie (version 5.1.0)
```objective-c
RewardConfiguration.raCookie = @"example";
```

<br>

## Event Analytics
---
This function can be used from SDK v3.3.0<br>
```objc
[RakutenMissionEvent.shared logActionWithEventCode:@"exampleEventCode" eventTrackingType: RakutenMissionEventTrackingTypeGenericEvent parameters:NULL completionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
        // Error
        return;
    }

    // Success
}];
```

### Parameters
| Status | Summary |
| --- | --- |
| eventCode | Analytics SDK event code |
| eventTrackingType | RakutenMissionEventTrackingType / Analytics SDK tracking type |
| parameters (optional) | Analytics SDK parameters |

### Enum RakutenMissionEventTrackingType
| Type | Summary |
| --- | --- |
| RakutenMissionEventTrackingTypeGenericEvent | tracking generic event |
| RakutenMissionEventTrackingTypeRatSpecificEvent | tracking Analytics SDK specific event |

<br>


## How to create custom mission UI
---
When the user achieves a mission, this callback is invoked

```objective-c
@property (nonatomic, copy) void (^ _Nullable didUpdateUnclaimedAchievementObjc)(UnclaimedItemObject * _Nonnull);
```

Example of showing custom UI

Note: Currently SDK doesn't support showing notifications inside Portal. Therefore, developers need to check RewardConfiguration.isPortalPresent API and only show Notification UI if Portal is not showing. This API is available from version 2.3.0

```objective-c
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = ^(UnclaimedItemObject * _Nonnull unclaimedItem) {
    if ([unclaimedItem.notificationType isKindOfClass:[NotificationTypeObjcCUSTOM class]] && // Check notification type
        RewardConfiguration.isUserSettingUIEnabled && // Check if user enable the UI setting or not
        !RewardConfiguration.isPortalPresent) { // Check if Portal is currently showing, not support for showing notification inside Portal.

        // Show Custom UI in Main thread
    }
};
```
Example for claim points
```objective-c
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = ^(UnclaimedItemObject * _Nonnull unclaimedItem) {
    [RakutenReward.shared claimObjcWithUnclaimedItemObject:unclaimedItem completion:^(PointClaimScreenEventObjc * _Nonnull pointClaimScreenEvent) {
        if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcWillPresent class]]) {
            // Claim screen will be presented
        }
        else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidFailToShow class]]) {
            // Failed to show claim screen
        }
        else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidDismiss class]]) {
            // Claim screen was dismissed
        }
        else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidSelfDismiss class]]) {
            // Claim screen dismissed itself
        }
        else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidDismissByUser class]]) {
            // User dismissed the claim screen
        }
        else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidFailToClaim class]]) {
            // Failed to claim points
        }
        else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidClaimSuccessfully class]]) {
            // Successfully claimed points
        }
        else if ([pointClaimScreenEvent isKindOfClass:[PointClaimScreenEventObjcDidTriggerIchibaDeeplink class]]) {
            // Triggered Ichiba deeplink
        }
    }];
};
```

You can also use the extended claim API to enable Ichiba deeplink callback:
```objective-c
[RakutenReward.shared claimObjcWithUnclaimedItemObject:unclaimedItem enableIchibaCallback:YES completion:^(PointClaimScreenEventObjc * _Nonnull pointClaimScreenEvent) {
    // Handle point claim screen events
}];
```
<br>

---
LANGUAGE :
> [![ja](../../lang/ja.png)](../ja/APIReference/README.md)
