[TOP](../../README.md#top) > 拡張機能    

# JavaScript 拡張機能    
ネイティブアプリケーションでは、ページがWebベースでネイティブのWebViewに表示されるページがいくつかあります。  
このライブラリは、WebページからSDK APIをトリガーするユースケースのために作成されました。 

# SDKの設定  
このガイドはiOSの実装ガイドです。JavaScriptの実装ガイドについては、[こちら](https://github.com/rakuten-ads/Rakuten-Reward-JS/tree/main/js-extension-library/ja)を参照してください。

## SDK のサポート  
この機能はバージョン7.2.0からサポートされています

## 初期化  
この機能を初期化するために、以下のAPIを呼び出します。  

```Swift  
RewardJS.shared.setupWebView(
    appcode: "appcode",
    domain: "domain",
    config: <WKWebViewConfiguration>,
    completion: <(Result<Void, RewardJSError>) -> Void>
)
```  
| パラメータ | 説明 |
| --- | --- |
| appCode | アプリケーションキー (こちらは楽天リワードの開発者ポータルから取得できます) |
| domain | `missionsdk-ext` が実装されているWebページのドメイン |
| config | WebView インスタンスの WKWebViewConfiguration |
| completion | 成功した場合はvoidを返し、失敗した場合はRewardJSErrorを返すコールバック |  

## サポートされているAPI
現在、この拡張機能は以下のAPIをサポートしています:
* `RakutenReward.logAction`
* `RakutenReward.openSDKPortal`  
* `RakutenReward.openSpsPortal`

---
言語 :
> [![en](../../lang/en.png)](../../extension/README.md) 