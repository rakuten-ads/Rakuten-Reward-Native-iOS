# JavaScript Extension

The JavaScript Extension (available from SDK v7.2.0) lets web pages loaded inside a native `WKWebView` call Reward SDK APIs directly via JavaScript.

This is useful when part of your app experience is web-based but you still want missions and portals to work seamlessly.

---

## How It Works

1. Create your `WKWebView` and pass it to `RewardJS.shared.setupWebView`.
2. The JavaScript library in the web page calls `missionsdk` extension methods.
3. The native SDK intercepts these calls and executes the corresponding iOS SDK API.

For the JavaScript side of the integration, see the [Rakuten Reward JS library](https://github.com/rakuten-ads/Rakuten-Reward-JS/tree/main/js-extension-library).

---

## iOS Setup

Create your `WKWebView` first, then call `setupWebView` before loading any content:

```swift
let webView = WKWebView(frame: .zero)

RewardJS.shared.setupWebView(
    appcode: "YOUR_APP_CODE",
    domain: "yourdomain.com",
    webview: webView
) { result in
    switch result {
    case .success:
        // Setup succeeded — load your content
        webView.load(URLRequest(url: yourURL))
    case .failure(let error):
        // RewardJSError
    }
}
```

### Parameters

| Parameter | Description |
|---|---|
| `appcode` | Your application key from the Rakuten Reward Developer Portal |
| `domain` | The domain of the web page that implements the JS extension |
| `webview` | The `WKWebView` instance to configure |
| `completion` | Callback returning `Result<Void, RewardJSError>` on the main thread |

### RewardJSError

| Case | Description |
|---|---|
| `invalidAppcode` | The app code is empty or invalid |
| `failToGetTimeInterval` | Could not generate a cookie expiry time |
| `failToCreateCookie` | Cookie creation failed |
| `failToEncodeAppcode` | App code percent-encoding failed |
| `unknown` | An unexpected error occurred |

---

## Supported APIs

The following Reward SDK APIs can be triggered from JavaScript:

| JavaScript call | Native equivalent |
|---|---|
| `missionsdk.logAction(...)` | `RakutenReward.shared.logAction` |
| `missionsdk.openSDKPortal()` | `RakutenReward.shared.openPortal` |
| `missionsdk.openSpsPortal()` | `RakutenReward.shared.openSpsPortal` |
| `missionsdk.getUserRewardPoint()` | `RakutenReward.shared.getCurrentMonthPoints` |
| `missionsdk.getPointHistory()` | `RakutenReward.shared.getPointHistory` |
| `missionsdk.getLSProcessingPoint(...)` | `RakutenReward.shared.getLSProcessingPoint` |
| `missionsdk.getLSPointHistory(...)` | `RakutenReward.shared.getLSPointHistory` |
