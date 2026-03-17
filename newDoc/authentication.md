# Authentication & Initialization

This guide covers every way to authenticate users and initialize the SDK. Read this first — you must complete initialization before calling any other SDK API.

---

## Choosing an Authentication Method

| Method | When to use | Status |
|---|---|---|
| **RakutenAuth** | Your app has no Rakuten login. The SDK provides its own login UI. | Supported |
| **RID** (Rakuten ID SDK) | Your app uses the Rakuten ID SDK with RID/API-C tokens. | Supported (recommended) |
| **RAE** (Rakuten User SDK) | Your app uses the Rakuten User SDK with RAE tokens. | **Deprecated** — migrate to RID before 2025 |

---

## Step 1 — Initialize the SDK

### Option A: RakutenAuth (SDK-provided login)

Use this if your app does **not** use a Rakuten login SDK.

```swift
// Call once at app launch (e.g., in AppDelegate or App struct)
RakutenReward.shared.initSdkThirdParty(appCode: "YOUR_APP_CODE")
```

After initialization, check login status and present the login page if needed:

```swift
if !RakutenReward.shared.isLogin() {
    RakutenReward.shared.openLoginPage { result in
        switch result {
        case .logInCompleted:
            // User is now logged in; SDK session is managed automatically
        case .dismissByUser:
            // User closed the login page; try again later
        case .failToShowLoginPage:
            // Could not present the login UI
        }
    }
}
```

### Option B: RID Token (Recommended for v9)

Use this if your app uses the Rakuten ID SDK.

**1. Implement `MissionTokenProvider`:**

```swift
class RIDTokenProvider: MissionTokenProvider {
    static let shared = RIDTokenProvider()

    func getAccessToken() async throws -> String {
        // Return the current API-C access token.
        // Return "" if the user is not logged in.
        return yourIDSDK.currentAccessToken ?? ""
    }
}
```

**2. Initialize the SDK:**

```swift
RakutenReward.shared.initSdk(
    appCode: "YOUR_APP_CODE",
    tokenType: .rid,
    tokenProvider: RIDTokenProvider.shared
)
```

The SDK calls `getAccessToken()` automatically whenever it needs a fresh token. You no longer need to monitor `.tokenExpired` status or call `startSession` manually.

### Option C: RAE Token (Deprecated)

The same `MissionTokenProvider` pattern applies for RAE:

```swift
class RAETokenProvider: MissionTokenProvider {
    static let shared = RAETokenProvider()

    func getAccessToken() async throws -> String {
        return yourUserSDK.currentAccessToken ?? ""
    }
}

RakutenReward.shared.initSdk(
    appCode: "YOUR_APP_CODE",
    tokenType: .rae,
    tokenProvider: RAETokenProvider.shared
)
```

> **Warning:** RAE will be removed in a future release. Plan your migration to RID now.

---

## Logout

Always call logout when the user signs out so the SDK clears its token and session data.

```swift
RakutenReward.shared.logout { }
```

---

## SDK Status

The SDK reports its current state via `RakutenReward.shared.status` and the `didUpdateStatus` callback:

| Status | Meaning |
|---|---|
| `.online` | SDK is ready; user info is up to date |
| `.offline` | Initialization has not completed or failed |
| `.appcodeInvalid` | The app code you passed is wrong |
| `.tokenExpired` | Token expired (RakutenAuth only — prompt user to log in again) |
| `.userNotConsent` | User has not accepted the Reward terms of service |

With `MissionTokenProvider` (Option B/C), the SDK handles token expiry internally. You only need to observe `.userNotConsent` and optionally `.online` for UI state.

```swift
RakutenReward.shared.didUpdateStatus = { status in
    if status == .userNotConsent {
        RakutenReward.shared.requestForConsent { _ in }
    }
}
```

---

## Getting User Information

```swift
// Access the current user object
let user = RakutenReward.shared.user

// User's display name
user?.getName()

// Reward SDK points and Rakuten member rank
user?.currentPointRank()
```

Subscribe to user updates:

```swift
RakutenReward.shared.didUpdateUser = { user in
    // Refresh your UI with updated points / rank
}
```

---

## MissionTokenProvider Protocol Reference

```swift
public protocol MissionTokenProvider {
    /// Return a valid access token, or "" if the user is not logged in.
    func getAccessToken() async throws -> String
}
```

The SDK calls this method on demand. Your implementation should:
- Return the latest, non-expired token when the user is logged in.
- Return `""` (empty string) when no user is logged in. Do not throw.
- Handle refresh internally if your auth SDK supports it.

---

## SDK Scope Requirements

If you need assistance with client ID scope configuration, or are experiencing issues with your access token, please contact us for guidance.
