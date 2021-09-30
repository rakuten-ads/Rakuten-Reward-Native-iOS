[TOP](../../README.md#top)　>　FAQ

FAQ
* [How can I implement the custom notification UI?](#how-can-i-implement-the-custom-notification-ui)<br>
* [How do I claim mission after a mission is achieved?](#how-do-i-claim-mission-after-a-mission-is-achieved)<br>
* [How to set IDFA in RewardSDK?](#how-to-set-idfa-in-rewardsdk)<br>
* [Can we access the Staging environment for development/testing?](#can-we-access-the-staging-environment-for-developmenttesting)<br>
* [Can we use ID SDK + JID backend to log in?](#can-we-use-id-sdk-jid-backend-to-log-in)<br>
* [What is Rakuten auth login for?](#what-is-rakuten-auth-login-for)<br>
* [Which API should I use to start/establish SDK session?](#which-api-should-i-use-to-startestablish-sdk-session)<br>

# FAQ

## How can I implement the custom notification UI?

<details>
  <summary>Answer</summary>
  
For example, Mission A needs 3 actions logged to be achieved.
```
RakutenReward.shared.logAction(actionCode: "Example", completionHandler: { result in ... }
```

After the above logAction API is called three times successfully, mission A is achieved. App can get the unclaimedItem from the delegate below
```
// From RakutenReward class
public var didUpdateUnclaimedAchievement: ((UnclaimedItem) -> Void)?
 
// Example
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in }
```

Example implementation for showing custom UI
```
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in
    guard unclaimedItem.notificationType == .CUSTOM, // Check notification type
          RewardConfiguration.isUserSettingUIEnabled, // Check if user enable the UI setting or not
          !RewardConfiguration.isPortalPresent else { // Check if Portal is currently showing, not support for showing notification inside Portal. API Available from version ...
           
        return
    }
 
    // Show Custom UI in Main thread
}
```
</details>

<br>

## How do I claim mission after a mission is achieved?

<details>
  <summary>Answer</summary>
  
For example, Mission A needs 3 actions logged to be achieved.
```
RakutenReward.shared.logAction(actionCode: "Example", completionHandler: { result in ... }
```

After the above logAction API is called three times successfully, mission A is achieved. App can get the unclaimedItem from the delegate below
```
// From RakutenReward class
public var didUpdateUnclaimedAchievement: ((UnclaimedItem) -> Void)?
 
// Example
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in }
```

Points can be claimed by calling the 'claim' method from RakutenReward shared object.
```
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in
    RakutenReward.shared.claim(unclaimedItem: unclaimedItem, completion: { pointClaimScreenEvent in }
}
```
</details>

<br>

## How to set IDFA in RewardSDK?

<details>
  <summary>Answer</summary>
  
IDFA/Advertising ID can be set using below API
```
RakutenReward.sharedInstance.advertisingID
```

Example 
```
func updateRewardAdID() {
 
        if #available(iOS 14, *) {
 
            #if canImport(AppTrackingTransparency) &&  (arch(x86_64) || arch(arm64))
 
            if ATTrackingManager.trackingAuthorizationStatus == .authorized {
 
                RakutenReward.sharedInstance.advertisingID = ASIdentifierManager().advertisingIdentifier.uuidString
 
            }
 
            #endif
 
        }
 
}
```

Requesting for permission
```
if #available(iOS 14, *) {
    #if canImport(AppTrackingTransparency) &&  (arch(x86_64) || arch(arm64))
 
    let permissionAlertAction = UIAlertAction(title: "IDFA permission", style: .default) { (_) in
        ATTrackingManager.requestTrackingAuthorization { [weak self] _ in
            self?.updateRewardAdID()
        }
    }
 
    alert.addAction(permissionAlertAction)
 
    #endif
}
```
</details>

<br>

## Can we access the Staging environment for development/testing?

<details>
  <summary>Answer</summary>
  
No, currently we do not provide Staging environment for developers. Please use development mode or test account for development/testing.
</details>

<br>

## Can we use ID SDK + JID backend to log in?

<details>
  <summary>Answer</summary>
  
Yes, with IDSDK and JID as backend, you can set the token type as RID
```
// iOS example
RakutenReward.shared.tokenType = TokenType.RID
```

Then can pass (API-C) token value in the startSession API 
```
// iOS example
 
RakutenReward.shared.startSession(appCode: "Your App Key", accessToken: <Access token>, completion: { r in
    if case .success(let user) = r { 
      // use portal or use additional setup
  }
}
```

</details>

<br>

## What is Rakuten auth login for?

<details>
  <summary>Answer</summary>
  
The RakutenAuth login option is for third-party. For example, apps outside Rakuten do not use Rakuten login SDK (RID or RAE). Therefore, they can use the RakutenAuth login option. If your app is using Rakuten login SDK already, then you don't need to use the Rakuten auth login option
</details>

<br>

## Which API should I use to start/establish SDK session?

<details>
  <summary>Answer</summary>
  
The SDK has 2 APIs for starting sessions. <br>

If you log in with IDSDK/UserSDK (RID/RAE),
```
RakutenReward.shared.startSession(appCode: "ExampleAppcode", accessToken: "Example API-C Token", completion: { result in }
```

Otherwise, if you're using Third Party login (non-Rakuten login),
```
RakutenReward.shared.startSession(appCode: "ExampleAppcode", completion: { result in }
```

</details>

<br>

---
LANGUAGE :
> [![ja](../lang/ja.png)](../ja/FAQ/FAQ.md)
