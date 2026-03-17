# Missions & Point Claiming

Missions are actions the user must complete to earn reward points. You define missions and their action codes in the Rakuten Reward Developer Portal.

---

## How Missions Work

1. A mission has an **action code** and a **required count** (e.g., "tap button 3 times").
2. Your app calls `logAction` each time the user performs the action.
3. When the count is reached, the SDK marks the mission as achieved and triggers a notification.
4. The user must **claim** the achievement to receive the points.

---

## Logging Actions

```swift
RakutenReward.shared.logAction(actionCode: "YOUR_ACTION_CODE") { result in
    switch result {
    case .success:
        break
    case .failure(let error):
        // Handle SDKError / RPGRequestError
    }
}
```

`actionCode` values are set up in the Rakuten Reward Developer Portal.

---

## Mission Achievement Notification

When a mission is achieved, the SDK fires `didUpdateUnclaimedAchievement` and (depending on the mission's notification type) shows a UI.

### Notification Types

| Type | Behaviour |
|---|---|
| `MODAL` | SDK shows a full-screen modal |
| `BANNER` | SDK shows a top banner |
| `BANNER_50` | SDK shows a small ad banner |
| `BANNER_250` | SDK shows a large ad banner |
| `CUSTOM` | No SDK UI — you build your own |
| `NONE` | No UI shown |

The notification type is configured per-mission in the Developer Portal.

---

## Custom Notification UI

If a mission uses the `CUSTOM` notification type, implement the callback to show your own UI:

```swift
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in
    guard unclaimedItem.notificationType == .CUSTOM,
          RewardConfiguration.isUserSettingUIEnabled,
          !RewardConfiguration.isPortalPresent else {
        return
    }

    // Show your custom notification on the main thread
    DispatchQueue.main.async {
        // present your UI
    }
}
```

> The SDK does not support showing notifications while the portal is open. Always guard with `RewardConfiguration.isPortalPresent`.

---

## Claiming Points

After showing your notification, prompt the user to claim their points:

```swift
RakutenReward.shared.claim(unclaimedItem: unclaimedItem) { event in
    switch event {
    case .willPresent:
        break
    case .didClaimSuccessfully(let item):
        print("Claimed \(item.point) points")
    case .didFailToClaim(let error):
        print("Claim failed: \(error)")
    case .didDismiss, .didSelfDismiss, .didDismissByUser:
        break
    case .didFailToShow(let error):
        print("Could not show claim screen: \(error)")
    case .didTriggerIchibaDeeplink(let url):
        // Open the Ichiba deeplink
        UIApplication.shared.open(url)
    }
}
```

To enable the Ichiba deeplink callback:

```swift
RakutenReward.shared.claim(
    unclaimedItem: unclaimedItem,
    enableIchibaCallback: true
) { event in
    // same switch as above
}
```

---

## Fetching the Mission List

### Full list (with progress)

Returns missions including how many times the user has logged the action and whether the cap has been reached:

```swift
RakutenReward.shared.getMissionListWithProgress { result in
    switch result {
    case .success(let missions):
        // [Mission]
    case .failure(let error):
        break
    }
}
```

### Lite list (lightweight)

Returns missions without progress or `reachedCap` — useful for displaying a catalogue:

```swift
RakutenReward.shared.getMissionLiteList { result in
    switch result {
    case .success(let missions):
        // [MissionLite]
    case .failure(let error):
        break
    }
}
```

### Single mission details

```swift
RakutenReward.shared.getMissionDetails(actionCode: "ACTION_CODE") { result in
    switch result {
    case .success(let mission):
        // Mission
    case .failure(let error):
        break
    }
}
```

### Cached list (synchronous)

The last-fetched mission list is always available without a network call:

```swift
let missions = RakutenReward.shared.missionList
```

---

## Unclaimed Missions

Retrieve any previously achieved but unclaimed missions:

```swift
RakutenReward.shared.getUnclaimedMission { result in
    switch result {
    case .success(let items):
        // [UnclaimedItem] — claim each one via RakutenReward.shared.claim(...)
    case .failure(let error):
        break
    }
}
```

---

## Point History

Get the user's reward point history for the past three months:

```swift
RakutenReward.shared.getPointHistory { result in
    switch result {
    case .success(let history):
        // PointHistory — use history.getPointHistory() to get [PointRecord]
    case .failure(let error):
        break
    }
}
```

Each `PointRecord` has:
- `point` — points earned
- `month` — the month (as a string)
