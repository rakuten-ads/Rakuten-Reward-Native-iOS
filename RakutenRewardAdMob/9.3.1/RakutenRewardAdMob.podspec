Pod::Spec.new do |s|
    s.name              = 'RakutenRewardAdMob'
    s.version           = '9.3.1'
    s.summary           = 'Google AdMob adapter for the Rakuten Reward SDK — shows interstitial ads on SPS point success.'
    s.homepage          = 'https://developer.reward.rakuten.co.jp/'
    s.author            = 'SDK team, Core Platform Section, Rakuten Asia Pte. Ltd.'
    s.license           = { :type => 'Commercial', :text => 'Copyright © Rakuten Asia Pte. Ltd. All Rights Reserved.' }
    s.user_target_xcconfig = { 'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'YES', 'ENABLE_USER_SCRIPT_SANDBOXING' => 'NO' }
    s.platform          = :ios
    s.source            = { :http => 'https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS/releases/download/9.3.1/RakutenRewardAdMob.xcframework.zip' }
    s.swift_versions        = ['5.0']
    s.ios.deployment_target = '14.0'
    s.ios.vendored_frameworks = ['RakutenRewardAdMob.xcframework']

    s.dependency 'RakutenRewardNativeSDK', '~> 9.3'
    s.dependency 'Google-Mobile-Ads-SDK', '~> 12.14'
end
