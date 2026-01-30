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
  * [LinkShareItemPointHistory](#linkshareitempointh istory)<br>
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
| Get version |  Get Rakuten Reward SDK Version | `RakutenReward.shared.getVersion()`
| Initialize SDK for Third Party | Initialize SDK with app code for third party login | `RakutenReward.shared.initSdkThirdParty(appCode: "your_app_code")`
| Initialize SDK | Initialize SDK with app code, token type and token provider | `RakutenReward.shared.initSdk(appCode: "your_app_code", tokenType: .rid, tokenProvider: yourTokenProvider)`
| Start Session (New) | Start session with token provider | `RakutenReward.shared.startSession(appCode: "your_app_code", tokenType: .rid, tokenProvider: yourTokenProvider, completion: { r in })`
| Start Session (Deprecated) | Start session with access token (deprecated, use token provider instead) | `RakutenReward.shared.startSession(appCode: "your_app_code", accessToken: "token", tokenType: .rid, completion: { r in })`
| Open SDK Portal | Open SDK Portal | `RakutenReward.shared.openPortal(completionHandler: { r in })`
| Open SPS Portal | Open SPS Portal with Rz cookie | `RakutenReward.shared.openSpsPortal(rzCookie: "cookie", completionHandler: { r in })`
| Open Help Page | Open Reward SDK Help page with mini browser | `RakutenReward.shared.openSupportPage(.help)`
| Open Terms and Condition Page | Open Reward SDK Terms and Conditions Page with mini browser | `RakutenReward.shared.openSupportPage(.termsCondition)`
| Open Privacy Policy Page | Open Reward SDK Privacy Policy Page with mini browser | `RakutenReward.shared.openSupportPage(.privacyPolicy)`
| Open SPS Terms and Condition Page | Open SPS Terms and Conditions Page with mini browser | `RakutenReward.shared.openSupportPage(.spsTermsCondition)`
| Open SPS Privacy Policy Page | Open SPS Privacy Policy Page with mini browser | `RakutenReward.shared.openSupportPage(.spsPrivacyPolicy)`
| Get Missions | Get missions | `RakutenReward.shared.getMissionListWithProgress(completion: { r in })`
| Get Missions Lite | Get missions lite (without progress and reachedCap) | `RakutenReward.shared.getMissionLiteList(completion: { r in })`
| Get Mission Details | Get details for a specific mission by action code | `RakutenReward.shared.getMissionDetails(actionCode: "actionCode", completion: { r in })`
| Get Point history | Get 3 month user's point history | `RakutenReward.shared.getPointHistory(completion: { r in })`
| Log Action | Post user action | `RakutenReward.shared.logAction(actionCode: "xxxxxx", completionHandler: { r in })`
| Get Unclaimed Items | Get Unclaim item list | `RakutenReward.shared.getUnclaimedMission(completion: { r in })`
| Claim Mission | Claim unclaimed mission points | `RakutenReward.shared.claim(unclaimedItem: item, completion: { event in })`
| Claim Mission with Ichiba callback | Claim unclaimed mission points with Ichiba deeplink support | `RakutenReward.shared.claim(unclaimedItem: item, enableIchibaCallback: true, completion: { event in })`
| Get Point & Rank | Load latest point & rank from server | `RakutenReward.shared.loadMemberInfoRank({ r in })` |
| Get Link Share Point History | Get Link Share item point history | `RakutenReward.shared.getLSPointHistory(requestData: request, offset: 0, limit: 20, completion: { r in })`
| Get Link Share Processing Point | Get Link Share processing point | `RakutenReward.shared.getLSProcessingPoint(requestData: request, completion: { r in })`
| Log In | Open Log In page | `RakutenReward.shared.openLoginPage({ completion in })`
| Check Log In | Check if user is logged in with internal system (token not expired) | `RakutenReward.shared.isLogin()`
| Log Out | Log out from Rakuten Auth | `RakutenReward.shared.logout { }`
| App Code | Get current application code (read-only) | `RakutenReward.shared.appCode`
| Access Token | Get current access token (read-only) | `RakutenReward.shared.accessToken`
| Mission List | Get current cached mission list (read-only) | `RakutenReward.shared.missionList`
| Environment | Get or set SDK environment (.staging or .production) | `RakutenReward.shared.environment`
| Token Type | Get or set token type (.rae, .rid, .rakutenAuth) | `RakutenReward.shared.tokenType`
| Region | Get or set SDK region (.japan) | `RakutenReward.shared.region`
| Blacklisted URLs | Add blacklist URL to block access specific URL | `RakutenReward.shared.blacklistURLs`
| Custom URL Session | To use custom URL session instead of default URL session | `RakutenReward.shared.customURLSession`
| User updated delegate | Callback when user is updated | `RakutenReward.shared.didUpdateUser = { user in }`
| User updated notification | Notification posted when user is updated | `RakutenReward.userUpdatedNotification`
| Status updated delegate | Callback when Reward Status is updated | `RakutenReward.shared.didUpdateStatus = { status in }`
| User achieved mission delegate | Callback when user has achieved a mission | `RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in }`
| Is Portal present status updated delegate | Callback when portal is present or hidden | `RakutenReward.shared.didUpdateIsPortalPresentedStatus = { isPortalPresent in }`
| Request for user consent | Request User Consent (Since v5.0) | `RakutenReward.shared.requestForConsent { status in }`
| Show user consent notification banner | Show consent banner (Since v6.3.0) | `RakutenReward.shared.showConsentBanner { status in }`
| Did present consent UI | Callback when user consent UI is presented | `RakutenReward.shared.didPresentConsentUI = { }`
| Did dismiss consent UI | Callback when user consent UI is dismissed | `RakutenReward.shared.didDismissConsentUI = { }`
<br>

## RakutenRewardConfiguration
---
RakutenRewardConfiguration is user setting class.

| API Name | Description | Example
| --- | --- | ---
| Get Optout | Get Optout status <br>true : Optout (Reward SDK function does not work) | `RewardConfiguration.isUserOptingOut`
| Set Optout | Set Optout status | `RewardConfiguration.isUserOptingOut = false`
| UI Enabled |  Get whether Notification UI is enabled or not | `RewardConfiguration.isUserSettingUIEnabled`
| Set UI Enabled | Set whether Notification UI is enabled or not | `RewardConfiguration.isUserSettingUIEnabled = true`
| Enable Logging | Set value to true to receive additional Debug log info | `RewardConfiguration.isDebug = true`
| Rz Cookie | Set value for the Rz cookie | `RewardConfiguration.rzCookie = "example"`
| Rp Cookie | Set value for the Rp cookie | `RewardConfiguration.rpCookie = "example"`
| Ra Cookie | Set value for the Ra cookie | `RewardConfiguration.raCookie = "example"`
| Is Portal Present |  Get whether Portal is currently showing or not | `RewardConfiguration.isPortalPresent`
| Is MissionEventFeatureEnabled | Get and set MissionEvent feature status | `RewardConfiguration.isMissionEventFeatureEnabled = true`
| Is MissionFeaturedEnabled | Get and set Mission Featured feature status | `RewardConfiguration.isMissionFeaturedEnabled = true`
| Is Ichiba App | Get and set whether app is Ichiba app | `RewardConfiguration.isIchibaApp = true`
| Is Using SDK Portal | Set whether app using SDK Portal or not | `RewardConfiguration.isUsingSDKPortal = true`
| Get Theme | Get current app theme | `RewardConfiguration.getTheme()`
| Set Theme | Set app theme (simple or panda) | `RewardConfiguration.setTheme(.panda)`
| Set Custom Domain | This setting is for setting custom domain for Staging | `RewardConfiguration.setCustomDomain("stg.test.com")`
| Set Custom Path | This setting is for setting custom path for Staging | `RewardConfiguration.setCustomPath("/testPath/test/")`
| Set App Language | Set in app language manually. SDK supported language value are 'ja', 'en', 'ko', 'zh-hans', 'zh-hant'. Set empty string value to use language from device settings. Unsupported value will be defaulted to 'ja' | `RewardConfiguration.setAppLanguage("en")`
<br>

## Mission Token Provider
---
MissionTokenProvider is a protocol for managing access tokens. Implement this protocol to provide custom token management for RID/RAE authentication.

```swift
public protocol MissionTokenProvider {
    func getAccessToken() async throws -> String
}
```

### Usage Example
Create a custom token provider by implementing the protocol:

```swift
class MyTokenProvider: MissionTokenProvider {
    func getAccessToken() async throws -> String {
        // Your token fetching logic here
        // This could fetch from your auth service, refresh if expired, etc.
        return "your_access_token"
    }
}

// Initialize SDK with token provider
let tokenProvider = MyTokenProvider()
RakutenReward.shared.initSdk(
    appCode: "your_app_code",
    tokenType: .rid,
    tokenProvider: tokenProvider
)
```
<br>

## Open Reward Web page
---
SDK provide page open with API

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
SDKUser : User class

```swift
RakutenReward.shared.user
```

| Parameter | Description
| --- | ---
| signIn | Whether the user is signed in or not
| unclaimedMissionCount | Number of unclaimed missions
| point | Reward SDK Point
| currentPointRank() | Get `MemberPointRank`; member points and rank, persistent & loaded separately
| getName() | Get user's username
<br>

## RakutenRewardStatus
---
RakutenRewardStatus is Reward SDK status  

| Parameter | Description
| --- | ---
| .online | Finished SDK initialization(Update User info correctly)
| .offline | Not finished SDK initialization or initialization failed
| .appcodeInvalid | Wrong Application Code
| .tokenExpired | Expired Token. If `tokenType` is `RakutenAuth`, `.TokenExpired` means user should log in again
| .userNotConsent | User has not agree with RakutenReward terms of service and privacy policy agreement

<br>

## RakutenRewardConsentStatus
---

| RakutenRewardConsentStatus | Description |
| --- | --- |
| consentProvided | User already provided consent |
| consentNotProvided | User has not provided consent |
| consentUIAlreadyPresented | Consent UI is already being presented |
| consentFailed | There is some error with API request |
| consentProvidedRestartSessionFailed | User provided consent but failed to restart SDK session |
<br>

## TokenType
---

| TokenType | Description |
| --- | --- |
| .rae | RAE token type (deprecated) |
| .rid | RID token type |
| .rakutenAuth | Rakuten Auth token type (SDK provided login) |
<br>

## RakutenRewardRegion
---

| RakutenRewardRegion | Description |
| --- | --- |
| .japan | Japan region |
<br>

## SDKEnvironment
---

| SDKEnvironment | Description |
| --- | --- |
| .staging | Staging environment (for internal use only) |
| .production | Production environment |
<br>

## LoginPageCompletion
---

| LoginPageCompletion | Description |
| --- | --- |
| failToShowLoginPage | Failed to show login page |
| dismissByUser | User dismissed the login page |
| logInCompleted | User completed login successfully |
<br>

## PointClaimScreenEvent
---

| PointClaimScreenEvent | Description |
| --- | --- |
| willPresent | Claim screen will be presented |
| didFailToShow(error: Error) | Failed to show claim screen |
| didDismiss | Claim screen was dismissed |
| didSelfDismiss | Claim screen dismissed itself |
| didDismissByUser | User dismissed the claim screen |
| didFailToClaim(error: Error) | Failed to claim points |
| didClaimSuccessfully(item: UnclaimedItem) | Successfully claimed points |
| didTriggerIchibaDeeplink(url: URL) | Triggered Ichiba deeplink |
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
| getAchievedDate() | Get achievement date in Date format |
<br>

### MissionLite
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
| name | Mission name
| iconurl | Mission icon URL
| instruction | Mission Instruction
| actionCode | Mission Action Code
| notificationtype | Mission UI Type
| point | Total points to claim
| pointsPerClaim | Points per each claim (for multiple claims)
| unclaimedTimes | Number of unclaimed achievements
| achieveddatestr | Mission Achievement Date
| getAchievedDate() | Get achievement date in "yyyy/MM/dd" format
<br>

### MemberPointRank
| Parameter | Description
| --- | ---
| memberPoints | User's total Rakuten member points
| memberRank | User's Rakuten member rank
<br>

### RewardRedeemRequest
| Parameter | Description
| --- | ---
| tenantId | Tenant ID for Link Share rewards
| appName | Application name for Link Share rewards
<br>

### LinkShareItemPointHistory
| Parameter | Description
| --- | ---
| total | Total number of point history records
| offset | Offset for pagination
| limit | Limit for pagination
| history | Array of LinkShareItemPoint objects
<br>

#### LinkShareItemPoint
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
| badRequest | Bad request
| unavailableForLegalReasons | Error because of legal reason (for example, user has not consent to RewardSDK's terms and condition)
<br>

### SDKError

| Name | Description
| --- | ---
| noMissionFound | Mission list is empty
| missionReachedCap | When a mission achievement is already reached its cap (v6.2.0 and newer)
| noUnclaimedItemFound | UnclaimedItem list is empty
| sessionNotInitialized | SDK is not initialized
| featureDisabledByUser | SDK function is not active by user
| sdkStatusNotOnline | SDK status is not online
| sdkStatusUserNotConsent | SDK status - user has not consent to RewardSDK's terms and condition
| checkIsSpsUserError | Error checking if user is SPS user
| unexpectedError(message: String) | Unexpected error occurred
| spsFeatureIsDisabled | SPS feature is disabled
| spsRegisterUserDidNotFinish | SPS user registration did not finish
| spsRegisterUserError | Error during SPS user registration
| onMaintenanceMode | SDK is in maintenance mode

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

Set Ra cookie (version 5.1.0)
```swift
RewardConfiguration.raCookie = "example"
```

<br>

## Event Analytics
---
This function can be used from SDK v3.3.0<br>
```swift
RakutenMissionEvent.shared.logAction(eventCode: "exampleEventCode", eventTrackingType: .ratSpecificEvent, parameters: nil) { error in
    if let error = error {
        // Error
        return
    }
    // Success
}
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
| genericEvent | tracking generic event |
| ratSpecificEvent | tracking Analytics SDK specific event |


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
    RakutenReward.shared.claim(unclaimedItem: unclaimedItem, completion: { pointClaimScreenEvent in
        switch pointClaimScreenEvent {
        case .willPresent:
            // Claim screen will be presented
        case .didFailToShow(let error):
            // Failed to show claim screen
        case .didDismiss:
            // Claim screen was dismissed
        case .didSelfDismiss:
            // Claim screen dismissed itself
        case .didDismissByUser:
            // User dismissed the claim screen
        case .didFailToClaim(let error):
            // Failed to claim points
        case .didClaimSuccessfully(let item):
            // Successfully claimed points
        case .didTriggerIchibaDeeplink(let url):
            // Triggered Ichiba deeplink
        }
    })
}
```

You can also use the extended claim API to enable Ichiba deeplink callback:
```swift
RakutenReward.shared.claim(unclaimedItem: unclaimedItem, enableIchibaCallback: true, completion: { pointClaimScreenEvent in
    // Handle point claim screen events
})
```

<br>

---
LANGUAGE :
> [![ja](../lang/ja.png)](../ja/APIReference/README.md)
