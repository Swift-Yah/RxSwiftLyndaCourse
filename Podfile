platform :ios, '10.0'

use_frameworks!

workspace 'RxSwiftLyndaCourse'

pod 'RxCocoa', '3.0.0-rc.1'
pod 'RxSwift', '3.0.0-rc.1'

target 'RxSwiftLyndaCourse' do
    pod 'AsyncSwift'
end

target 'BindUIElements' do
    project 'BindUIElements/BindUIElements.xcodeproj'

    pod 'RxDataSources', '1.0.0-rc.2'
    pod 'SwiftRandom'
    pod 'UIColor_Hex_Swift'
end

target 'BindUIElementsTests' do
    project 'BindUIElements/BindUIElements.xcodeproj'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'RxSwift'
            target.build_configurations.each do |config|
                if config.name == 'Debug'
                    config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
                end
            end
        end
    end
end
