# ポータル

SDKには2つのポータル体験が用意されています：ミッション・ポイント管理のための **SDK ポータル** と、Super Point Screen 広告のための **SPS ポータル** です。

---

## SDK ポータル

SDK ポータルはユーザーが以下を行えるフルスクリーン UI です：
- アクティブなミッションと進捗の確認
- 未クレイムのミッションを確認してポイントをクレイム
- ポイント履歴と現在のポイント残高の確認
- SDK通知の設定管理

### SDK ポータルを開く

```swift
RakutenReward.shared.openPortal { result in
    switch result {
    case .success:
        break
    case .failure(let error):
        // SDKError — 例: .sdkStatusNotOnline, .featureDisabledByUser
    }
}
```

> ユーザーがまだ同意していない場合、`openPortal` はポータルを表示する前に同意フローを自動で処理します。

### ポータルの表示状態の確認

カスタムミッション通知などの一部SDK機能は、ポータルが表示されている間は使用しない方がよいです。フラグを確認してください：

```swift
if !RewardConfiguration.isPortalPresent {
    // カスタム通知UIを表示しても安全
}
```

ポータルの表示状態の変更を購読します：

```swift
RakutenReward.shared.didUpdateIsPortalPresentedStatus = { isPresented in
    // UIを更新する
}
```

---

## SPS ポータル

SPS（Super Point Screen）ポータルは、ユーザーが SPS ポイントを獲得できる広告コンテンツを表示します。ホーム画面・ミッション画面・SPS 非会員向けの登録画面が含まれています。

> **注意：** SPS 機能はアプリごとに SPS チームによる有効化が必要です。完全なセットアップガイドは [Super Point Screen (SPS)](sps.md) を参照してください。

### SPS ポータルを開く（v8.5.0 以降）

```swift
RakutenReward.shared.openSpsPortal(rzCookie: yourRzCookie) { result in
    switch result {
    case .success:
        break
    case .failure(let error):
        // SDKError — 例: .spsFeatureIsDisabled, .sdkStatusNotOnline
    }
}
```

`rzCookie` パラメータは v8.5.0 から必須です。以下で設定できます：

```swift
RewardConfiguration.rzCookie = "your_rz_cookie_value"
```

---

## サポートページ

ヘルプや法的ページを SDK 組み込みのミニブラウザで開きます：

```swift
// ヘルプ
RakutenReward.shared.openSupportPage(.help)

// リワード利用規約
RakutenReward.shared.openSupportPage(.termsCondition)

// リワードプライバシーポリシー
RakutenReward.shared.openSupportPage(.privacyPolicy)

// SPS 利用規約
RakutenReward.shared.openSupportPage(.spsTermsCondition)

// SPS プライバシーポリシー
RakutenReward.shared.openSupportPage(.spsPrivacyPolicy)
```

---

> [![en](../images/en.png)](../portal.md) English version
