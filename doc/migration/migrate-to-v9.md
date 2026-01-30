# V9 Migration Guide

## Overview
This guide explains how to migrate from the old API pattern to the new RewardTokenProvider approach introduced in SDK v9.

> **Note:** The old `startSession` APIs (by directly passing access token) are planned to be deprecated but still supported. However, they do not benefit from v9's automatic token expiry handling. We recommend migrating to `MissionTokenProvider` for a better experience.

## Token Management Changes

### Old Way (Deprecated)
Previously, SDK consumers needed to provide an access token before using the SDK:

```swift
// Old approach
startSession(
        appCode: String,
        accessToken: String,
        tokenType: TokenType,
        completion: @escaping (Result<SDKUser, RewardSDKSessionError>) -> Void
)
```

**Note:** These APIs still function but require manual handling of token expiry (TOKENEXPIRE errors). Migrate to `MissionTokenProvider` to benefit from automatic token management.

### New Way (v9+)
Now, clients should provide a MissionTokenProvider instance during SDK initialization:

```swift
// New approach - using MissionTokenProvider

class RIDTokenProvider: MissionTokenProvider {
    static let shared = RIDTokenProvider()
    func getAccessToken() async throws -> String {
        return access token
    }
}

RakutenReward.shared.initSdk(appCode: "example", tokenType: .rid, tokenProvider: RIDTokenProvider.shared)
```

## Benefits of the New Approach

1. **Better Token Management**: The token provider pattern allows for dynamic token updates without reinitializing the SDK
2. **Automatic Token Expiry Handling**: The SDK now handles token expiry cases internally - you no longer need to handle token expired error
3. **Simplified Status Management**: No need to wait for `ONLINE` status before using SDK features

## Migration Steps

### Step 1: Remove Deprecated API Calls
Remove the following API calls from your code:

```swift
// Remove these deprecated calls
RakutenReward.shared.startSession(appCode: "", accessToken: "") // No longer needed - SDK handles session automatically
```

**Note:** Previously, you needed to call `startSession()` after providing a token to manually start the SDK session. With `MissionTokenProvider`, the SDK automatically manages the session for you.

### Step 2: Implement MissionTokenProvider
Create a token provider that implements the `MissionTokenProvider` protocol:

```swift
class RIDTokenProvider: MissionTokenProvider {
    static let shared = RIDTokenProvider()
    func getAccessToken() async throws -> String {
        return access token // return "" if error
    }
}
```

**Important**:
- When user is logged in: Return a valid, non-expired access token from your authentication system
- When user is NOT logged in: Return an empty string (`""`)
- The SDK will call this method whenever it needs a token

### Step 3: Initialize SDK with Token Provider
Pass the token provider to `RakutenReward.init()` during app initialization:

```swift
RakutenReward.shared.initSdk(appCode: "example", tokenType: .rid, tokenProvider: RIDTokenProvider.shared)
```

### Step 4: Remove Token Expiry Handling
In previous SDK versions, you needed to handle token expired status manually. It is no longer required

```swift
RakutenReward.shared.didUpdateStatus = { status in
    if status == .tokenExpired { // no longer needed

    }
}
```

The SDK now handles token expiry automatically by calling your `getAccessToken()` method when needed.

### Step 5: Remove ONLINE Status Checks
Previously, you had to wait for `ONLINE` status before using SDK features. This is no longer required:

```swift
// OLD WAY - Remove these patterns:

// Pattern 1: Status check before API calls
if RakutenReward.shared.status == .online { // Remove this conditional check
    RakutenReward.shared.logAction(code) 
}

// Pattern 2: Waiting for ONLINE status in callback
RakutenReward.shared.didUpdateStatus = { status in
    if status == .online { // Remove this conditional check
        RakutenReward.shared.logAction(code) 
    }
}
``` 

```swift
// NEW WAY - Direct API usage:
RakutenReward.shared.logAction(code) // Call directly after init with token provider
```