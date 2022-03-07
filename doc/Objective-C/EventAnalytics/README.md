[TOP](../../../README.md#top)　>　Event Analytics

Table of Contents
* [Event Analytics function Overview](#event-analytics-function-overview)
* [Import Event Analytics Module](#import-event-analytics-module)
* [Enable Event Analytics function](#enable-event-analytics-function)
* [Convert Analytics SDK Event to Mission Event](#convert-analytics-sdk-event-to-mission-event)

---
# Event Analytics function Overview
Mission SDK provides new function named "Event Analytics" with Analytics SDK.<br>
This function main purpose is to enhance App Event Analysis function + Encourage Mission SDK use.<br><br>
We provide following function<br>
* Can see Event Analytics Dashboard in Mission SDK Dashboard (Enhance App Event Analytics)
* Convert Analytics SDK Event to Mission Event

# Import Event Analytics Module
To use Event Analytics function, please import following module<br>

Cocoapod
```cocoapod
pod 'RAnalytics', :source => 'https://github.com/rakutentech/ios-analytics-framework.git'
```

Swift Package Manager
```SPM
SSH: git@github.com:rakutentech/ios-analytics-framework.git
HTTPS: https://github.com/rakutentech/ios-analytics-framework.git
```

# Enable Event Analytics function
Set enable Event Analytics feature

```objc
RewardConfiguration.isMissionEventFeatureEnabled = true;
```

# Convert Analytics SDK Event to Mission Event
This is new function with Analytics SDK<br>
Developers can set Event Mapping data using developer portal<br>

## Use Case
* At first, add Analytics Event to your app (analysis purpose event) with Event Analytics API (mission SDK)
* If you want to add this event as incentive mission, you can switch Mission SDK Event in Developer Portal
* After switch, this Event becomes both Analytics SDK and Mission SDK event

This is new API to realize this 
```objc
[RakutenMissionEvent.shared logActionWithEventCode:NSString
                                 eventTrackingType:RakutenMissionEventTrackingType
                                 parameters:(NSDictionary<NSString *, id> *Nullable)
                                 completionHandler:^(NSError * _Nullable)completionHandler];
```

Example,
```objc
[RakutenMissionEvent.shared logActionWithEventCode:@"exampleEventCode" eventTrackingType: RakutenMissionEventTrackingTypeGenericEvent parameters:NULL completionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
        // Error
        return;
    }

    // Success
}];
```

### Parameters
| Status | Summary |
| --- | --- |
| eventCode | Analytics SDK event code |
| eventTrackingType | RakutenMissionEventTrackingType / Analytics SDK tracking type |
| parameters (optional) | Analytics SDK parameters |

### Enum RakutenMissionEventTrackingType
| Type | Summary |
| --- | --- |
| RakutenMissionEventTrackingTypeGenericEvent | tracking generic event |
| RakutenMissionEventTrackingTypeRatSpecificEvent | tracking Analytics SDK specific event |

<br>Analytics SDK references: https://documents.developers.rakuten.com/ios-sdk/analytics-9.1/

<br>This API works
* If mission conversion is missing, send Analytics SDK Event 
* If mission conversion setting exists in Mission SDK Dashboard (Analytics SDK action name ↔  Mission actioncode mapping),  Send both event Analytics SDK and Mission SDK


LANGUAGE :
> [![ja](../../lang/ja.png)](../ja/EventAnalytics/README.md)
