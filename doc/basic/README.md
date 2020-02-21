[TOP](../../README.md#top)　>　Basic Guide

---
# Initialize SDK
To use Reward SDK, need to establish SDK session first (to collect SDK user's basic information)

Call startSession method with parameters


```swift
RakutenReward.shared.startSession(appCode: "Your App Key", accessToken: <Access token>, completion: { r in
    if case .success(let user) =r {  // use portal or use additional setup
  }
}
```

| Parameter name        | Description           
| --- | --- 
| appCode | Application Key (This is from Rakuten Reward Developer Portal) 
| token | Access token to access Reward SDK API-C API |

## Initialization Flow with IDSDK
1. Login with ID SDK
2. Get Access token from CAT API 
3. Set access token to Reward SDK
4. Initialize Reward SDK

---
# Mission Achievement 
To achieve mission, developers need to call post action API.  
After avhieving the mission, notification will be shown.  

## Post Action
```swift
RakutenReward.shared.logAction(actionCode: "<actionCode>", completionHandler: { actionResult in })
```
actionCode is provided by Reward SDK Developer Portal.  

## Notification UI
The user achieved the mission, notification UI is shown.  
Reward SDK provides Modal and Banner UI

![Modal](Modal.PNG)     ![Banner](Banner.PNG)

### Notification Type
There  are 4 types of Mission Achievement UI. Modal, Banner, and No UI, and Custom which developed by developers.

You can decide type by Developer Portal 

| Notification Type        | UI
| --- | ---
| Modal | Show Modal UI provided by SDK
| Banner | Show Banner UI provided by SDK
| Custom | Developer can create UI by themselves
| No UI | Not show any UI

## SDK Portal
We provide User Portal UI for developers. To call Open SDK Portal API, developers can see user status (mission, unclaim list, current point, point history etc...)

This is UI Image

![Portal1](Portal1.PNG)

![Portal2](Portal2.PNG)

![Portal3](Portal3.PNG)

![Portal4](Portal4.PNG)

![Portal5](Portal5.PNG)

---
LANGUAGE :
> [![ja](../lang/ja.png)](../ja/basic/README.md)
