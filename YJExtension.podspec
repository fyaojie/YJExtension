#
# Be sure to run `pod lib lint YJExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/pods.html
#

Pod::Spec.new do |s|
  s.name             = 'YJExtension'
  s.version          = '1.5.4'
  s.summary          = '常用分类框架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  开发中常用的分类和工具集合，协助你快速开发
                       DESC

  s.homepage         = 'https://github.com/fyaojie/YJExtension'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fyaojie' => '562925462@qq.com' }
  s.source           = { :git => 'https://github.com/fyaojie/YJExtension.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, "9.0"

#  s.source_files = 'YJExtension/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YJExtension' => ['YJExtension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.source_files  = "YJExtension/Classes/*.{h,m}"

  s.subspec 'Foundation' do |basic|

    basic.source_files = 'YJExtension/Classes/Foundation/*.{h,m}'

    basic.subspec 'NSArray' do |obj|
      obj.source_files = 'YJExtension/Classes/Foundation/NSArray/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/Foundation/NSArray/*.{h}'
    end

    basic.subspec 'NSAttributedString' do |obj|
      obj.source_files = 'YJExtension/Classes/Foundation/NSAttributedString/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/Foundation/NSAttributedString/*.{h}'
    end

    basic.subspec 'NSData' do |obj|
      obj.source_files = 'YJExtension/Classes/Foundation/NSData/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/Foundation/NSData/*.{h}'
    end

    basic.subspec 'NSDate' do |obj|
      obj.source_files = 'YJExtension/Classes/Foundation/NSDate/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/Foundation/NSDate/*.{h}'
    end

    basic.subspec 'NSDictionary' do |obj|
      obj.source_files = 'YJExtension/Classes/Foundation/NSDictionary/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/Foundation/NSDictionary/*.{h}'
    end

    basic.subspec 'NSNumber' do |obj|
      obj.source_files = 'YJExtension/Classes/Foundation/NSNumber/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/Foundation/NSNumber/*.{h}'
    end

    basic.subspec 'NSObject' do |obj|
      obj.source_files = 'YJExtension/Classes/Foundation/NSObject/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/Foundation/NSObject/*.{h}'
    end

    basic.subspec 'NSString' do |obj|
      obj.source_files = 'YJExtension/Classes/Foundation/NSString/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/Foundation/NSString/*.{h}'
    end

  end

  s.subspec 'UIKit' do |basic|

    basic.source_files = 'YJExtension/Classes/UIKit/*.{h,m}'

    basic.subspec 'UIApplication' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIApplication/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIApplication/*.{h}'
    end
    
    basic.subspec 'UIBarButtonItem' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIBarButtonItem/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIBarButtonItem/*.{h}'
    end

    basic.subspec 'UIButton' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIButton/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIButton/*.{h}'
    end

    basic.subspec 'UIColor' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIColor/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIColor/*.{h}'
    end

    basic.subspec 'UIControl' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIControl/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIControl/*.{h}'
    end

    basic.subspec 'UIDevice' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIDevice/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIDevice/*.{h}'
    end

    basic.subspec 'UIImage' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIImage/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIImage/*.{h}'
    end

    basic.subspec 'UIImageView' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIImageView/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIImageView/*.{h}'
    end

    basic.subspec 'UILabel' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UILabel/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UILabel/*.{h}'
    end

    basic.subspec 'UINavigationController' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UINavigationController/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UINavigationController/*.{h}'
    end

    basic.subspec 'UIResponder' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIResponder/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIResponder/*.{h}'
    end

    basic.subspec 'UITextField' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UITextField/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UITextField/*.{h}'
    end
    
    basic.subspec 'UITextView' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UITextView/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UITextView/*.{h}'
    end

    basic.subspec 'UIView' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIView/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIView/*.{h}'
    end

    basic.subspec 'UIWindow' do |obj|
      obj.source_files = 'YJExtension/Classes/UIKit/UIWindow/*.{h,m}'
      obj.public_header_files = 'YJExtension/Classes/UIKit/UIWindow/*.{h}'
    end

  end

end
