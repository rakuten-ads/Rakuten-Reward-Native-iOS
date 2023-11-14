[TOP](../../../README.md#top)　>　FAQ

FAQ
* [Reward SDKはM1/arm64 simulator architectureをサポートしますか?](#reward-SDK-は-m1arm64-simulator-architectureをサポートしますか)<br>
* [カステムでミッションのノーティフィケーションを作りたい](#カステムでミッションのノーティフィケーションを作りたい)<br>
* [ミッション達成後はどのようにポイントをクレイムすれば良いですか？](#ミッション達成後はどのようにポイントをクレイムすれば良いですか)<br>
* [IDFAをRewardSDKにどのように設定すれば良いですか?](#idfaをrewardsdkにどのように設定すれば良いですか)<br>
* [開発/テストのために、ステージング環境にはアクセスできますか？](#開発テストのためにステージング環境にはアクセスできますか)<br>
* [IDSDKとJIDでログインはできますか？](#idsdkとjidでログインはできますか)<br>
* [Rakuten auth loginとはなんですか？](#rakuten-auth-loginとはなんですか)<br>
* [SDKのセッションをスタートさせるのにどのAPIを使用すれば良いですか？](#sdkのセッションをスタートさせるのにどのapiを使用すれば良いですか)<br>

# FAQ

## Reward SDKはM1/arm64 simulator architectureをサポートしますか？
<details>
  <summary>Answer</summary>
はい、バージョン3.4.3からM1 (arm64 simulator arch)をサポートします。

</details>

<br>

## カステムでミッションのノーティフィケーションを作りたい

<details>
  <summary>回答</summary>
  
例えば、 Mission A は 3 回のアクションを必要とします。
```
RakutenReward.shared.logAction(actionCode: "Example", completionHandler: { result in ... }
```

logAction API が3回呼ばれると Mission A は達成します。　アプリケーションは達成の delegate　を受け取ります。
```
// RakutenReward class
public var didUpdateUnclaimedAchievement: ((UnclaimedItem) -> Void)?
 
// 例
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in }
```

カスタムノーティフィケーションを表示する例
```
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in
    guard unclaimedItem.notificationType == .CUSTOM, // タイプを確認
          RewardConfiguration.isUserSettingUIEnabled, // ユーザのUI設定を確認
          !RewardConfiguration.isPortalPresent else { // ポータルにUIがないかどうかを確認する（ポータル上での表示はおすすめいたしません）
           
        return
    }
 
    // UIを Main スレッドで表示する
}
```
</details>

<br>

## ミッション達成後はどのようにポイントをクレイムすれば良いですか？

<details>
  <summary>回答</summary>
  
例えば、 Mission A は 3 回のアクションを必要とします。
```
RakutenReward.shared.logAction(actionCode: "Example", completionHandler: { result in ... }
```

logAction API が3回呼ばれると Mission A は達成します。　アプリケーションは達成の delegate　を受け取ります。
```
// RakutenReward class
public var didUpdateUnclaimedAchievement: ((UnclaimedItem) -> Void)?
 
// 例
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in }
```

RakutenReward shared objectの claim メソッドを呼ぶことでポイントをクレイムします。
```
RakutenReward.shared.didUpdateUnclaimedAchievement = { unclaimedItem in
    RakutenReward.shared.claim(unclaimedItem: unclaimedItem, completion: { pointClaimScreenEvent in }
}
```
</details>

<br>

## IDFAをRewardSDKにどのように設定すれば良いですか?

<details>
  <summary>回答</summary>
  
IDFA/Advertising ID は下記のAPIで設定できます。
```
RakutenReward.sharedInstance.advertisingID
```

例 
```
func updateRewardAdID() {
 
        if #available(iOS 14, *) {
 
            #if canImport(AppTrackingTransparency) &&  (arch(x86_64) || arch(arm64))
 
            if ATTrackingManager.trackingAuthorizationStatus == .authorized {
 
                RakutenReward.sharedInstance.advertisingID = ASIdentifierManager().advertisingIdentifier.uuidString
 
            }
 
            #endif
 
        }
 
}
```

IDFA取得のパーミッションをリクエストする
```
if #available(iOS 14, *) {
    #if canImport(AppTrackingTransparency) &&  (arch(x86_64) || arch(arm64))
 
    let permissionAlertAction = UIAlertAction(title: "IDFA permission", style: .default) { (_) in
        ATTrackingManager.requestTrackingAuthorization { [weak self] _ in
            self?.updateRewardAdID()
        }
    }
 
    alert.addAction(permissionAlertAction)
 
    #endif
}
```
</details>

<br>

## 開発/テストのために、ステージング環境にはアクセスできますか？

<details>
  <summary>回答</summary>
  
現在、開発/テストのために、ステージング環境は提供しておりません。<br/>
開発モードかもしくはテスト用のアカウントをご利用ください。
</details>

<br>

## IDSDKとJIDでログインはできますか？

<details>
  <summary>回答</summary>
  
IDSDK と JID でログインすることができます, その場合 tokenTypeをRIDに設定します。
```
// iOS の例
RakutenReward.shared.tokenType = TokenType.rid
```

API-Cのアクセストークンを　startSession API に渡します。
```
// iOS の例
 
RakutenReward.shared.startSession(appCode: "Your App Key", accessToken: <Access token>, completion: { r in
    if case .success(let user) = r { 
    }
}
```

</details>

<br>

## Rakuten auth loginとはなんですか？

<details>
  <summary>回答</summary>
  
RakutenAuth login オプションは楽天のログインをアプリで持っていらっしゃらないアプリケーション向けに提供しております(楽天のアプリケーションでログイン関連のSDKをご利用の場合はこちらを使用しなくても良いです)。
</details>

<br>

## SDKのセッションをスタートさせるのにどのAPIを使用すれば良いですか？

<details>
  <summary>回答</summary>
  
SDK では セッションをスタートさせるのに、2 つの API を用意しています。<br>

もし、IDSDK/UserSDK (RID/RAE)、をご使用の場合はこちら
```
RakutenReward.shared.startSession(appCode: "ExampleAppcode", accessToken: "Example API-C Token", completion: { result in }
```

その他の場合はこちらになります。
```
RakutenReward.shared.startSession(appCode: "ExampleAppcode", completion: { result in }
```

</details>

<br>

---
言語 :
> [![en](../../lang/en.png)](../../FAQ/FAQ.md)
