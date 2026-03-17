# Changelog

---

## 9.1.0
**Released:** 2026-03-12 · Xcode 26.2 · Swift 6.x · iOS 14+

- Fix: Mission notification banner not displaying correctly in page sheet
- Fix: Added error UI on SPS home page

---

## 9.0.0
**Released:** 2026-01-30 · Xcode 26.2 · Swift 6.x · iOS 14+

- **New:** `MissionTokenProvider` protocol for automatic token management
  - SDK now handles token expiry internally — no more manual `.tokenExpired` handling
  - No need to wait for `.online` status before calling SDK APIs
  - `initSdk(appCode:tokenType:tokenProvider:)` replaces manual `startSession` calls
  - `startSession` APIs still work but do not benefit from automatic token management
- Built with Xcode 26.2

See [Migration to v9](migration-to-v9.md) for upgrade steps.

---

## 8.7.1
**Released:** 2025-11-06 · Xcode 16.2 · Swift 6.x

- Improvement: Support 3-digit action count in SDK Portal (previously truncated)

---

## 8.7.0
**Released:** 2025-09-11 · Xcode 16.2 · Swift 6.x

- Improvement: Minor UI updates
- Bug fix: SDK portal text translations not working on iOS 18.1.x
- Bug fix: Debounce added to SPS Portal "more" page collapsible menus

---

## 8.6.0
**Released:** 2025-07-15 · Xcode 16.2 · Swift 6.x

- **New:** Maintenance mode — SDK reports `SDKError.onMaintenanceMode` when server is under maintenance
- Update: Onboarding screen image refresh
- Update: Onboarding popup behaviour aligned with Android
- Fix: SPS mode settings UI — English text truncated
- Fix: Removed share button from Point History screen

---

## 8.5.0
**Released:** 2025-06-19 · Xcode 16.2 · Swift 6.x

- **Breaking:** `openSpsPortal` now requires an explicit `rzCookie` parameter
- Fix: `openSpsPortal` now correctly returns a callback in all error flows
- All public API completion handlers are now called on the main thread
- Fix: Removed shadow from SPS home page menu
- Fix: Panda animation no longer obscures the point earned text
- Fix: SPS lockscreen ad — tapping an external link no longer incorrectly closes the webview

---

## 8.4.1
**Released:** 2025-05-20 · Xcode 16.2 · Swift 6.x

- Fix: SPS Portal no longer shows "out of budget" message for ads that already granted points

---

## 8.4.0
**Released:** 2025-04-29 · Xcode 16.2 · Swift 6.x

- **Breaking:** Minimum iOS raised to 14.0
- Fix: Portal mini-browser "Done" button incorrectly shown when points not yet granted
- Fix: Mission point history screen — top area was accidentally tappable
- Fix: SPS/Mission tabs in portal could be selected multiple times

---

## 8.3.1
**Released:** 2025-03-03 · Xcode 16.x · Swift 6.x

- New: Back button added to SPS mini browser

---

## 8.3.0
**Released:** 2025-02-27 · Xcode 16.x · Swift 6.x

- **Deprecation notice:** RAE token support deprecated. RAE will be abolished in 2025. Migrate to RID.
- Bug fixes

---

## 8.2.1
**Released:** 2025-02-20 · Xcode 16.x · Swift 6.x

- Bug fixes

---

## 8.2.0
**Released:** 2025-01-16 · Xcode 16.x · Swift 6.x

- New: Coupon Ad support
- Minor UI fixes

---

## 8.1.1
**Released:** 2025-02-20 · Xcode 16.x · Swift 6.x

- Bug fixes

---

## 8.1.0
**Released:** 2024-12-04 · Xcode 16.x · Swift 6.x

- New: `RewardConfiguration.setAppLanguage(_:)` — force a UI language at runtime
- Bug fixes

---

## 8.0.1
**Released:** 2025-01-31 · Xcode 16.x · Swift 6.x · iOS 13+

- Bug fixes

---

## 8.0.0
**Released:** 2024-10-30 · Xcode 16.x · Swift 6.x

- Xcode 16 support
- SPS: Opt-out Mission feature
- SPS Portal: Korean, Traditional Chinese, Simplified Chinese localisation

---

## 7.2.0
**Released:** 2024-10-17 · Xcode 15.x · Swift 5.9

- **New:** JavaScript Extension — trigger SDK APIs from web pages in a `WKWebView`. See [JavaScript Extension](js-extension.md).

---

## 7.1.0
**Released:** 2024-09-26 · Xcode 15.x · Swift 5.9

- New: `getMissionLiteList` and `getMissionDetails` APIs
- Improvement: SDK label text
- New: Korean and Simplified Chinese localisation
- Fix: Incorrect locale text on iOS 18

---

## 7.0.0
**Released:** 2024-08-28 · Xcode 15.x · Swift 5.9

- **New:** Super Point Screen (SPS) feature. See [SPS guide](sps.md).

---

## 6.4.0
**Released:** 2024-06-10 · Xcode 15.x · Swift 5.9 · iOS 12+

- New: `SDKError.missionReachedCap`
- New: `SDKError.sdkStatusUserNotConsent`
- Bug fixes: User consent callbacks

---

## 6.3.0
**Released:** 2024-03-21 · Xcode 15.x · Swift 5.9 · iOS 12+

- New: `showConsentBanner` API
- Removed: IDFA-related APIs
- New: Privacy Manifest added
- Bug fixes

---

## 6.2.0
**Released:** 2024-01-11 · Xcode 15.x · Swift 5.9 · iOS 12+

- Minimum iOS raised to 12
- Removed Poikatsu tab from SDK Portal
- New: `SDKError.missionReachedCap`
- Bug fixes

---

## 6.1.0
**Released:** 2023-12-28 · Xcode 15.x · Swift 5.9 · iOS 11+

- Removed deprecated APIs
- New `startSession` overload with explicit `tokenType` parameter

---

## 6.0.0
**Released:** 2023-11-16 · Xcode 15.x · Swift 5.9 · iOS 11+

- Updated unclaimed info message in SDK Portal
- Bug fixes

---

## 5.1.0
**Released:** 2023-09-13 · Xcode 14.x · Swift 5.7.x · iOS 11+

- New: `RewardConfiguration.raCookie` for Ra cookie support
- Bug fixes

---

## 5.0.0
**Released:** 2023-07-28 · Xcode 14.x · Swift 5.7.x · iOS 11+

- **New:** User Consent feature. See [User Consent](user-consent.md).

---

## 4.1.0
**Released:** 2023-07-14 · Xcode 14.x · Swift 5.7.x · iOS 11+

- SDK Portal: Unclaimed list sorting
- SDK Portal: Tap mission item to view details
- Deprecated Ad Portal APIs

---

## 4.0.0
**Released:** 2023-04-20 · Xcode 14.x · Swift 5.7.x · iOS 11+

- Bug fixes

---

## 3.6.1
**Released:** 2023-03-30 · Xcode 13.x · Swift 5.6 · iOS 11+

- Bug fixes

---

## 3.6.0
**Released:** 2023-02-09 · Xcode 13.x · Swift 5.6 · iOS 11+

- New: Poikatsu in SDK Portal
- Updated Claim UI
- Bug fixes

---

## 3.5.2
**Released:** 2022-11-25 · Xcode 13.x · Swift 5.6 · iOS 11+

- Removed Taiwan Region support
- Bug fixes

---

## 3.5.1
**Released:** 2022-10-25 · Xcode 13.x · Swift 5.5 · iOS 11+

- Rakuten Ichiba App support
- Removed Taiwan Region support
- Bug fixes

---

## 3.5.0
**Released:** 2022-10-10 · Xcode 13.x · Swift 5.5 · iOS 11+

- New mission achievement notification type

---

## 3.4.5
**Released:** 2022-08-19 · Xcode 13.x · Swift 5.5 · iOS 11+

- Added fraud detection
- New APIs: `setCustomDomain` / `setCustomPath` for staging

---

## 3.4.4
**Released:** 2022-07-28 · Xcode 13.x · Swift 5.5 · iOS 11+

- SDK consistency improvements

---

## 3.4.3
**Released:** 2022-07-06 · Xcode 13.x · Swift 5.5 · iOS 11+

- Apple Silicon (M1) support
- Restored Event Analytics feature

---

## 3.4.2
**Released:** 2022-06-10 · Xcode 13.x · Swift 5.5 · iOS 11+

- Fix: Claim date formatting

---

## 3.4.1
**Released:** 2022-06-08 · Xcode 13.x · Swift 5.5 · iOS 11+

- Fix: Japan calendar format

---

## 3.4.0
**Released:** 2022-06-03 · Xcode 13.x · Swift 5.5 · iOS 11+

- New: Taiwan ad support
- New: `UnclaimedItem.achieveddatestr` (string format)
- Bug fixes

---

## 3.3.2
**Released:** 2022-05-05 · Xcode 13.x · Swift 5.5 · iOS 11+

- Rakuten Ichiba App support
- Bug fixes

---

## 3.3.1
**Released:** 2022-04-12 · Xcode 13.x · Swift 5.5 · iOS 11+

- Fix: Xcode 13.3 compiler error
- **Important:** Apps using ID SDK or User SDK must now call `logout()` when the user signs out
- Bug fixes

---

## 3.3.0
**Released:** 2022-03-07 · Xcode 13.x · Swift 5.5 · iOS 11+

- New: Ichiba Deeplink on point claim
- New: Event Analytics integration
- New: Ad links open in Safari
- Bug fixes

---

## 3.2.0
**Released:** 2022-01-28 · Xcode 13.x · Swift 5.5 · iOS 9+

- UI improvements for portal and claim screens

---

## 3.1.0
**Released:** 2022-01-11 · Xcode 13.x · Swift 5.5 · iOS 9+

- New: Ad Portal feature (Japan only)

---

## 3.0.0 – 3.0.2
**Released:** 2021-10 to 2021-12 · Xcode 13.x · Swift 5.5 · iOS 9+

- UI/UX bug fixes

---

## 2.3.0 – 2.3.1
**Released:** 2021-09 to 2021-11 · Xcode 12.x · Swift 5.3 · iOS 9+

- Bug fixes

---

## 2.2.0 – 2.2.1
**Released:** 2021-05 to 2021-07 · Xcode 12.x · Swift 5.3 · iOS 9+

- New: Rp / Rz cookie support
- New: Objective-C public API
- Fix: Ads handling and action code save logic

---

## 2.1.0 – 2.1.1
**Released:** 2021-03 · Xcode 12.x · Swift 5.3 · iOS 9+

- Taiwan first release
- Fix: Point history API

---

## 2.0.0
**Released:** 2020-10-30 · Xcode 12 · Swift 5.2 · iOS 9+

- New: RakutenAuth built-in login service
- New: `openLoginPage`, `isLogin`, `SDKUser.pointRank`

---

## 1.1.0
**Released:** 2020-06-18 · Xcode 11 · Swift 5.1 · iOS 9+

- New: User SDK (RAE) token support
- Swift evolution improvements

---

## 1.0.0
**Released:** 2020-02-21 · Xcode 11 · Swift 5.1 · iOS 9+

- Initial release with Rakuten ID SDK (RID) support
