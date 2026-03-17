# JavaScript Extension

The JavaScript Extension (available from SDK v7.2.0) lets web pages loaded inside a native `WKWebView` call Reward SDK APIs directly via JavaScript.

This is useful when part of your app experience is web-based but you still want missions and portals to work seamlessly.

---

## How It Works

1. You configure the `WKWebViewConfiguration` with `RewardJS` before creating the web view.
2. The JavaScript library in the web page calls `missionsdk` extension methods.
3. The native SDK intercepts these calls and executes the corresponding iOS SDK API.

For the JavaScript side of the integration, see the [Rakuten Reward JS library](https://github.com/rakuten-ads/Rakuten-Reward-JS/tree/main/js-extension-library).

---

## iOS Setup

Call `setupWebView` before loading any content in the web view:

```swift
RewardJS.shared.setupWebView(
    appcode: "YOUR_APP_CODE",
    domain: "yourdomain.com",
    config: webViewConfiguration,
    completion: { result in
        switch result {
        case .success:
            // Configuration succeeded — create your WKWebView with this config
        case .failure(let error):
            // RewardJSError
        }
    }
)
```

### Parameters

| Parameter | Description |
|---|---|
| `appcode` | Your application key from the Rakuten Reward Developer Portal |
| `domain` | The domain of the web page that implements the JS extension |
| `config` | The `WKWebViewConfiguration` you will use to create your `WKWebView` |
| `completion` | Callback returning `Result<Void, RewardJSError>` |

---

## Supported APIs

The following Reward SDK APIs can be triggered from JavaScript:

| JavaScript call | Native equivalent |
|---|---|
| `missionsdk.logAction(...)` | `RakutenReward.shared.logAction` |
| `missionsdk.openSDKPortal()` | `RakutenReward.shared.openPortal` |
| `missionsdk.openSpsPortal()` | `RakutenReward.shared.openSpsPortal` |
