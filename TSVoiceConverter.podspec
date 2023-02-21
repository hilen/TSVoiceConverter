#
# Be sure to run `pod lib lint TSVoiceConverter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TSVoiceConverter"
  s.version          = "0.1.7"
  s.summary          = "A Swift VoiceConverter between AMR format and WAV format"
  s.homepage         = "https://github.com/hilen/TSVoiceConverter"
  s.license          = 'MIT'
  s.author           = { "Hilen" => "hilenkz@gmail.com" }
  s.source           = { :git => "https://github.com/hilen/TSVoiceConverter.git", :tag => s.version.to_s }
  s.platform     = :ios, '13.0'
  s.requires_arc = true
  s.source_files = ['Sources/**/*.{h,mm}','Sources/*.{h,mm}','Sources/TSVoiceConverter.swift']
  s.vendored_frameworks = "Sources/**/*.xcframework"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
end
