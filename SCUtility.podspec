#
# Be sure to run `pod lib lint SCUtility.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SCUtility"
  s.version          = "1.0.9"
  s.summary          = "SCUtility pod library"
  s.description      = <<-DESC
                       Update Podspec of SCUtility

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/JianlinZhu/SCUtility"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Jarry" => "jarry@sucang.cn" }
  s.source           = { :git => "https://github.com/JianlinZhu/SCUtility.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  
  s.source_files = 'Pod/**/*.{h,m}'

  non_arc_files = 'Pod/Utility/JSONKit/JSONKit.{h,m}'
  s.exclude_files = non_arc_files
  s.subspec 'no-arc' do |sp|
    sp.source_files = non_arc_files
    sp.requires_arc = false
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
  s.dependency 'AFNetworking'
end
