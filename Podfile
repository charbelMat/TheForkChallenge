platform :ios, '12.0'
source "https://github.com/CocoaPods/Specs.git"

use_frameworks!

def mandatory_pods
  pod 'RealmSwift'
  pod 'Alamofire', '~> 5.5'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'SDWebImage'
end

def secondary_pods

end

target 'The Fork' do
    mandatory_pods
    secondary_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5.5'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
    end
end
