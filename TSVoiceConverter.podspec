#
# Be sure to run `pod lib lint TSVoiceConverter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TSVoiceConverter"
  s.version          = "0.1.0"
  s.summary          = "A Swift VoiceConverter between AMR format and WAV format"
  s.homepage         = "https://github.com/hilen/TSVoiceConverter"
  s.license          = 'MIT'
  s.author           = { "Hilen" => "hilenkz@gmail.com" }
  s.source           = { :git => "https://github.com/hilen/TSVoiceConverter.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = false
  s.source_files = 'Sources/**/*'
  s.vendored_libraries = "Sources/**/*.a"
end
