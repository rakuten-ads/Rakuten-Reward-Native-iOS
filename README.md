# RAKUTEN REWARD NATIVE SDK - iOS

Required Xcode: Xcode 11 and later (due to Swift 5, XCFramework, SwiftUI)

## Code generation tool (Optional)

- Natalie (for Storyboard)
- BartyCrouch (for NSLocalizedString)

Shark:

```zsh
shark RakutenRewardNativeSDK.xcodeproj RakutenRewardNativeSDK/Shark.swift --target RakutenRewardNativeSDK
```

Discard `UIColor` change (iOS 11 reason)
Optional: change privacy settings to `internal`

## Previews for screens (for quickly reproduce a UI bug). 

- `PreviewProvider` of SwiftUI
- `Creator` in **AppDelegate** of target **RakutenRewardNativeSDKLunchUITests**

Automation: 
- Fastlane: build framework, sample and upload to TestFlight by `fastlane DailyReleaseLane` (also requires Xcode 11 as command line tools)

## Quick config

New build and version number for release: **fastlane.swift**

Adding a new app code: **EnvironmentViewController.swift**

Token service for logging in, refresh token: **AuthService.swift**

## Sample tips

Please make sure visiting the Environment screen first -> Log In -> Start Session

Changing the environment -> Please log in again 

## Project Structure

* RakutenRewardNativeSDK 
    * Shared
        * Assets
        * Classes
        * Constants
        * Localizables
        * Network
        * Previews
        * Utilities
        * Views
        * WKWebviews
    * RewardSDKAPIs
        * Shared
            * Ads
            * Actions
            * Authentication
            * Members
            * Notifications
            * ObjectiveCWrappers
            * Poikatsu
            * PointExchange
            * PointHistory
            * Portal
            * RakutenReward
            * RewardPortalButton
            * SupportPages
    * Resources

<br>
<h1>Overview</h1>

<h2>RakutenRewardNativeSDK</h2>

RakutenRewardNativeSDK is the top-level folder in the project.

<br>
<h2>Shared</h2>
In RakutenRewardNativeSDK, we have a shared folder. This folder consists of files that are used across the projects.

<br>
<h2>RewardSDKAPIs</h2>

In RakutenRewardNativeSDK, we have a RewardSDKAPIs folder. All files related to RewardSDKAPIs should be here.

RewardSDKAPIs folder has a shared folder. Files that are used across the RewardSDK should be here and the folders like Ads, Actions, Members are organized by feature/module.



Below these folders, we should separate files by their type. For example, for Members, we have a few subfolders, APIs, Models, and Requests. We could have other folder types as well. For instance, views folder, shared folder, Models folder and etc.

* RewardSDKAPIs
    * Members
        * APIs
        * Models
        * Requests

<br>
<h2>Resources></h2>

In RakutenRewardNativeSDK, we have resources folder. All assets should be here.

## Files structure

Different Classes/Structs/Enums/Protocols should not be added in the same file. It's hard to find a specific class/struct/enum/protocol from the project structure if they are hidden in other files.<br>

For example, we have ContactUsView and HyperlinkedTextview in the same file. We should separate one file for ContactUsView and one file for HyperlinkedTextview.
