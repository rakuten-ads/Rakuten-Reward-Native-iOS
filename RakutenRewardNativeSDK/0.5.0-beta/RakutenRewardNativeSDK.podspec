Pod::Spec.new do |s|
    s.name              = 'RakutenRewardNativeSDK'
    s.version           = '0.5.0-beta'
    s.homepage          = 'https://developer.reward.rakuten.co.jp/'
    s.author            = 'SDK team, Core Platform Section, Rakuten Asia Pte. Ltd.'
    s.license           = { :type => 'Commercial', :text => 'Copyright © Rakuten Asia Pte. Ltd. All Rights Reserved.' }
    s.user_target_xcconfig = { 'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'YES' }
    s.platform          = :ios
    s.summary           = 'Integrate RakutenRewardNativeSDK and getting monetization with Reward Mission, Reward Ads'
    s.source            = { :http => 'https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS/releases/download/8.3.0/RakutenRewardNativeSDKCombined.zip' }
    s.ios.vendored_frameworks = ["RakutenRewardNativeSDK.xcframework", "ScreenSDKCore.xcframework"]

    s.ios.deployment_target = '13.0'
    s.default_subspecs = 'Saas'
    
    s.subspec 'MissionOnly' do |sp|
        sp.ios.vendored_frameworks = ["RakutenRewardNativeSDK.xcframework"]
    end
    
    s.subspec 'WebSDKOnly' do |sp|
        sp.ios.vendored_frameworks = ["ScreenSDKCore.xcframework"]
    end
    
    s.subspec 'Saas' do |sp|
        sp.ios.vendored_frameworks = ["RakutenRewardNativeSDK.xcframework", "ScreenSDKCore.xcframework"]
    end
    
end
