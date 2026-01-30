[TOP](../../README.md#top)　>　Basic Guide

Table of Contents
* [Region Setting](#region-setting)<br>
* [Authentication](#authentication)<br>
  * [Login Options](#login-options)<br>
  * [Log in](#log-in)<br>
  * [Log out](#log-out)<br>
* [Initialize SDK](#initialize-sdk)<br>
* [Getting User Information](#getting-user-information)<br>
* [Mission Achievement](#mission-achievement)<br>
* [SDK Portal](#sdk-portal)<br>
* [Ad Portal](#ad-portal)<br><br>

# Region Setting

For Japan
```Swift
RakutenReward.shared.region = RakutenRewardRegion.japan
```

<br><br>

# Authentication

## Login Options
There are 3 types of login. According to your environment, please select proper one. 

Note: RAE will be abolished by 2025. Please make a plan to migrate to RID token or other solution. This enum case will be removed in future release.

<br>

| Login Option        | Description | Support |
| --- | --- | --- |
| rakutenAuth | This is default option, provide login by SDK, SDK handled all login and user identifier | Japan |
| rid | Rakuten ID SDK with RID, Login covers by ID SDK, and use API token for SDK| Japan |  
| rae | Rakuten ID SDK with RAE, Login covers by ID SDK, and use token for SDK | Japan |
<br>

### Switch Login Option
By default, login option is rakutenAuth
<br>

### RakutenAuth
```swift
RakutenReward.shared.tokenType = TokenType.rakutenAuth
```
<br>

### RID

**New v9 Approach (Recommended):**

To use SDK with RID token, implement a `MissionTokenProvider`:

```swift
class RIDTokenProvider: MissionTokenProvider {
    static let shared = RIDTokenProvider()

    func getAccessToken() async throws -> String {
        // Return your RID access token here
        // Return "" if user is not logged in
        return "your_rid_access_token"
    }
}

// Initialize SDK with token provider
RakutenReward.shared.initSdk(
    appCode: "Your App Key",
    tokenType: .rid,
    tokenProvider: RIDTokenProvider.shared
)
```

**Benefits of v9 approach:**
- Automatic token expiry handling
- No need to manually call `startSession` or check for ONLINE status
- SDK manages session automatically

**Old Approach (Deprecated but still supported):**

Set token type and pass access token directly:

```swift
RakutenReward.shared.tokenType = TokenType.rid
RakutenReward.shared.startSession(appCode: "Your App Key", accessToken: <Access token>, completion: { r in
    if case .success(let user) = r {  // use portal or use additional setup
  }
})
```

**From version 3.3.1, developers require to call logout API whenever user log out to properly clear token and data**

Refer to [Log Out](#log-out)
<br><br>

### RAE

Note: RAE will be abolished by 2025. Please make a plan to migrate to RID token or other solution. This enum case will be removed in future release.

**New v9 Approach (Recommended):**

To use SDK with RAE token, implement a `MissionTokenProvider`:

```swift
class RAETokenProvider: MissionTokenProvider {
    static let shared = RAETokenProvider()

    func getAccessToken() async throws -> String {
        // Return your RAE access token here
        // Return "" if user is not logged in
        return "your_rae_access_token"
    }
}

// Initialize SDK with token provider
RakutenReward.shared.initSdk(
    appCode: "Your App Key",
    tokenType: .rae,
    tokenProvider: RAETokenProvider.shared
)
```

**Benefits of v9 approach:**
- Automatic token expiry handling
- No need to manually call `startSession` or check for ONLINE status
- SDK manages session automatically

**Old Approach (Deprecated but still supported):**

Set token type and pass access token directly:

```swift
RakutenReward.shared.tokenType = TokenType.rae
RakutenReward.shared.startSession(appCode: "Your App Key", accessToken: <Access token>, completion: { r in
    if case .success(let user) = r {  // use portal or use additional setup
  }
})
```

**From version 3.3.1, developers require to call logout API whenever user log out to properly clear token and data**

Refer to [Log Out](#log-out)
<br><br>

## Log In

This is for external login options, If you use Rakuten Login SDK, you don't need to use this option.
<br>

```swift
RakutenReward.shared.openLoginPage({result in 
    switch result:
    case .dismissByUser: // resume in another time
    case .LogInCompleted: // starting session
    case .failToShowLoginPage: // presenting problem
  }) 
```

![Login](Login.PNG)
<br>

## Log out

Logging user out: 

```swift
RakutenReward.shared.logout { }
```
<br>

# Initialize SDK

## New v9 Approach (Recommended)

**For RID/RAE Token (External Authentication):**

1. Implement `MissionTokenProvider`:

```swift
class MyTokenProvider: MissionTokenProvider {
    static let shared = MyTokenProvider()

    func getAccessToken() async throws -> String {
        // Return your access token here
        // Return "" if user is not logged in
        return "your_access_token"
    }
}
```

2. Initialize SDK with token provider:

```swift
RakutenReward.shared.initSdk(
    appCode: "Your App Key",
    tokenType: .rid, // or .rae
    tokenProvider: MyTokenProvider.shared
)
```

**For Built-in Login (RakutenAuth):**

```swift
RakutenReward.shared.initSdkThirdParty(appCode: "Your App Key")
```

**Benefits of v9 approach:**
- Automatic token expiry handling by SDK
- No need to manually call `startSession`
- No need to wait for ONLINE status before using SDK features
- SDK manages session automatically

| Parameter name | Description
| --- | ---
| appCode | Application Key (This is from Rakuten Reward Developer Portal) |
| tokenType | Either .rid, .rae, or .rakutenAuth |
| tokenProvider | Your MissionTokenProvider implementation |

## Old Approach (Deprecated but still supported)

To use Reward SDK with the old approach, need to establish SDK session first.

From version 6.1.0:

```swift
RakutenReward.shared.startSession(appCode: "Your App Key", accessToken: <Access token>, tokenType: <token type>, completion: { r in
    if case .success(let user) = r {  // use portal or use additional setup
  }
})
```

Before version 6.1.0:

```swift
RakutenReward.shared.startSession(appCode: "Your App Key", accessToken: <Access token>, completion: { r in
    if case .success(let user) = r {  // use portal or use additional setup
  }
})
```

Note: The old approach requires manual handling of token expiry (TOKENEXPIRE errors).

<br>

## Initialization flow with Built-in Login service

**New v9 Approach:**

```swift
// Initialize SDK once at app startup
RakutenReward.shared.initSdkThirdParty(appCode: "Your App Key")

// Check login status and open login page if needed
if !RakutenReward.shared.isLogin() {
    RakutenReward.shared.openLoginPage { result in
        // SDK automatically manages session after login
    }
}
```

**Old Approach:**

```swift
if RakutenReward.shared.isLogin() {
  RakutenReward.shared.startSession(appCode: <#appcode#>, completion:<#callback#>)
} else {
  RakutenReward.shared.openLoginPage({_ in
    // starting session ...
  })
}
```
<br>

# Getting user information

### Get user's full name

```swift
RakutenReward.shared.user?.getName()
```

### Get user Current point and rank: 

```swift
RakutenReward.shared.user?.currentPointRank()
```
<br>

# Mission Achievement 
To achieve mission, developers need to call post action API.  
After achieving the mission, notification will be shown.  
<br>

## Post Action
```swift
RakutenReward.shared.logAction(actionCode: "<actionCode>", completionHandler: { actionResult in })
```
actionCode is provided by Reward SDK Developer Portal.  
<br>

## Notification UI
The user achieved the mission, notification UI is shown.  
Reward SDK provides Modal and Banner UI

![Modal](Modal.PNG)     ![Banner](Banner.PNG)
<br>

### Notification Type
There  are 4 types of Mission Achievement UI. Modal, Banner, and No UI, and Custom which developed by developers.

You can decide type by Developer Portal 

| Notification Type        | UI
| --- | ---
| Modal | Show Modal UI provided by SDK
| Banner | Show Banner UI provided by SDK
| Custom | Developer can create UI by themselves
| Small Ad Banner / Banner_50 | Show Banner_50 UI provided by SDK
| Big Ad Banner / Banner_250 | Show Banner_250 UI provided by SDK
| No UI | Not show any UI
<br>

# SDK Portal
We provide User Portal UI for developers. In SDK Portal, developers can see user status (mission, unclaim list, current point, point history etc...)
<br>

Call Open SDK Portal API:
```swift
RakutenReward.shared.openPortal(completionHandler: { result in
    // Handle success or fail to open portal
})
```

Below are the portal UIs:

![Portal1](Portal1.png?)

![Portal2](Portal2.png?)

![Portal3](Portal3.png?)

![Portal4](Portal4.png?)

![Portal5](Portal5.png?)

![Portal6](Portal6.png?)
<br>

# Ad Portal (Deprecated from version 5.x)
*Ad Portal APIs are available from version 3.1.0 (JP region only)
<br>

Call Open Ad Portal API:
```swift
RakutenReward.shared.openAdPortal { completion in 
    // Handle success or fail to open ad portal
}
```

Below are the ad portal UIs:

![AdPortal1](AdPortal1.png)

<br>

LANGUAGE :
> [![ja](../lang/ja.png)](../ja/basic/README.md)
