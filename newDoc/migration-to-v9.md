# Migration to v9

SDK v9.0.0 introduces `MissionTokenProvider` — a new pattern for token management that eliminates the need for manual session handling. This guide covers what changed and how to update your integration.

> The old `startSession` APIs still work. Migration is not mandatory today, but is strongly recommended for a simpler, more robust integration.

---

## What Changed

| Concern | Before v9 | v9+ |
|---|---|---|
| Token delivery | Pass token to `startSession` each call | Implement `MissionTokenProvider` once |
| Token expiry | Handle `.tokenExpired` status manually | SDK refreshes the token automatically |
| Session start | Must call `startSession` after providing a token | SDK starts the session automatically after `initSdk` |
| ONLINE status check | Must wait for `.online` before calling APIs | Not required — call APIs directly |

---

## Migration Steps

### Step 1 — Implement `MissionTokenProvider`

Create a class that conforms to the protocol:

```swift
class RIDTokenProvider: MissionTokenProvider {
    static let shared = RIDTokenProvider()

    func getAccessToken() async throws -> String {
        // Return the current valid token, or "" if not logged in
        return yourAuthSystem.currentToken ?? ""
    }
}
```

Key rules for your implementation:
- **Logged in:** return a valid, non-expired token.
- **Not logged in:** return `""` (empty string). Do not throw.
- **Token refresh:** handle refresh logic inside this method if your auth SDK supports it.

### Step 2 — Replace `startSession` with `initSdk`

```swift
// Before
RakutenReward.shared.tokenType = .rid
RakutenReward.shared.startSession(
    appCode: "YOUR_APP_CODE",
    accessToken: currentToken,
    completion: { result in }
)

// After
RakutenReward.shared.initSdk(
    appCode: "YOUR_APP_CODE",
    tokenType: .rid,
    tokenProvider: RIDTokenProvider.shared
)
```

### Step 3 — Remove Token Expiry Handling

The SDK now calls `getAccessToken()` automatically when it detects an expired token. You can remove this pattern:

```swift
// Remove this
RakutenReward.shared.didUpdateStatus = { status in
    if status == .tokenExpired {
        // ... manual token refresh logic
    }
}
```

You may still observe `.userNotConsent` in this callback — that remains your responsibility.

### Step 4 — Remove ONLINE Status Guards

You no longer need to wait for `.online` before calling SDK APIs:

```swift
// Remove these patterns
if RakutenReward.shared.status == .online {
    RakutenReward.shared.logAction(actionCode: "code") { _ in }
}

// Remove this too
RakutenReward.shared.didUpdateStatus = { status in
    if status == .online {
        RakutenReward.shared.logAction(actionCode: "code") { _ in }
    }
}
```

```swift
// After — call directly
RakutenReward.shared.logAction(actionCode: "code") { _ in }
```

---

## Objective-C

`MissionTokenProvider` uses Swift `async/await` and is **not available in Objective-C**. Continue using `startSession` in Objective-C apps. Manual token expiry handling is still required for Objective-C integrations.

---

## Summary

| Remove | Replace with |
|---|---|
| `startSession(appCode:accessToken:tokenType:completion:)` | `initSdk(appCode:tokenType:tokenProvider:)` |
| `status == .tokenExpired` handling | Nothing — SDK handles it |
| `status == .online` guard before API calls | Nothing — call APIs directly |
