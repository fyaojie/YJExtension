
Pod::Spec.new do |spec|

  spec.name         = "YJExtension"
  spec.version      = "1.4.1"
  spec.summary      = "常用分类框架"

  spec.description  = "开发中常用的分类集合，协助你快速开发"

  spec.homepage     = "https://github.com/0dreamboy/YJExtension"

  # s.license      = "MIT"
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  

  spec.author       = { "odreamboy" => "562925462@qq.com" }

  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/0dreamboy/YJExtension.git", :tag => spec.version }

  spec.source_files  = "YJExtension/*.{h,m}"

  spec.subspec 'Foundation' do |basic|

    basic.source_files = 'YJExtension/Foundation/*.{h,m}'

    basic.subspec 'NSArray' do |obj|
      obj.source_files = 'YJExtension/Foundation/NSArray/*.{h,m}'
      obj.public_header_files = 'YJExtension/Foundation/NSArray/*.{h}'
    end

    basic.subspec 'NSAttributedString' do |obj|
      obj.source_files = 'YJExtension/Foundation/NSAttributedString/*.{h,m}'
      obj.public_header_files = 'YJExtension/Foundation/NSAttributedString/*.{h}'
    end

    basic.subspec 'NSData' do |obj|
      obj.source_files = 'YJExtension/Foundation/NSData/*.{h,m}'
      obj.public_header_files = 'YJExtension/Foundation/NSData/*.{h}'
    end

    basic.subspec 'NSDate' do |obj|
      obj.source_files = 'YJExtension/Foundation/NSDate/*.{h,m}'
      obj.public_header_files = 'YJExtension/Foundation/NSDate/*.{h}'
    end

    basic.subspec 'NSDictionary' do |obj|
      obj.source_files = 'YJExtension/Foundation/NSDictionary/*.{h,m}'
      obj.public_header_files = 'YJExtension/Foundation/NSDictionary/*.{h}'
    end

    basic.subspec 'NSNumber' do |obj|
      obj.source_files = 'YJExtension/Foundation/NSNumber/*.{h,m}'
      obj.public_header_files = 'YJExtension/Foundation/NSNumber/*.{h}'
    end

    basic.subspec 'NSObject' do |obj|
      obj.source_files = 'YJExtension/Foundation/NSObject/*.{h,m}'
      obj.public_header_files = 'YJExtension/Foundation/NSObject/*.{h}'
    end

    basic.subspec 'NSString' do |obj|
      obj.source_files = 'YJExtension/Foundation/NSString/*.{h,m}'
      obj.public_header_files = 'YJExtension/Foundation/NSString/*.{h}'
    end

  end

  spec.subspec 'UIKit' do |basic|

    basic.source_files = 'YJExtension/UIKit/*.{h,m}'

    basic.subspec 'UIApplication' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIApplication/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIApplication/*.{h}'
    end
    
    basic.subspec 'UIBarButtonItem' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIBarButtonItem/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIBarButtonItem/*.{h}'
    end

    basic.subspec 'UIButton' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIButton/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIButton/*.{h}'
    end

    basic.subspec 'UIColor' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIColor/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIColor/*.{h}'
    end

    basic.subspec 'UIControl' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIControl/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIControl/*.{h}'
    end

    basic.subspec 'UIDevice' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIDevice/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIDevice/*.{h}'
    end

    basic.subspec 'UIImage' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIImage/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIImage/*.{h}'
    end

    basic.subspec 'UIImageView' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIImageView/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIImageView/*.{h}'
    end

    basic.subspec 'UILabel' do |obj|
      obj.source_files = 'YJExtension/UIKit/UILabel/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UILabel/*.{h}'
    end

    basic.subspec 'UINavigationController' do |obj|
      obj.source_files = 'YJExtension/UIKit/UINavigationController/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UINavigationController/*.{h}'
    end

    basic.subspec 'UIResponder' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIResponder/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIResponder/*.{h}'
    end

    basic.subspec 'UITextField' do |obj|
      obj.source_files = 'YJExtension/UIKit/UITextField/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UITextField/*.{h}'
    end
    
    basic.subspec 'UITextView' do |obj|
      obj.source_files = 'YJExtension/UIKit/UITextView/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UITextView/*.{h}'
    end

    basic.subspec 'UIView' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIView/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIView/*.{h}'
    end

    basic.subspec 'UIWindow' do |obj|
      obj.source_files = 'YJExtension/UIKit/UIWindow/*.{h,m}'
      obj.public_header_files = 'YJExtension/UIKit/UIWindow/*.{h}'
    end

  end

end
