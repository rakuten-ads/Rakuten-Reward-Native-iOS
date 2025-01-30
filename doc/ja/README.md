<div id="top"></div>

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/ios/)
![iOS](http://img.shields.io/badge/support-iOS_13+-blue.svg?style=flat)
![Xcode](http://img.shields.io/badge/IDE-Xcode_14+-blue.svg?style=flat)

# Rakuten Reward SDK ネイティブ

---
# はじめに

<div id="prerequisites"></div>

## 前提

* Use Xcode 14 以上
* iOS SDK 13　以上
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
|8.2.0|13|18|

<div id="import_sdk"></div>

## Reward SDKをインポートする

*バージョン3.4.3からM1 (arm64 simulator arch)をサポートします。

### Framework をインポートする
Framework (RakutenRewardNativeSDK-{version}.framework)　をプロジェクトにインポートする  

"Embed and sign" を選択し、bitcodeを無効にする

ユニバーサルフレームワークを仕様する場合 .framework , は以下のコードを"Build phase" に加えます(実機用のipaを作成する際にユニバーサルフレームワークからはシミュレーター用のアーキテクトビルドを取り除くため) 

```
# This script loops through the SDK embedded in the application and removes simulator's architectures.

# Output environment variables
env > env.txt

# SDK search path for project source directory
APP_PATH_SRC="${PROJECT_DIR}"

# SDK search path for build destination directory
APP_PATH_DST="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

echo "APP_PATH_SRC: $APP_PATH_SRC"
echo "APP_PATH_DST: $APP_PATH_DST"

# Search SDK from destination path first. If not found, search from source path.
find "$APP_PATH_DST" "$APP_PATH_SRC" -name 'RakutenRewardNativeSDK.framework' -type d | while read -r FRAMEWORK
do
echo "FRAMEWORK: $FRAMEWORK"
FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

EXTRACTED_ARCHS=()

for ARCH in $ARCHS
do
echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
done

echo "Merging extracted architectures: ${ARCHS}"
lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
rm "${EXTRACTED_ARCHS[@]}"

echo "Replacing original executable with thinned version"
rm "$FRAMEWORK_EXECUTABLE_PATH"
mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

# If SDK was found in the first loop (destination path), no need to proceed to next loop.
break
done
```

### XCFrameworkをインポートする場合
Framework (RakutenRewardNativeSDK-{version}.xcframework) をプロジェクトにインポートします

### Use Cocoapods
```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS.git'

target '' do
pod 'RakutenRewardNativeSDK', '8.2.0'
end

```

### Swift Package Manager (SPM) を利用する場合

以下の依存関係を追加する

```
dependencies: [
    .package(url: "https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS-SPM", .exact("8.2.0")),
]
```

### Carthage の場合

プロジェクトの Cartfile を開き、 Reward Native SDK の依存関係を追加する

```
binary "https://raw.githubusercontent.com/rakuten-ads/Rakuten-Reward-Native-iOS/master/CarthageSpec.json" == 8.2.0
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
