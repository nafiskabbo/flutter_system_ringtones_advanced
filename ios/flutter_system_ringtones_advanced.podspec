#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_system_ringtones_advanced.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_system_ringtones_advanced'
  s.version          = '1.0.0'
  s.summary          = 'Retrieve system ringtones, alarms, and notification sounds.'
  s.description      = <<-DESC
Retrieve system ringtones, alarms, and notification sounds on Android and iOS (WIP).
                       DESC
  s.homepage         = 'https://github.com/nafiskabbo/flutter_system_ringtones_advanced'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Nafis Kabbo' => 'nafiskabbo30@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'flutter_system_ringtones_advanced/Sources/flutter_system_ringtones_advanced/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
  }
  s.swift_version = '5.0'
end
