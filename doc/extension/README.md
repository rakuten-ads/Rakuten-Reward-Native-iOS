[TOP](../../README.md#top) > Extension  

# JavaScript Extension    
In native application there would be some pages where the page is web-based and display in a native WebView. This API is built for the usecase where SDK API to be triggered from a webpage. 

# SDK Setup
This guide focus on the integration for iOS. Please refer [here](https://github.com/rakuten-ads/Rakuten-Reward-JS/tree/main/js-extension-library) for the implementation guide on JavaScript.   

## SDK Version
This feature is supported starting from version 7.2.0

## Initialization  
Call the following API to initialize this feature:  

```Swift  
RewardJS.shared.setupWebView(
    appcode: "appcode",
    domain: "domain",
    config: <WKWebViewConfiguration>,
    completion: <(Result<Void, RewardJSError>) -> Void>
)
```  
| Parameter | Desc |
| --- | --- |
| appcode | Application Key (This is from Rakuten Reward Developer Portal) |
| domain | The domain of the webpage where `missionsdk extension` is implemented |
| config | WKWebViewConfiguration of your webview |
| completion | callback which return no object if successful, and RewardJSError if failed |  

## Supported API
Currently this extension support the following APIs:
* `RakutenReward.shared.logAction`
* `RakutenReward.shared.openSDKPortal`  
* `RakutenReward.shared.openSpsPortal`

---
LANGUAGE :
> [![jp](../lang/ja.png)](../ja/extension/README.md)  
