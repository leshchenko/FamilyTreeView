#
# Be sure to run `pod lib lint FamilyTreeView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LKFamilyTreeView'
  s.version          = '1.0'
  s.summary          = 'Interesting family tree view'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Nice way of displaying family tree in your iOS app.
                       DESC

  s.homepage         = 'https://github.com/leshchenko/FamilyTreeView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = { 'Ruslan Leshchenko' => 'leshchenkoruua@gmail.com' }
  s.source           = { :git => 'https://github.com/leshchenko/FamilyTreeView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'FamilyTreeView/FamilyTree/**'

  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
