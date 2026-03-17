# API Reference (Swift)

For the Objective-C API, see [Objective-C Guide](objective-c.md).

---

## RakutenReward

The main entry point for all SDK operations. Access via `RakutenReward.shared`.

### Initialization

| Method | Description |
|---|---|
| `initSdk(appCode:tokenType:tokenProvider:)` | Initialize with a `MissionTokenProvider` (v9 recommended) |
| `initSdkThirdParty(appCode:)` | Initialize for RakutenAuth (SDK-provided login) |
| `startSession(appCode:accessToken:tokenType:completion:)` | *(Deprecated)* Start session by passing a token directly |

### Authentication

| Method | Description |
|---|---|
| `openLoginPage(_:)` | Present the SDK-provided login page (RakutenAuth only) |
| `isLogin()` | Returns `true` if the user is logged in and the token is valid |
| `logout(_:)` | Log out and clear the session |

### Mission APIs

| Method | Description |
|---|---|
| `logAction(actionCode:completionHandler:)` | Record a user action toward a mission |
| `getMissionListWithProgress(completion:)` | Fetch missions with user progress and cap status |
| `getMissionLiteList(completion:)` | Fetch missions without progress (lightweight) |
| `getMissionDetails(actionCode:completion:)` | Fetch details for a single mission |
| `getUnclaimedMission(completion:)` | Fetch achievements awaiting point claim |
| `claim(unclaimedItem:completion:)` | Show the claim UI for an unclaimed achievement |
| `claim(unclaimedItem:enableIchibaCallback:completion:)` | Claim with Ichiba deeplink support |
| `missionList` | Synchronous cache of the last-fetched mission list |

### Points & User Data

| Method / Property | Description |
|---|---|
| `user` | The current `SDKUser` object (may be `nil` if offline) |
| `loadMemberInfoRank(_:)` | Reload member points and rank from the server |
| `getPointHistory(completion:)` | Fetch 3-month point history |
| `getLSPointHistory(requestData:offset:limit:completion:)` | Fetch Link Share item point history |
| `getLSProcessingPoint(requestData:completion:)` | Fetch Link Share processing point total |

### Portals

| Method | Description |
|---|---|
| `openPortal(completionHandler:)` | Open the SDK Portal |
| `openSpsPortal(rzCookie:completionHandler:)` | Open the SPS Portal (v8.5.0+) |
| `openSupportPage(_:)` | Open a help/legal page in the mini browser |

### User Consent

| Method | Description |
|---|---|
| `requestForConsent(_:)` | Request user consent (shows dialog if not yet provided) |
| `showConsentBanner(_:)` | Show consent notification banner |

### Callbacks & Notifications

| Property | Trigger |
|---|---|
| `didUpdateUser: ((SDKUser) -> Void)?` | Fires when user data is refreshed |
| `didUpdateStatus: ((RakutenRewardStatus) -> Void)?` | Fires when SDK status changes |
| `didUpdateUnclaimedAchievement: ((UnclaimedItem) -> Void)?` | Fires when a mission is achieved |
| `didUpdateIsPortalPresentedStatus: ((Bool) -> Void)?` | Fires when the portal is shown or hidden |
| `didPresentConsentUI: (() -> Void)?` | Fires when the consent dialog appears |
| `didDismissConsentUI: (() -> Void)?` | Fires when the consent dialog is dismissed |
| `RakutenReward.userUpdatedNotification` | `NotificationCenter` notification posted when user is updated |

### Properties

| Property | Description |
|---|---|
| `status` | Current `RakutenRewardStatus` |
| `appCode` | Application code (read-only after init) |
| `accessToken` | Current access token (read-only) |
| `tokenType` | Token type (`.rid`, `.rae`, `.rakutenAuth`) |
| `region` | SDK region (`.japan`) |
| `environment` | `.staging` or `.production` |
| `blacklistURLs` | URLs the SDK will not access |
| `customURLSession` | Override the SDK's URLSession |

---

## RakutenRewardConfiguration

Global SDK configuration. All properties are static.

| Property / Method | Description |
|---|---|
| `isUserOptingOut` | `true` = user has opted out; all SDK functions are disabled |
| `isUserSettingUIEnabled` | `true` = notification UI is enabled |
| `isDebug` | `true` = verbose debug logging |
| `rzCookie` | Rz cookie value |
| `rpCookie` | Rp cookie value |
| `raCookie` | Ra cookie value (v5.1.0+) |
| `isPortalPresent` | `true` if the portal is currently displayed (read-only) |
| `isMissionEventFeatureEnabled` | Enable/disable Event Analytics feature |
| `isMissionFeaturedEnabled` | Enable/disable Mission Featured section |
| `isIchibaApp` | Set `true` for Rakuten Ichiba applications |
| `isUsingSDKPortal` | Set `true` if your app uses the SDK Portal |
| `getTheme()` | Returns the current `AppTheme` |
| `setTheme(_:)` | Set theme (`.panda` or `.simple`) |
| `setCustomDomain(_:)` | Override API domain (staging only) |
| `setCustomPath(_:)` | Override API path (staging only) |
| `setAppLanguage(_:)` | Force a UI language (`"ja"`, `"en"`, `"ko"`, `"zh-hans"`, `"zh-hant"`, or `""` for device default) |

---

## MissionTokenProvider Protocol

```swift
public protocol MissionTokenProvider {
    func getAccessToken() async throws -> String
}
```

Implement this protocol to provide tokens for RID or RAE authentication. See [Authentication](authentication.md) for implementation guidance.

---

## SDKUser

Accessed via `RakutenReward.shared.user`.

| Property / Method | Description |
|---|---|
| `signIn` | `true` if the user is signed in |
| `point` | Reward SDK points balance |
| `unclaimedMissionCount` | Number of unclaimed achievements |
| `getName()` | User's display name |
| `currentPointRank()` | Returns `MemberPointRank` with member points and rank |

---

## Enumerations

### RakutenRewardStatus

| Case | Description |
|---|---|
| `.online` | SDK ready; user data up to date |
| `.offline` | SDK not initialized or initialization failed |
| `.appcodeInvalid` | Wrong application code |
| `.tokenExpired` | Token expired (RakutenAuth: re-login required) |
| `.userNotConsent` | User has not accepted the terms of service |

### RakutenRewardConsentStatus

| Case | Description |
|---|---|
| `.consentProvided` | Consent has been given |
| `.consentNotProvided` | Consent has not been given |
| `.consentUIAlreadyPresented` | Consent UI is already on screen |
| `.consentFailed` | API error during consent check |
| `.consentProvidedRestartSessionFailed` | Consent given but session restart failed |

### TokenType

| Case | Description |
|---|---|
| `.rid` | Rakuten ID SDK token |
| `.rae` | Rakuten User SDK token *(deprecated)* |
| `.rakutenAuth` | SDK-provided login token |

### RakutenRewardRegion

| Case | Description |
|---|---|
| `.japan` | Japan |

### SDKEnvironment

| Case | Description |
|---|---|
| `.production` | Production (default) |
| `.staging` | Staging (internal use only) |

### LoginPageCompletion

| Case | Description |
|---|---|
| `.logInCompleted` | User successfully logged in |
| `.dismissByUser` | User dismissed the login page |
| `.failToShowLoginPage` | Could not present the login UI |

### SupportPage

| Case | Description |
|---|---|
| `.help` | Reward SDK help page |
| `.termsCondition` | Reward terms and conditions |
| `.privacyPolicy` | Reward privacy policy |
| `.spsTermsCondition` | SPS terms and conditions |
| `.spsPrivacyPolicy` | SPS privacy policy |

### PointClaimScreenEvent

| Case | Description |
|---|---|
| `.willPresent` | Claim screen is about to appear |
| `.didFailToShow(error:)` | Could not show the claim screen |
| `.didDismiss` | Claim screen was dismissed (any reason) |
| `.didSelfDismiss` | Claim screen auto-dismissed |
| `.didDismissByUser` | User manually dismissed the claim screen |
| `.didFailToClaim(error:)` | Point claim request failed |
| `.didClaimSuccessfully(item:)` | Points were claimed successfully |
| `.didTriggerIchibaDeeplink(url:)` | Ichiba deeplink was triggered |

---

## Data Models

### Mission

| Property | Type | Description |
|---|---|---|
| `name` | `String` | Mission name |
| `actionCode` | `String` | Action key |
| `iconurl` | `String` | Mission icon URL |
| `instruction` | `String` | Instructions for the user |
| `condition` | `String` | Achievement cap description |
| `notificationtype` | `NotificationType` | `NONE`, `BANNER`, `MODAL`, `CUSTOM`, `BANNER_50`, `BANNER_250` |
| `point` | `Int` | Points awarded |
| `enddatestr` | `String` | End date string |
| `till` | `String` | Days remaining |
| `additional` | `String?` | Additional message |
| `reachedCap` | `Bool` | Whether the achievement cap has been reached |
| `times` | `Int` | Required number of actions |
| `progress` | `Int` | Current action count |
| `unclaimed` | `Int` | Number of unclaimed achievements |
| `achieveddatestr` | `String?` | Achievement date string |
| `getAchievedDate()` | `Date?` | Achievement date as `Date` |

### MissionLite

A lightweight version of `Mission` without `progress` and `reachedCap`. Shares all other properties.

### UnclaimedItem

| Property | Type | Description |
|---|---|---|
| `name` | `String` | Mission name |
| `iconurl` | `String` | Mission icon URL |
| `instruction` | `String` | Mission instruction |
| `actionCode` | `String` | Mission action code |
| `notificationtype` | `NotificationType` | Notification type |
| `point` | `Int` | Total points to claim |
| `pointsPerClaim` | `Int` | Points per individual claim |
| `unclaimedTimes` | `Int` | Number of unclaimed achievements |
| `achieveddatestr` | `String` | Achievement date string |
| `getAchievedDate()` | `Date?` | Achievement date as `Date` (format: `yyyy/MM/dd`) |

### MemberPointRank

| Property | Type | Description |
|---|---|---|
| `memberPoints` | `Int` | User's total Rakuten member points |
| `memberRank` | `String` | User's Rakuten member rank |

### PointHistory / PointRecord

`PointHistory` wraps a list of `PointRecord` objects:

| `PointRecord` property | Description |
|---|---|
| `point` | Points earned |
| `month` | Month string |

### RewardRedeemRequest

Used with Link Share APIs:

| Property | Type | Description |
|---|---|---|
| `tenantId` | `String` | Tenant ID |
| `appName` | `String` | Application name |

### LinkShareItemPointHistory

| Property | Description |
|---|---|
| `total` | Total records |
| `offset` | Pagination offset |
| `limit` | Pagination limit |
| `history` | `[LinkShareItemPoint]` |

### LinkShareItemPoint

| Property | Description |
|---|---|
| `point` | Point value |
| `isPointGranted` | Whether points have been granted |
| `advertiser` | Advertiser name |
| `grantDate` | Grant date (`yyyy-MM-dd`) |
| `transactionDate` | Transaction date (`yyyy-MM-dd`) |
| `orderId` | Order ID |
| `advertiserId` | Advertiser ID |

### LinkShareProcessingPoint

| Property | Description |
|---|---|
| `count` | Total processing points |

---

## Errors

### RewardSDKSessionError

Returned by session-related APIs.

| Case | Description |
|---|---|
| `userNotFound` | Session start failed — user not found |
| `appcodeInvalid` | SDK status is `appcodeInvalid` |
| `bundleError` | Wrong parameters |
| `loginRequired` | Must log in first (RakutenAuth only) |
| `invalidTokenType` | Token type is not valid (RakutenAuth only) |
| `cannotRetrieveSessionToken` | Could not retrieve session token — restart session |
| `cannotLogOutOnServer` | Server logout failed (RakutenAuth only) |

### RPGRequestError

Returned by network/API calls.

| Case | Description |
|---|---|
| `tokenExpire` | Access token expired |
| `serverError` | Cannot reach server |
| `badRequest` | Malformed request |
| `unavailableForLegalReasons` | User has not consented (legal block) |

### SDKError

Returned by most SDK feature APIs.

| Case | Description |
|---|---|
| `noMissionFound` | Mission list is empty |
| `missionReachedCap` | Mission has already been completed to its cap |
| `noUnclaimedItemFound` | No unclaimed missions available |
| `sessionNotInitialized` | SDK has not been initialized |
| `featureDisabledByUser` | User has opted out |
| `sdkStatusNotOnline` | SDK status is not `.online` |
| `sdkStatusUserNotConsent` | User has not provided consent |
| `checkIsSpsUserError` | Error checking SPS membership |
| `unexpectedError(message:)` | Unexpected error with description |
| `spsFeatureIsDisabled` | SPS is not enabled for this app |
| `spsRegisterUserDidNotFinish` | SPS registration was not completed |
| `spsRegisterUserError` | Error during SPS registration |
| `onMaintenanceMode` | SDK is currently in maintenance mode |
