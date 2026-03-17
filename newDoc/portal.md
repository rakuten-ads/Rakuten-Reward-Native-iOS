# Portals

The SDK provides two portal experiences: the **SDK Portal** for mission and point management, and the **SPS Portal** for Super Point Screen ads.

---

## SDK Portal

The SDK Portal is a full-screen UI where users can:
- View their active missions and progress
- See unclaimed missions and claim points
- Review their point history and current point balance
- Manage SDK notification preferences

### Opening the SDK Portal

```swift
RakutenReward.shared.openPortal { result in
    switch result {
    case .success:
        break
    case .failure(let error):
        // SDKError — e.g. .sdkStatusNotOnline, .featureDisabledByUser
    }
}
```

> If the user has not provided consent, `openPortal` handles the consent flow automatically before presenting the portal.

### Detecting Portal Visibility

Some SDK features (such as custom mission notifications) should not appear while the portal is open. Check the flag:

```swift
if !RewardConfiguration.isPortalPresent {
    // Safe to show custom notification UI
}
```

Subscribe to portal visibility changes:

```swift
RakutenReward.shared.didUpdateIsPortalPresentedStatus = { isPresented in
    // Update your UI accordingly
}
```

---

## SPS Portal

The SPS (Super Point Screen) Portal displays ad content that allows users to earn SPS points. The portal includes a home screen, a mission screen, and a registration screen for non-SPS members.

> **Note:** The SPS feature must be enabled for your app by the SPS team. See [Super Point Screen (SPS)](sps.md) for the full setup guide.

### Opening the SPS Portal (v8.5.0+)

```swift
RakutenReward.shared.openSpsPortal(rzCookie: yourRzCookie) { result in
    switch result {
    case .success:
        break
    case .failure(let error):
        // SDKError — e.g. .spsFeatureIsDisabled, .sdkStatusNotOnline
    }
}
```

The `rzCookie` value is required from v8.5.0 onwards. Set it via:

```swift
RewardConfiguration.rzCookie = "your_rz_cookie_value"
```

Then pass the same value to `openSpsPortal(rzCookie:)`.

---

## Support Pages

Open SDK-hosted legal and help pages in the built-in mini browser:

```swift
// Help
RakutenReward.shared.openSupportPage(.help)

// Reward terms and conditions
RakutenReward.shared.openSupportPage(.termsCondition)

// Reward privacy policy
RakutenReward.shared.openSupportPage(.privacyPolicy)

// SPS terms and conditions
RakutenReward.shared.openSupportPage(.spsTermsCondition)

// SPS privacy policy
RakutenReward.shared.openSupportPage(.spsPrivacyPolicy)
```
