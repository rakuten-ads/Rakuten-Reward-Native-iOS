# JavaScript 拡張機能

JavaScript 拡張機能（SDK v7.2.0 以降）を使うと、ネイティブの `WKWebView` に読み込まれた Web ページから JavaScript 経由で Reward SDK の API を呼び出せます。

アプリの一部が Web ベースでありながら、ミッションやポータルをシームレスに動作させたい場合に便利です。

---

## 仕組み

1. `WKWebView` を作成し、`RewardJS.shared.setupWebView` に渡します。
2. Web ページの JavaScript ライブラリが `missionsdk` 拡張機能のメソッドを呼び出します。
3. ネイティブ SDK がこれらの呼び出しを受け取り、対応する iOS SDK API を実行します。

JavaScript 側の実装については、[Rakuten Reward JS ライブラリ](https://github.com/rakuten-ads/Rakuten-Reward-JS/tree/main/js-extension-library/ja) を参照してください。

---

## iOS 側のセットアップ

最初に `WKWebView` を作成し、コンテンツを読み込む前に `setupWebView` を呼び出してください：

```swift
let webView = WKWebView(frame: .zero)

RewardJS.shared.setupWebView(
    appcode: "YOUR_APP_CODE",
    domain: "yourdomain.com",
    webview: webView
) { result in
    switch result {
    case .success:
        // セットアップ成功 — コンテンツを読み込む
        webView.load(URLRequest(url: yourURL))
    case .failure(let error):
        // RewardJSError
    }
}
```

### パラメーター

| パラメーター | 説明 |
|---|---|
| `appcode` | 楽天リワード SDK 開発者ポータルのアプリケーションキー |
| `domain` | JS 拡張機能が実装されている Web ページのドメイン |
| `webview` | 設定対象の `WKWebView` インスタンス |
| `completion` | メインスレッドで `Result<Void, RewardJSError>` を返すコールバック |

### RewardJSError

| ケース | 説明 |
|---|---|
| `invalidAppcode` | アプリコードが空または無効 |
| `failToGetTimeInterval` | クッキーの有効期限を生成できなかった |
| `failToCreateCookie` | クッキーの作成に失敗した |
| `failToEncodeAppcode` | アプリコードのパーセントエンコードに失敗した |
| `unknown` | 予期しないエラーが発生した |

---

## サポートされている API

以下の Reward SDK API を JavaScript から呼び出せます：

| JavaScript 呼び出し | ネイティブの対応 |
|---|---|
| `missionsdk.logAction(...)` | `RakutenReward.shared.logAction` |
| `missionsdk.openSDKPortal()` | `RakutenReward.shared.openPortal` |
| `missionsdk.openSpsPortal()` | `RakutenReward.shared.openSpsPortal` |
| `missionsdk.getUserRewardPoint()` | `RakutenReward.shared.getCurrentMonthPoints` |
| `missionsdk.getPointHistory()` | `RakutenReward.shared.getPointHistory` |
| `missionsdk.getLSProcessingPoint(...)` | `RakutenReward.shared.getLSProcessingPoint` |
| `missionsdk.getLSPointHistory(...)` | `RakutenReward.shared.getLSPointHistory` |

---

> [![en](../../../docs/doc/lang/en.png)](../js-extension.md) English version
