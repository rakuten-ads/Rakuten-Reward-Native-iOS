[TOP](../README.md#top)　>基本ガイド

---
# Initialize SDK
楽天リワードSDKを利用するにははじめに初期化が必要です(SDKユーザーの基本データを取得します) SDKの機能を利用するのにはRakutenRewardクラスのメソッドを利用します

```swift
RakutenReward.shared.startSession(appCode: "Your App Key", accessToken: <Access token>, completion: { r in
    if case .success(let user) =r {  // use portal or use additional setup
  }
}
```

| パラメータ名        | 説明           
| --- | --- 
| appCode | アプリケーションキー (楽天リワードSDKの開発者ポータルより取得)
| token | Access token to access Reward SDK API-C API |

## IDSDKを使う
1. ID SDKを使ってログインをする
2. CATよりアクセストークンを取得する 
3. リワードSDKに上記のアクセストークンをセットする
4. SDK初期化する

このSDKを利用するにはID SDKの利用が必須です(2020/01)

このSDKではUser SDKでのログインもサポートしております(2020/06)。  
詳細に関しましては、SDKの担当にお問い合わせください。

---
# ミッションの達成 
ミッションを達成するには、開発者はアクションAPIをコールします
ミッション達成後、ミッション達成UIが表示されます 

## アクションを送信する
```swift
RakutenReward.shared.logAction(actionCode: "<actionCode>", completionHandler: { actionResult in })
```
actionCode は開発者ポータルより取得します 

## ミッション達成UI
ユーザーがミッションを達成すると、下記のようなミッション達成UIが表示されます
楽天リワードではモーダルとバナーを用意しております

![Modal](Modal.PNG)     ![Banner](Banner.PNG)

### ミッション達成UIの種類
楽天リワードSDKは4つの種類のミッション達成の種類があります
モーダル、バナー、UIなし、カスタム
これらの設定は開発者ポータルから設定できます

| ミッション達成UIの種類        | 説明
| --- | ---
| モーダル | モーダルUIを表示する
| バナー | バナーUIを表示する
| カスタム | 開発者が自由にUIを作成できます
| UIなし | UIを表示しません

## SDK Portal
ユーザーにリワードサービスの情報(ミッションや進捗、ポイントなど)を伝えるために
楽天リワードSDKではポータルというのを提供しております
このポータルを表示するにはポータル表示のAPIを呼ぶ必要があります

こちらがSDKポータルのイメージになります

![Portal1](Portal1.png)

![Portal2](Portal2.png)

![Portal3](Portal3.png)

![Portal4](Portal4.png)

![Portal5](Portal5.png)

---
言語 :
> [![en](../../lang/en.png)](../../basic/README.md)
