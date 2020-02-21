<div id="top"></div>

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/ios/)
[![language](https://camo.githubusercontent.com/c26adc3630b1c213a4b3372979a3b805f7342746/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c616e67756167652d4f626a6563746976652d2d432d626c75652e737667)](https://developer.apple.com/documentation)
![iOS](http://img.shields.io/badge/support-iOS_9+-blue.svg?style=flat)
![Xcode](http://img.shields.io/badge/IDE-Xcode_11+-blue.svg?style=flat)

# Rakuten Reward SDK ネイティブ

---
# はじめに

<div id="prerequisites"></div>

## 前提

* Use Xcode X or higher
* Target iOS SDK level 9 or higher
* This SDK works with Rakuten ID SDK

| Version        | Minimum OS           | Compile OS
--- | --- | ---
|0.1.0|9|13|

<div id="import_sdk"></div>

## Reward SDKをインポートする
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
source 'https://github.com/rakuten-ads/Rakuten-RewardSDK-Native-iOS.git'

target '' do
pod 'RakutenRewardNativeSDK', '~> 1.0.0'
end

```


## Usage
[基本ガイド](./basic/README.md)  
[応用ガイド](./advanced/README.md)


---
LANGUAGE :
> [![en](../lang/en.png)](../../README.md)



