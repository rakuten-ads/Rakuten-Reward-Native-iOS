# Objective-C Guide

This guide covers integrating the Rakuten Reward Native SDK from Objective-C. The SDK exposes a set of `Objc`-suffixed methods specifically for Objective-C compatibility.

> `MissionTokenProvider` is a Swift `async/await` protocol and is **not available in Objective-C**. Use the `startSession` APIs described below.

---

## Token Type

```objc
// Choose your token type
RakutenReward.shared.tokenType = TokenTypeRid;       // RID (recommended)
RakutenReward.shared.tokenType = TokenTypeRae;       // RAE (deprecated)
RakutenReward.shared.tokenType = TokenTypeRakutenAuth; // SDK-provided login
```

---

## Initialization

### RID or RAE (External Token)

```objc
[RakutenReward.shared startSessionObjcWithAppCode:@"YOUR_APP_CODE"
                                      accessToken:@"YOUR_ACCESS_TOKEN"
                                        tokenType:TokenTypeRid
                                       completion:^(SDKUserObject * _Nullable user,
                                                    RewardSDKSessionErrorObjc * _Nullable error) {
    if (error != nil) {
        // Handle error
        return;
    }
    // Session started successfully
}];
```

### RakutenAuth (SDK Login)

```objc
if (RakutenReward.shared.isLogin) {
    [RakutenReward.shared startSessionObjcWithAppCode:@"YOUR_APP_CODE"
                                          completion:^(SDKUserObject * _Nullable user,
                                                       RewardSDKSessionErrorObjc * _Nullable error) {
        // Handle result
    }];
} else {
    [RakutenReward.shared openLoginPage:^(enum LoginPageCompletion completion) {
        switch (completion) {
            case LoginPageCompletionLogInCompleted:
                // Start session here
                break;
            case LoginPageCompletionDismissByUser:
                break;
            case LoginPageCompletionFailToShowLoginPage:
                break;
        }
    }];
}
```

---

## Logout

```objc
[RakutenReward.shared logoutWithCompletion:^{ }];
```

---

## User Information

```objc
SDKUserObject *user = [RakutenReward.shared getUserObjc];

NSString *name    = [user getName];
id pointRank      = [user currentPointRank]; // MemberPointRankObject
```

---

## Logging Actions

```objc
[RakutenReward.shared logActionObjcWithActionCode:@"YOUR_ACTION_CODE"
                                       completion:^(NSError * _Nullable error) {
    if (error != nil) {
        // Handle error
    }
    // Success
}];
```

---

## Mission Lists

```objc
// Full list with progress
[RakutenReward.shared getMissionListWithProgressObjcWithCompletion:
    ^(NSArray<MissionObject *> * _Nullable missions, NSError * _Nullable error) {
    // Use missions
}];

// Lite list
[RakutenReward.shared getMissionLiteListObjcWithCompletion:
    ^(NSArray<MissionLiteObject *> * _Nullable missions, NSError * _Nullable error) {
    // Use missions
}];

// Single mission
[RakutenReward.shared getMissionDetails:@"ACTION_CODE"
                             completion:^(MissionObject * _Nullable mission, NSError * _Nullable error) {
    // Use mission
}];
```

---

## Unclaimed Missions & Claiming

```objc
[RakutenReward.shared getUnclaimedMissionWithCompletion:
    ^(NSArray<UnclaimedItemObject *> * _Nullable items, NSError * _Nullable error) {
    for (UnclaimedItemObject *item in items) {
        [RakutenReward.shared claimObjcWithUnclaimedItemObject:item
                                                   completion:^(PointClaimScreenEventObjc * _Nonnull event) {
            if ([event isKindOfClass:[PointClaimScreenEventObjcDidClaimSuccessfully class]]) {
                // Claimed
            }
        }];
    }
}];
```

---

## Portals

```objc
// SDK Portal
[RakutenReward.shared openPortalObjc:^(SDKErrorObjc * _Nullable error) {
    if (error != nil) { /* Handle error */ }
}];

// SPS Portal
[RakutenReward.shared openSpsPortalWithRzCookie:@"YOUR_RZ_COOKIE"
                              completionHandler:^(SDKErrorObjc * _Nullable error) {
    if (error != nil) { /* Handle error */ }
}];
```

---

## User Consent

```objc
[RakutenReward.shared requestForConsent:^(enum RakutenRewardConsentStatus status) {
    if (status == RakutenRewardConsentStatusConsentProvided) {
        // Proceed
    }
}];
```

---

## Custom Mission Notification UI

```objc
RakutenReward.shared.didUpdateUnclaimedAchievementObjc = ^(UnclaimedItemObject * _Nonnull item) {
    if ([item.notificationType isKindOfClass:[NotificationTypeObjcCUSTOM class]] &&
        RewardConfiguration.isUserSettingUIEnabled &&
        !RewardConfiguration.isPortalPresent) {
        // Show your custom UI on the main thread
    }
};
```

---

## Cookies

```objc
RewardConfiguration.rpCookie = @"your_rp_cookie";
RewardConfiguration.rzCookie = @"your_rz_cookie";
RewardConfiguration.raCookie = @"your_ra_cookie";
```

---

## Event Analytics

```objc
[RakutenMissionEvent.shared logActionWithEventCode:@"EVENT_CODE"
                                 eventTrackingType:RakutenMissionEventTrackingTypeRatSpecificEvent
                                        parameters:nil
                                 completionHandler:^(NSError * _Nullable error) {
    if (error != nil) { /* Handle error */ }
}];
```

---

## API Reference

### RakutenReward — Objective-C Methods

| Method | Description |
|---|---|
| `getVersion` | Returns SDK version string |
| `startSessionObjcWithAppCode:accessToken:tokenType:completion:` | Start session (v6.1.0+) |
| `startSessionObjcWithAppCode:accessToken:completion:` | Start session (pre-v6.1.0) |
| `startSessionObjcWithAppCode:completion:` | Start session for RakutenAuth |
| `openLoginPage:` | Show SDK login UI |
| `isLogin` | Check login status |
| `logoutWithCompletion:` | Log out |
| `getUserObjc` | Get current user (`SDKUserObject`) |
| `logActionObjcWithActionCode:completion:` | Log a mission action |
| `getMissionListWithProgressObjcWithCompletion:` | Fetch missions with progress |
| `getMissionLiteListObjcWithCompletion:` | Fetch missions lite |
| `getMissionDetails:completion:` | Fetch single mission |
| `getUnclaimedMissionWithCompletion:` | Fetch unclaimed items |
| `claimObjcWithUnclaimedItemObject:completion:` | Claim points |
| `claimObjcWithUnclaimedItemObject:enableIchibaCallback:completion:` | Claim with Ichiba deeplink |
| `loadMemberInfoRankObjc:` | Load points & rank |
| `getPointHistoryObjcWithCompletion:` | Get point history |
| `getLSPointHistoryWithRequestData:offset:limit:completion:` | Link Share point history |
| `getLSProcessingPointWithRequestData:completion:` | Link Share processing point |
| `openPortalObjc:` | Open SDK Portal |
| `openSpsPortalWithRzCookie:completionHandler:` | Open SPS Portal |
| `openSupportPageObjcWithPage:` | Open support page |
| `requestForConsent:` | Request user consent |
| `showConsentBanner:` | Show consent banner |

### Configuration — Objective-C

All `RewardConfiguration` properties are available in Objective-C with the same names, plus:
- `[RewardConfiguration getTheme]`
- `[RewardConfiguration setTheme:AppThemePanda]` / `AppThemeSimple`
- `[RewardConfiguration setCustomDomain:@"..."]`
- `[RewardConfiguration setCustomPath:@"..."]`
- `[RewardConfiguration setAppLanguage:@"en"]`

### Status Enums (Objective-C Names)

**RakutenRewardStatus:**
`RakutenRewardStatusOnline` · `RakutenRewardStatusOffline` · `RakutenRewardStatusAppcodeInvalid` · `RakutenRewardStatusTokenExpired` · `RakutenRewardStatusUserNotConsent`

**RakutenRewardConsentStatus:**
`RakutenRewardConsentStatusConsentProvided` · `...ConsentNotProvided` · `...ConsentUIAlreadyPresented` · `...ConsentFailed` · `...ConsentProvidedRestartSessionFailed`

**TokenType:**
`TokenTypeRid` · `TokenTypeRae` · `TokenTypeRakutenAuth`

**SupportPage:**
`SupportPageHelp` · `SupportPageTermsCondition` · `SupportPagePrivacyPolicy` · `SupportPageSpsTermsCondition` · `SupportPageSpsPrivacyPolicy`

**PointClaimScreenEventObjc:**
`...WillPresent` · `...DidFailToShow` · `...DidDismiss` · `...DidSelfDismiss` · `...DidDismissByUser` · `...DidFailToClaim` · `...DidClaimSuccessfully` · `...DidTriggerIchibaDeeplink`

### Error Types (Objective-C Names)

**RewardSDKSessionErrorObjc:**
`...UserNotFound` · `...AppcodeInvalid` · `...BundleError` · `...LoginRequired` · `...InvalidTokenType` · `...CannotRetrieveSessionToken` · `...CannotLogOutOnServer`

**RPGRequestError (Objective-C):**
`RPGRequestErrorObjcTokenExpire` · `...ServerError` · `...BadRequest` · `...LegalReason`

**SDKErrorObjc:**
`SDKErrorObjcNoMissionFound` · `...MissionReachedCap` · `...NoUnclaimedItemFound` · `...SessionNotInitialized` · `...FeatureDisabledByUser` · `...SDKStatusNotOnline` · `...SDKStatusUserNotConsent` · `...CheckIsSpsUserError` · `...UnexpectedError` · `...SpsFeatureIsDisabled` · `...SpsRegisterUserDidNotFinish` · `...SpsRegisterUserError` · `...OnMaintenanceMode`
