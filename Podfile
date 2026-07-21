source 'https://github.com/danielcano75/Specs.git'

platform :ios, '17.0'

target 'BookStore' do
  use_frameworks!

  pod 'Networking', '~> 1.0'
  pod 'DataStorage', '~> 1.0'

  target 'BookStoreTests' do
    inherit! :search_paths
    pod 'Networking', '~> 1.0'
    pod 'DataStorage', '~> 1.0'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'NO'
    end
  end
end
