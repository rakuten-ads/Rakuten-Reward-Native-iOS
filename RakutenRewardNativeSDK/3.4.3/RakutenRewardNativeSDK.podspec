Pod::Spec.new do |s|  
    s.name              = 'RakutenRewardNativeSDK'
    s.version           = '3.4.3'
    s.summary           = 'Integrate RakutenRewardNativeSDK and getting monetization with Reward Mission, Reward Ads'
    s.homepage          = 'https://developer.reward.gl.rakuten.co.jp/main/'
    s.author            = 'SDK team, Core Platform Section, Rakuten Asia Pte. Ltd.'
    s.license           = { :type => 'Commercial', :text => 'Copyright © Rakuten Asia Pte. Ltd. All Rights Reserved.' }
    s.user_target_xcconfig = { 'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'YES' }
    s.platform          = :ios
    s.source            = { :http => 'https://github.com/rakuten-ads/Rakuten-Reward-Native-iOS/releases/download/3.4.3/RakutenRewardNativeSDK-3.4.3.xcframework.zip' }
    s.ios.deployment_target = '11.0'
    s.ios.vendored_frameworks = 'RakutenRewardNativeSDK.xcframework'
end
