#
# Be sure to run `pod lib lint LMCircularScrollingFlowLayout.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LMCircularScrollingFlowLayout"
  s.version          = "0.1.0"
  s.summary          = "LMCircularScrollingFlowLayout is a UICollectionViewFlowLayout subclass that provides circular/wrapped scrolling in a UICollectionView."
  s.description      = <<-DESC
LMCircularScrollingFlowLayout is a UICollectionViewFlowLayout subclass that provides circular (wrapped, infinite) scrolling behavior in a UICollectionView.

Just use in place of UICollectionViewFlowLayout when setting the layout on your collection views. You can select it as the UICollectionViewFlowLayout subclass in interface builder.

Works fine with all the standard flow layout features, including multiple sections and multiple lines in a section. Works well with scrollview paging enabled or disabled.


NOTE: This layout hasn't been tested with some of the new auto-cell sizing features included with iOS 8.0 yet. If you try it out, I'd like to hear if it works or not.
                       DESC
  s.homepage         = "https://github.com/lintmachine/LMCircularScrollingFlowLayout"
  s.license          = 'MIT'
  s.author           = { "cdann" => "cdann@lintmachine.com" }
  s.source           = { :git => "https://github.com/lintmachine/LMCircularScrollingFlowLayout.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lintmachine'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'LMCircularScrollingFlowLayout' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'
end
