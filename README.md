# Rakuten Reward Native SDK — iOS

[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://developer.apple.com/ios/)
[![iOS](https://img.shields.io/badge/iOS-14%2B-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-6.x-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-26.2-blue.svg)](https://developer.apple.com/xcode/)
[![Version](https://img.shields.io/badge/version-9.1.0-green.svg)](doc/changelog.md)

The Rakuten Reward Native SDK lets your iOS app use Rakuten Reward mission feature. Users earn points by completing in-app actions; the SDK handles mission tracking, point claiming, and the built-in UI for you.

---

## Requirements

| Requirement | Value |
|---|---|
| Xcode | 26.2 or later |
| Swift | 6.x |
| iOS Deployment Target | 14.0 or later |
| SDK Version | 9.1.0 |

### Version Compatibility

| SDK Version | Minimum iOS | Xcode |
|---|---|---|
| 1.x | 9 | 11 |
| 2.x | 9 | 12 |
| 3.x | 9 | 13 |
| 4.x | 11 | 14 |
| 5.x | 11 | 14 |
| 6.x | 11 | 15 |
| 7.x | 13 | 15 |
| 8.x | 13 | 16 |
| 9.x | 14 | 26 |

---

## Installation

### CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS.git'

target 'YourApp' do
  pod 'RakutenRewardNativeSDK', '9.1.0'
end
```

### Swift Package Manager

```swift
dependencies: [
    .package(
        url: "https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS-SPM",
        .exact("9.1.0")
    ),
]
```

### Carthage

Add to your `Cartfile`:

```
binary "https://raw.githubusercontent.com/rakuten-ads/Rakuten-Reward-Native-iOS/master/CarthageSpec.json" == 9.1.0
```

Then update and embed the framework:

```bash
carthage update --platform ios --use-xcframeworks
```

Drag the built `XCFramework` from `Carthage/Build/` into the **Frameworks, Libraries, and Embedded Content** section of your target.

---

## Quick Start

```swift
// 1. Initialize with your token provider (v9 recommended approach)
RakutenReward.shared.initSdk(
    appCode: "YOUR_APP_CODE",
    tokenType: .rid,
    tokenProvider: MyTokenProvider.shared
)

// 2. Log an action when the user completes something
RakutenReward.shared.logAction(actionCode: "YOUR_ACTION_CODE") { _ in }
```

See [Authentication & Initialization](doc/authentication.md) for a full setup guide.

---

## Documentation

| I want to… | Read |
|---|---|
| Initialize SDK | [Authentication & Initialization](doc/authentication.md) |
| Let users earn points | [Missions & Point Claiming](doc/missions.md) |
| Handle user privacy consent | [User Consent](doc/user-consent.md) |
| Show the SDK or SPS portal | [Portals](doc/portal.md) |
| Integrate Super Point Screen ads | [Super Point Screen (SPS)](doc/sps.md) |
| Trigger SDK APIs from a WebView | [JavaScript Extension](doc/js-extension.md) |
| Look up a specific API | [API Reference (Swift)](doc/api-reference.md) |
| Use the SDK from Objective-C | [Objective-C Guide](doc/objective-c.md) |
| Upgrade from an earlier version | [Migration to v9](doc/migration-to-v9.md) |
| See what changed in each release | [Changelog](doc/changelog.md) |

---

> [![ja](doc/images/ja.png)](doc/ja/README.md) 日本語版

---

## Open Source

This SDK uses [KeychainSwiftWrapper](https://github.com/jrendel/SwiftKeychainWrapper).
This product includes software developed by Marcin Krzyzanowski (http://krzyzanowskim.com/).
