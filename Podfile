# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Clapbacks' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for Clapbacks

end

target 'MessagesExtension' do
  pod 'Firebase'
  pod 'BuddyBuildSDK'
  pod 'Firebase/Storage'
  pod 'FirebaseDatabase'
  use_frameworks!
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        end
    end
end
