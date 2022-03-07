[TOP](../../../README.md#top)　> イベントアナリティクス

コンテンツ
* [イベントアナリティクスの概要](#イベントアナリティクスの概要)
* [イベントアナリティクスモジュールの導入](#イベントアナリティクスモジュールの導入)
* [イベントアナリティクス機能をオンにする](#イベントアナリティクス機能をオンにする)
* [イベントアナリティクスのイベントをミッションイベントとしても送信する](#convert-analytics-sdk-event-to-mission-event)

---
# イベントアナリティクスの概要
ミッションSDKは新たな機能として"Event Analytics"を導入いたしました。<br>
この機能のメインはアプリケーションのイベントの分析機能を強化したものです。<br>
加えて、通常のアプリケーションのイベントをミッションイベントに変換する機能を通じてミッションSDKをより効果的に利用するための機能が含まれております。<br>


* イベントアナリティクス機能のダッシュボードを開発者ポータルで提供
* 通常のイベントをミッションイベントに変換する機能を提供

# イベントアナリティクスモジュールの導入
こちらの機能を使用するには以下のモジュールを追加します

Cocoapod
```cocoapod
pod 'RAnalytics', :source => 'https://github.com/rakutentech/ios-analytics-framework.git'
```

Swift Package Manager
```SPM
SSH: git@github.com:rakutentech/ios-analytics-framework.git
HTTPS: https://github.com/rakutentech/ios-analytics-framework.git
```

# イベントアナリティクス機能をオンにする
イベントアナリティクス機能を有効にセットする

```Objc
RewardConfiguration.isMissionEventFeatureEnabled = true;
```

# イベントアナリティクスのイベントをミッションイベントとしても送信する
こちらは新しい機能になります。<br>
開発者ポータルにて、イベントアナリティクスのイベントとミッションイベントに結びつける設定を行います。<br>

## 使い方
* はじめに、アナリティクスイベント(アクション分析用のイベント)を Mission SDKの
 API を経由して呼び出します。
* もし、アクション分析用のイベントをミッションイベントに紐付ける場合、開発者ポータルの設定でマッピングを作成します
* 紐付け後、 イベントは Analytics SDKと Mission SDKと両方のイベントが送信されます

イベントの送信
```objc
[RakutenMissionEvent.shared logActionWithEventCode:NSString
                                 eventTrackingType:RakutenMissionEventTrackingType
                                 parameters:(NSDictionary<NSString *, id> *Nullable)
                                 completionHandler:^(NSError * _Nullable)completionHandler];
```

例,
```objc
[RakutenMissionEvent.shared logActionWithEventCode:@"exampleEventCode" eventTrackingType: RakutenMissionEventTrackingTypeGenericEvent parameters:NULL completionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
        // Error
        return;
    }

    // Success
}];
```

### パラメーター
| ステータス | 説明 |
| --- | --- |
| eventCode | Analytics SDK のイベントコード |
| eventTrackingType | RakutenMissionEvent トラッキングタイプ / Analytics SDK トラッキングタイプ |
| parameters (optional) | Analytics SDK パラメーター |

### Enum RakutenMissionEventTrackingType
| トラッキングタイプ | 説明 |
| --- | --- |
| RakutenMissionEventTrackingTypeGenericEvent | 通常イベントのトラッキング |
| RakutenMissionEventTrackingTypeRatSpecificEvent | カスタムイベントのトラッキング |

<br>Analytics SDK  リファレンス: https://documents.developers.rakuten.com/ios-sdk/analytics-9.1/

この API は以下のように動作します
* もし、マッピングデータがない場合はAnalytics SDKのアクションのみ送信されます
* もし、マッピングデータがある場合はダッシュボードで定義されたミッションSDKのアクションも送信されます


---
言語 :
> [![en](../../../lang/en.png)](../../EventAnalytics/README.md)
