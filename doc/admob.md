# AdMob Integration Guide (iOS)

> [![ja](images/ja.png)](ja/admob.md) 日本語版

This guide explains how to add optional Google AdMob interstitial ad support to your app using the Rakuten Reward SDK.

---

## Overview

By default, your app uses the following SDKs:

| SDK | Required | Purpose |
|---|---|---|
| `RakutenRewardNativeSDK` | Yes | Core Reward SDK |
| `RakutenRewardAdMob` | **No — optional** | AdMob interstitial support |
| `Google-Mobile-Ads-SDK` | **No — optional** | Google's AdMob SDK (CocoaPods: pulled in automatically; SPM: add manually) |

If you do not add `RakutenRewardAdMob`, the SDK behaves exactly as before with no code changes required.

---

## What it does

After the user successfully earns SPS points, the SDK automatically presents a full-screen interstitial ad. When the user dismisses it, the SPS flow continues normally

---

## Requirements

- iOS 14.0 or later
- `RakutenRewardNativeSDK` ~> 9.3.0
- Google-Mobile-Ads-SDK ~> 12.14 (CocoaPods: pulled in automatically; SPM: add manually — see Installation below)
- `GADApplicationIdentifier` in your `Info.plist` (required by Google — app crashes on launch without it)

---

## Installation

### CocoaPods

Add `RakutenRewardAdMob` to your Podfile alongside the core SDK:

```ruby
pod 'RakutenRewardNativeSDK', '~> 9.3.0'
pod 'RakutenRewardAdMob',     '~> 9.3.0'
```

Then run:

```
pod install
```

`Google-Mobile-Ads-SDK` is pulled in automatically as a transitive dependency — you do not need to list it separately.

### Swift Package Manager

SPM binary targets cannot declare dependencies, so `GoogleMobileAds` is **not** pulled in automatically. You must add both packages manually.

**Step 1** — In Xcode, go to **File > Add Package Dependencies** and add the Rakuten Reward SDK:
```
https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS-SPM
```
Select `RakutenRewardNativeSDK` and `RakutenRewardAdMob` from the product list.

**Step 2** — Add the Google Mobile Ads package:
```
https://github.com/googleads/swift-package-manager-google-mobile-ads.git
```
Select `GoogleMobileAds` from the product list. Use version rule `>= 12.14.0` (or any version your app requires — there is no SPM-enforced constraint).

---

## Setup

Follow these three steps to complete the integration.

### Step 1 — Add your AdMob App ID to Info.plist

Google requires `GADApplicationIdentifier` before the SDK initialises. **The app will crash on launch without this key.**

Add your real App ID from the [AdMob console](https://admob.google.com):

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy</string>
```

> **During development only**, you can use Google's official test App ID to avoid the crash without a real AdMob account:
> ```xml
> <key>GADApplicationIdentifier</key>
> <string>ca-app-pub-3940256099942544~1458002511</string>
> ```
> Replace this with your real App ID before submitting to the App Store.

### Step 2 — Call `configure()` at launch

Call `RakutenRewardAdMobAdapter.configure()` in your app entry point, before any Reward SDK calls:

**SwiftUI app:**

```swift
import RakutenRewardAdMob

@main
struct MyApp: App {
    init() {
        RakutenRewardAdMobAdapter.configure()
    }
    // ...
}
```

**UIKit AppDelegate:**

```swift
import RakutenRewardAdMob

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    RakutenRewardAdMobAdapter.configure()
    return true
}
```

That's the complete integration. The ad unit ID is fetched automatically from the server — no further configuration is needed.

---

## If your app already uses AdMob

No extra steps are needed. Simply add `RakutenRewardAdMob` to your Podfile or SPM and call `configure()`.

| Concern | What happens |
|---|---|
| `Google-Mobile-Ads-SDK` already in Podfile | CocoaPods resolves a single shared copy automatically — no duplicate |
| `GoogleMobileAds` already in SPM | No conflict — SPM uses your existing package entry; no second entry needed |
| Your existing version is older than 12.14 | Update it: `pod 'Google-Mobile-Ads-SDK', '~> 12.14'`. The API is backwards-compatible for standard ad loading |
| Your existing version is newer than 12.x | No action needed — `RakutenRewardAdMob` uses only stable, non-deprecated APIs that carry forward |
| You already call `MobileAds.shared.start(completionHandler:)` | Safe — `configure()` calls it internally, but Google's `start()` is idempotent |

---

## Removing AdMob support

Remove `RakutenRewardAdMob` from your Podfile or SPM and delete the `configure()` call. The Reward SDK continues to work normally — the SPS flow is unaffected.
