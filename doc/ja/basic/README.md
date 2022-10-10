[TOP](../README.md#top)　>基本ガイド

コンテンツ
* [リージョンの設定](#リージョンの設定)<br>
* [認証](#認証)<br>
  * [ログインオプション](#ログインオプション)<br>
  * [ログイン](#ログイン)<br>
  * [ログアウト](#ログアウト)<br>
* [SDKを初期化する](#SDKを初期化する)<br>
* [楽天メンバー情報を取得する](#楽天メンバー情報を取得する)<br>
* [ミッションの達成](#mission-achievement)<br>
* [SDK ポータル](#SDK-ポータル)<br>
* [広告ポータル](#広告ポータル)<br><br>


# リージョンの設定
SDK 2.1のバージョンより, 複数のリージョンでのサポートをしております。  
現在(2021/02)、日本と台湾をサポートしております。

日本の場合
```Swift
RakutenReward.shared.region = RakutenRewardRegion.JP
```

台湾の場合
```Swift
RakutenReward.shared.region = RakutenRewardRegion.TW
```

1つのアプリで1つのリージョンを選択してください

# 認証
## ログインオプション

リワードSDKでは3種類のログインを用意しております、環境に合わせてご利用ください
<br>

| ログインオプション | 説明 | サポート |
| --- | --- | --- |
| RakutenAuth | 初期設定、ログインに関する処理はSDKから提供されます | 日本、台湾 |
| RID | 楽天のログインSDKを使って、RIDでログインする場合はこのオプションを使用します、 SDKにAPIトークンを設定する必要があります | 日本 |  
| RAE | 楽天のログインSDKを使って、RAEでログインする場合はこのオプションを使用します、 SDKにトークンを設定する必要があります | 日本 |
<br>

### ログインオプションの切り替え
初期設定では、ログインオプションは RakutenAuth　になっております
<br>

### RakutenAuth
```swift
RakutenReward.shared.tokenType = TokenType.RakutenAuth
```
<br>

### RID

SDKのAPIを使用するのに、トークンタイプをセットする必要があります  

```swift
RakutenReward.shared.tokenType = TokenType.RID
```

startSession を呼び出します

```swift
RakutenReward.shared.startSession(appCode: "Your App Key", accessToken: <Access token>, completion: { r in
    if case .success(let user) =r {  // use portal or use additional setup
  }
}
```
**バージョン3.3.１から、ユーザーがログアウト時にトークンやデータをちゃんと消すためにログアウトAPIを呼ぶのが必要です。** <br>
[ログアウト](#ログアウト) に参照
<br><br>


### RAE

SDKのAPIを使用するのに、トークンタイプをセットする必要があります

```swift
RakutenReward.shared.tokenType = TokenType.RAE
```

startSession を呼び出します

```swift
RakutenReward.shared.startSession(appCode: "Your App Key", accessToken: <Access token>, completion: { r in
    if case .success(let user) =r {  // use portal or use additional setup
  }
}
```
**バージョン3.3.１から、ユーザーがログアウト時にトークンやデータをちゃんと消すためにログアウトAPIを呼ぶのが必要です。** <br>
[ログアウト](#ログアウト) に参照
<br><br>


## ログイン

ログインページを開きます。楽天のログインSDKを使用する場合は必要ありません。
<br>

```swift
RakutenReward.shared.openLoginPage({result in 
    switch result:
    case .dismissByUser: // resume in another time
    case .LogInCompleted: // starting session
    case .failToShowLoginPage: // presenting problem
  }) 
```

![Login](Login.PNG)
<br>

## ログアウト

ユーザーログアウト: 

```swift
RakutenReward.shared.logout { }
```
<br>

---
# SDKを初期化する
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
| token | APIトークン |

# ログインページを表示し、SDKを初期化する
1. ログインの状態をチェックする, 
2. ログインページを表示する
3. SDKを初期化する

```swift
if RakutenReward.shared.isLogin() {
  RakutenReward.shared.startSession(appCode: <#appcode#>, completion:<#callback#>) 
} else {
  RakutenReward.shared.openLoginPage({_ in 
    // SDKセッションを開始
  }) 
}
```
<br>

## 楽天メンバー情報を取得する　

### ユーザーの名前を取得する

```swift
RakutenReward.shared.user?.getName()
```

### ユーザーの会員ランク楽天ポイントを取得する

```swift
RakutenReward.shared.user?.currentPointRank()
```

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
| Banner_50 | SDK が提供する Banner_50 UI を表示する
| Banner_250 | SDK が提供する  Banner_250 UI を表示する
| UIなし | UIを表示しません

## SDK ポータル
ユーザーにリワードサービスの情報(ミッションや進捗、ポイントなど)を伝えるために
楽天リワードSDKではポータルというのを提供しております
このポータルを表示するにはポータル表示のAPIを呼ぶ必要があります

こちらがSDKポータルのイメージになります

![Portal1](Portal1.PNG?)

![Portal2](Portal2.PNG?)

![Portal3](Portal3.PNG?)

![Portal4](Portal4.PNG?)

![Portal5](Portal5.PNG?)

## 広告ポータル
Ad Portal API は SDKバージョン3.1.0 からご利用可能です(JP のみ)
<br>

Open Ad Portal API を呼んでください
```swift
RakutenReward.shared.openPortal(completionHandler: { result in
    // Handle success or fail to open portal
})
```

こちらが 広告ポータルのユーザーインターフェースになります:

![AdPortal1](AdPortal1.png)

<br>

---
言語 :
> [![en](../../lang/en.png)](../../basic/README.md)
