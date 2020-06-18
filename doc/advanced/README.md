[TOP](../../README.md#top)　> Advanced Guide

---
# Advanced Integration Guide
## RakutenReward
RakutenReward class is to provide main settings and main functions of Reward SDK  

| API Name | Description | Example
| --- | --- | ---
| Get version |  Get Rakuten Reward SDK Version | RakutenReward.shared.getVersion()
| Open SDK Portal | For detail, please check sample application implementation | RakutenReward.shared.openSDKPortal(completionHandler: {r in})
| Open Help Page | Open Reward SDK Help page with mini browser | RakutenReward.shared.openSupportPage(.Help)
| Open Terms and Condition Page | Open Reward SDK Terms and Conditions Page with mini browser | RakutenReward.shared.openSupportPage(.TermsCondition)
| Open Privacy Policy Page | Open Reward SDK Privacy Policy Page with mini browser | RakutenReward.shared.openSupportPage(.PrivacyPoilicy)
| Get Missions | Get missions | RakutenReward.shared.getMissionListWithProgress(completion: { r in })
| Get Point history | Get 3 month user's point history | RakutenReward.shared.getPointHistory(completion: { r in })
| Log Action | Post user action | RakutenReward.shared.logAction(actionCode: "xxxxxx", completionHandler: { r in})
| Get Unclaimed Items | Get Unclaim item list | RakutenReward.shared.getUnclaimedItems({ completion: { r in })
| Get Dynamic API last failed info | Get last failed API info(paremeter) | RakutenReward.shared.retryLastFailedFunctionByNewToken

## RakutenRewardConfiguration
RakutenRewardConfiguration is user setting class.

| API Name | Description | Example 
| --- | --- | ---
| Get Optout | Get Optout status <br>true : Optout (Reward SDK function does not work) | RakutenRewardConfiguration.isUserOptingOut
| Set Optout | Set Optout status | RakutenRewardConfiguration.isUserOptingOut = false
| UI Enabled |  Get whether Notification UI is enabled or not | RakutenRewardConfiguration.isUserSettingUIEnabled
| Set UI Enabled | Set whether Notification UI is enabled or not | RakutenRewardConfiguration.isUserSettingUIEnabled = true

## Open Reward Web page
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

## SDKUser
SDKUser : User class

| Parameter | Description
| --- | ---
| signIn | Whether the user is singin or not
| unclaimedMissionCount | Number of unclaim mission
| point | Reward SDK Point

### RakutenRewardStatus
RakutenRewardStatus is Reward SDK staus.
| Parameter | Description
| --- | ---
| .Online | Finished SDK initialization(Update User info correctly)
| .Offline | Not finished SDK initialization or initialization failed
| .AppcodeInvalid | Wrong Application Code
| .TokenExpired | Expired Token

#### Checking the status
```swift
let status = RakutenReward.shared.status
```

## Additional Configuration
### SDK Setting
Enable Logging: setting the following isDebug to true
```swift
RakutenConfiguration.isDebug = true
```
## API Data

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

### PointHistory

Point History

#### PointRecord

| Parameter | Description
| --- | --- 
| point | Point
| month | Point Date(Month)

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

## API Errors
RewardSDKSessionError

|  Name | Description
| --- | --- 
| userNotFound | Failed startSession
| appcodeInvalid | SDK status is APPCODEINVALID
| bundleError | Parameters are wrong

RPGRequestError
| Name | Description
| --- | ---
| tokenExpire | Access token is expired
| serverError | Cannot connect

SDKError
| Name | Description
| --- | ---
| SessionNotInitialized | SDK is not initialized
| FeatureDisabledByUser | SDK function is not active by user

## Get current user action status
```swift
RakutenReward.shared.getMissionListWithProgress(completion: {r in
                    switch r {
                    case .success(let mList): // mission List to display
		            case .failure(let err): // handling the error
		    }
}
```

## How to create custom mission UI
When the user achieved the mission, following callback is invoked

```swift
public var didUpdateUnclaimedAchievement: ((RakutenRewardNativeSDK.Mission) -> Void)?
```
Override this method and create UI under this

```swift
RakutenReward.shared.didUpdateUnclaimedAchievement = { m in
	guard m.notificationtype == .CUSTOM else { return }
	// show custom notification from here
	}
```
Claim 
```swift
RakutenReward.shared.claim(unclaimedItem: m, completion: nil)
```


---
LANGUAGE :
> [![ja](../lang/ja.png)](../ja/advanced/README.md)