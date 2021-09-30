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
* [Set Rakuten Cookie](#set-rakuten-cookie)<br>
* [How to create custom mission UI](#how-to-create-custom-mission-ui)<br><br>

# API Reference

## RakutenReward
---
RakutenReward class is to provide main settings and main functions of Reward SDK  

| API Name | Description | Example
| --- | --- | ---
| Get version |  Get Rakuten Reward SDK Version | `RakutenReward.shared.getVersion()`
| Open SDK Portal | For detail, please check sample application implementation | `RakutenReward.shared.openPortal(completionHandler: {r in})`
| Open Help Page | Open Reward SDK Help page with mini browser | `RakutenReward.shared.openSupportPage(.Help)`
| Open Terms and Condition Page | Open Reward SDK Terms and Conditions Page with mini browser | `RakutenReward.shared.openSupportPage(.TermsCondition)`
| Open Privacy Policy Page | Open Reward SDK Privacy Policy Page with mini browser | `RakutenReward.shared.openSupportPage(.PrivacyPoilicy)`
| Get Missions | Get missions | `RakutenReward.shared.getMissionListWithProgress(completion: { r in })`
| Get Point history | Get 3 month user's point history | `RakutenReward.shared.getPointHistory(completion: { r in })`
| Log Action | Post user action | `RakutenReward.shared.logAction(actionCode: "xxxxxx", completionHandler: { r in})`
| Get Unclaimed Items | Get Unclaim item list | `RakutenReward.shared.getUnclaimedMission({ completion: { r in })`
| Get Dynamic API last failed info | Get last failed API info(paremeter) | `RakutenReward.shared.retryLastFailedFunctionByNewToken`
| Get Point & Rank | Load latest point & rank from server | `RakutenReward.shared.loadMemberInfoRank({_ in })` |
| Log In | Open Log In page | `RakutenReward.shared.openLoginPage({_ in })` |
| Check Log In | Check if user is logged in with internal system (token not expired) | `RakutenReward.shared.isLogin()` |
| Log Out | Log out from Rakuten Auth | `RakutenReward.shared.logout { }` |
| Blacklisted URLs | Add blacklist URL to block access specific URL, (This is for Apple Reject, if the ad URL has problem, use this API) | `RakutenReward.shared.blacklistURLs` |
| Custom URL Session | To use custom URL session instead of default URL session | `RakutenReward.shared.customURLSession` |
| IDFA | To set IDFA | `RakutenReward.shared.advertisingID` |
| User updated delegate | Callback when user is updated | `RakutenReward.shared.didUpdateUser = { user in }` |
| Status updated delegate | Callback when Reward Status is updated | `RakutenReward.shared.didUpdateStatus = { status in }` |
<br>

## RakutenRewardConfiguration
---
RakutenRewardConfiguration is user setting class.

| API Name | Description | Example 
| --- | --- | ---
| Get Optout | Get Optout status <br>true : Optout (Reward SDK function does not work) | RewardConfiguration.isUserOptingOut
| Set Optout | Set Optout status | RewardConfiguration.isUserOptingOut = false
| UI Enabled |  Get whether Notification UI is enabled or not | RewardConfiguration.isUserSettingUIEnabled
| Set UI Enabled | Set whether Notification UI is enabled or not | RewardConfiguration.isUserSettingUIEnabled = true
| Enable Logging | Set value to true to receive additional Debug log info | RewardConfiguration.isDebug = true
| Rz Cookie | Set value for the Rz cookie | RewardConfiguration.rzCookie = "example"
| Rp Cookie | Set value for the Rp cookie | RewardConfiguration.rpCookie = "example"
| Action History Enabled | Set whether want to save action code in case LogAction failed | RewardConfiguration.actionHistoryEnabled = true
| Is Portal Present |  Get whether Portal is currently showing or not | RewardConfiguration.isPortalPresent
<br>

## Open Reward Web page
---
SDK provide page open with API

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
SDKUser : User class

```swift
RakutenReward.shared.user
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
RakutenRewardStatus is Reward SDK staus  

| Parameter | Description
| --- | ---
| .Online | Finished SDK initialization(Update User info correctly)
| .Offline | Not finished SDK initialization or initialization failed
| .AppcodeInvalid | Wrong Application Code
| .TokenExpired | Expired Token. If `tokenType` is `RakutenAuth`, `.TokenExpired` means user should log in again
<br>

### Checking the status
```swift
let status = RakutenReward.shared.status
```
<br>

## API Data
---
<br>

### Mission
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
| getPointHistory | Get a list of point history | RakutenReward.shared.getPointHistory { (result) in }
<br>

#### PointRecord

| Parameter | Description
| --- | --- 
| point | Point
| month | Point Date(Month)
<br>

### UnclaimedItem
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
| userNotFound | Failed startSession
| appcodeInvalid | SDK status is APPCODEINVALID
| bundleError | Parameters are wrong
| loginRequired | (internal log-in only) start session or use API before log in 
| invalidTokenType | (internal log-in only) Token type is not valid
| cannotRetrieveSessionToken | (internal log-in only) failed to get token to use APIs, please start session again
| cannotLogOutOnServer | (internal log-in only) failed to log out
<br>

### RPGRequestError  

| Name | Description
| --- | ---
| tokenExpire | Access token is expired
| serverError | Cannot connect
<br>

### SDKError  

| Name | Description
| --- | ---
| NoMissionFound | Mission list is empty
| NoUnclaimedItemFound | UnclaimedItem list is empty
| SessionNotInitialized | SDK is not initialized
| FeatureDisabledByUser | SDK function is not active by user
| SDKStatusNotOnline | SDK status is not online
<br>

## Get current user action status
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
This configuration is only for TW region.
```swift
RakutenRewardAdConfiguration.shared
```
| Property Name | Description | Example 
| --- | --- | ---
| bcat | Blocked advertiser categories using the IAB content | RakutenRewardAdConfiguration.shared.bcat
| badv | Block list of advertisers by their domains | RakutenRewardAdConfiguration.shared.badv
| appDomain |  Domain of the app | RakutenRewardAdConfiguration.shared.appDomain
| storeUrl | App store URL | RakutenRewardAdConfiguration.shared.storeUrl
| privacyPolicy | Indicates if the app has a privacy policy, where 0 = no, 1 = yes | RakutenRewardAdConfiguration.shared.privacyPolicy
| paid | Indicates if the app is free or paid, where 0 = free, 1 = paid | RakutenRewardAdConfiguration.shared.paid
| keywords | Keywords about the app | RakutenRewardAdConfiguration.shared.keywords
| test | To enable Ads testing. Set to true if debug only. | RakutenRewardAdConfiguration.shared.test
<br>

| Method | Description | Example 
| --- | --- | ---
| addBlockCategory | Append block category string to bcat array<br>Format: IAB(Number)-(Number).| addBlockCategory(str: "IAB7-17")
| addBlockDomain | Append domain string to badv array. | addBlockCategory(str: "www.example.com")
| addKeywords | Append keyword string to keywords array. | addKeywords(str: "productivity")
<br>

## Set Rakuten Cookie
---
This function can be used from SDK v2.2.0 This function is mainly for Rakuten App and use cookies which app keeps in App
If you use default login option(TokenType.RakutenAuth), cookie is set by SDK.
If you use other options, can override cookie using this API

Set Rp cookie
```swift
RewardConfiguration.rpCookie = "example"
```

Set Rz cookie
```swift
RewardConfiguration.rzCookie = "example"
```

<br>

## How to create custom mission UI
---
When the user achieves a mission, this callback is invoked

```swift
// From RakutenReward class
public var didUpdateUnclaimedAchievement: ((UnclaimedItem) -> Void)?
  
// Example
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in }
```

Example of showing custom UI

Note: Currently SDK doesn't support showing notifications inside Portal. Therefore, developers need to check RewardConfiguration.isPortalPresent API and only show Notification UI if Portal is not showing. This API is available from version 2.3.0

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

Example for claim points
```swift
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in
    RakutenReward.shared.claim(unclaimedItem: unclaimedItem, completion: { pointClaimScreenEvent in }
}
```

<br>

---
LANGUAGE :
> [![ja](../lang/ja.png)](../ja/APIReference/README.md)
