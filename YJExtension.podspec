
Pod::Spec.new do |s|

  s.name         = "YJExtension"
  s.version      = "1.0.0"
  s.summary      = "常用分类框架"

  s.description  = "开发中常用的分类集合，协助你快速开发"

  s.homepage     = "https://github.com/feng562925462/YJExtension"

  # s.license      = "MIT"
s.license          = { :type => 'MIT', :file => 'LICENSE' }
  

  s.author             = { "odreamboy" => "562925462@qq.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/feng562925462/YJExtension.git", :tag => s.version }

  s.source_files  = "YJExtensionDemo/YJExtensionDemo/YJExtension/**/*.{h,m}"
end
