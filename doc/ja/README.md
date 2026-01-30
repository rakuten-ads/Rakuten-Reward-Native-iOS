<div id="top"></div>

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/ios/)
![iOS](http://img.shields.io/badge/support-iOS_13+-blue.svg?style=flat)
![Xcode](http://img.shields.io/badge/IDE-Xcode_14+-blue.svg?style=flat)

# Rakuten Reward SDK ネイティブ

---
# はじめに

<div id="prerequisites"></div>

## 前提

* Use Xcode 16 以上
* iOS SDK 18　以上
* 楽天 IDSDK もしくは SDKが用意するログインを使用する


| Version        | Minimum OS           | Compile OS
--- | --- | ---
|1.0.0|9|13|
|1.1.0|9|13|
|1.0.2|9|13|
|1.0.3|9|13|
|1.0.4|9|14|
|2.0.0|9|14|
|2.1.0|9|14|
|2.1.1|9|14|
|2.2.0|9|14|
|2.2.1|9|14|
|2.3.0|9|14|
|2.3.1|9|14|
|3.0.0|9|15|
|3.0.1|9|15|
|3.0.2|9|15|
|3.1.0|9|15|
|3.2.0|9|15|
|3.3.0|11|15|
|3.3.1|11|15|
|3.3.2|11|15|
|3.4.0|11|15|
|3.4.1|11|15|
|3.4.2|11|15|
|3.4.3|11|15|
|3.4.4|11|15|
|3.4.5|11|15|
|3.5.0|11|15|
|3.5.1|11|15|
|3.5.2|11|15|
|3.6.0|11|15|
|3.6.1|11|15|
|4.0.0|11|16|
|4.1.0|11|16|
|5.0.0|11|16|
|5.1.0|11|16|
|6.0.0|11|17|
|6.1.0|11|17|
|6.2.0|12|17|
|6.3.0|12|17|
|6.4.0|12|17|
|7.0.0|13|17|
|7.1.0|13|17|
|7.2.0|13|17|
|8.0.0|13|18|
|8.0.1|13|18|
|8.1.0|13|18|
|8.1.1|13|18|
|8.2.0|13|18|
|8.2.1|13|18|
|8.3.0|13|18|
|8.3.1|13|18|
|8.4.0|14|18|
|8.4.1|14|18|
|8.5.0|14|18|
|8.6.0|14|18|
|8.7.0|14|18|
|8.7.1|14|18|
|8.8.0|14|18|
|8.8.1|14|18|
|9.0.0|14|26|

<div id="import_sdk"></div>

## Reward SDKをインポートする

### Use Cocoapods
```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS.git'

target '' do
pod 'RakutenRewardNativeSDK', '9.0.0'
end

```

### Swift Package Manager (SPM) を利用する場合

以下の依存関係を追加する

```
dependencies: [
    .package(url: "https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS-SPM", .exact("9.0.0")),
]
```

### Carthage の場合

プロジェクトの Cartfile を開き、 Reward Native SDK の依存関係を追加する

```
binary "https://raw.githubusercontent.com/rakuten-ads/Rakuten-Reward-Native-iOS/master/CarthageSpec.json" == 9.0.0
```

carthage を実行して Reward Native SDK をダウンロードする(XCFramework)

```bash
carthage update --platform ios --use-xcframeworks
```

アプリケーションのプロジェクトワークスペースを開く

Carthage でのビルドバイナリをドラッグ＆ドロップし Embedded に加える
<br>

## Usage
[基本ガイド](./basic/README.md)  
[APIガイド](./APIReference/README.md)<br>
[利用規約への同意について](./UserConsent/README.md)<br>
[FAQ](./FAQ/FAQ.md)
<br>

[基本ガイド (Objective-c)](../Objective-C/ja/basic/README.md)  
[APIガイド (Objective-c)](../Objective-C/ja/APIReference/README.md)<br>
[FAQ (Objective-c)](../Objective-C/ja/FAQ/FAQ.md)

## 更新履歴
[更新履歴](./history/README.md)

---
LANGUAGE :
> [![en](../lang/en.png)](../../README.md)
