# 利用規約への同意

v5.0.0 から、SDKの機能を利用する前にユーザーが楽天リワードの利用規約およびプライバシーポリシーへの同意が必要になりました。このガイドでは同意の取得と処理方法を説明します。

---

## 仕組み

- SDKはユーザーが同意していない場合、ステータスを `.userNotConsent` に変更します。
- **SDKは自動的に同意UIを表示しません。** アプリが適切なタイミングで `requestForConsent()` を呼び出す必要があります。
- `openPortal()` は例外で、ポータルを開く前に同意を内部で処理します。

---

## 同意のリクエスト

適切なタイミング（ログイン後や `.userNotConsent` ステータスを検知した時など）に同意ダイアログを表示します：

```swift
RakutenReward.shared.requestForConsent { status in
    switch status {
    case .consentProvided:
        // ユーザーが同意しました — 通常通り処理を進めます
    case .consentNotProvided:
        // ユーザーが同意せずに閉じました
    case .consentFailed:
        // API エラー — 再試行するかユーザーに通知してください
    case .consentProvidedRestartSessionFailed:
        // 同意はされましたが、セッションの再起動に失敗しました — initSdk を再試行してください
    case .consentUIAlreadyPresented:
        // ダイアログはすでに表示中です — 無視してください
    }
}
```

ユーザーがすでに同意している場合はダイアログを表示せず、即座に `.consentProvided` が返ります。このメソッドはいつでも安全に呼び出せます。

---

## 同意通知バナー

あまり邪魔にならない方法として、ユーザーがタップすると同意ダイアログを開くバナーを表示できます：

```swift
RakutenReward.shared.showConsentBanner { status in
    // 上記と同じ RakutenRewardConsentStatus の値
}
```

バナーは同意がまだ提供されていない場合のみ表示されます。すでに同意済みの場合はバナーを表示せず、即座に `.consentProvided` が返ります。

---

## 同意が必要なタイミングの検知

SDKステータスの変更を監視する方法が推奨されます：

```swift
RakutenReward.shared.didUpdateStatus = { status in
    if status == .userNotConsent {
        RakutenReward.shared.requestForConsent { consentStatus in
            // consentStatus を処理する
        }
    }
}
```

---

## 同意コールバック

同意フロー中にUIを調整する必要がある場合は、以下を購読してください：

```swift
RakutenReward.shared.didPresentConsentUI = {
    // 同意ダイアログが表示されました
}

RakutenReward.shared.didDismissConsentUI = {
    // 同意ダイアログが閉じられました
}
```

---

## ほとんどの SDK API はオンラインステータスが必要

ほとんどの SDK API はステータスが `.online` でない場合に失敗します。`.userNotConsent` の状態でAPIを呼び出す場合は、先に同意確認を行ってください：

```swift
func performActionIfReady() {
    guard RakutenReward.shared.status == .online else {
        RakutenReward.shared.requestForConsent { status in
            if status == .consentProvided {
                RakutenReward.shared.logAction(actionCode: "code") { _ in }
            }
        }
        return
    }
    RakutenReward.shared.logAction(actionCode: "code") { _ in }
}
```

---

## 同意ステータス一覧

| ステータス | 説明 |
|---|---|
| `consentProvided` | ユーザーが利用規約に同意しました |
| `consentNotProvided` | ユーザーがまだ同意していません |
| `consentUIAlreadyPresented` | ダイアログが現在表示中です |
| `consentFailed` | API エラーが発生しました |
| `consentProvidedRestartSessionFailed` | 同意されましたが、セッション再起動に失敗しました |

---

## テスト

開発段階でこの機能をテストするには、テストアカウントの Easy ID を Reward SDK チームに提供してホワイトリスト登録を依頼してください。

---

> [![en](../images/en.png)](../user-consent.md) English version
