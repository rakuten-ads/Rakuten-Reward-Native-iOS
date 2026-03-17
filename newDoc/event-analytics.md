# Event Analytics

Event Analytics (available from SDK v3.3.0) bridges your Analytics SDK events with Reward SDK missions. The same user action can drive both your analytics dashboard and a mission incentive — without duplicating code.

---

## How It Works

1. Your app logs actions using `RakutenMissionEvent` (instead of directly using the Analytics SDK).
2. If no mission mapping is configured, the event is forwarded to the Analytics SDK only.
3. If you configure a mapping in the Reward SDK Developer Portal (Analytics event name ↔ Mission action code), the SDK sends the event to **both** Analytics SDK and Reward SDK.

You can enable or disable the incentive in the portal without touching your app code.

---

## Installation

Add the Analytics SDK to your project:

**CocoaPods:**

```ruby
pod 'RAnalytics', :source => 'https://github.com/rakutentech/ios-analytics-framework.git'
```

**Swift Package Manager:**

```
SSH:   git@github.com:rakutentech/ios-analytics-framework.git
HTTPS: https://github.com/rakutentech/ios-analytics-framework.git
```

Full Analytics SDK documentation: https://documents.developers.rakuten.com/ios-sdk/analytics-9.1/

---

## Enable the Feature

```swift
RewardConfiguration.isMissionEventFeatureEnabled = true
```

---

## Logging Events

```swift
RakutenMissionEvent.shared.logAction(
    eventCode: "YOUR_EVENT_CODE",
    eventTrackingType: .ratSpecificEvent,
    parameters: nil
) { error in
    if let error {
        // Handle error
        return
    }
    // Success
}
```

### Parameters

| Parameter | Type | Description |
|---|---|---|
| `eventCode` | `String` | The Analytics SDK event code |
| `eventTrackingType` | `RakutenMissionEventTrackingType` | See below |
| `parameters` | `[String: Any]?` | Optional additional Analytics SDK parameters |

### `RakutenMissionEventTrackingType`

| Value | Description |
|---|---|
| `.genericEvent` | A generic Analytics SDK event |
| `.ratSpecificEvent` | An Analytics SDK RAT-specific event |
