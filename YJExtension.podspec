
Pod::Spec.new do |s|

  s.name         = "YJExtension"
  s.version      = "0.0.6"
  s.summary      = "这是个小框架的简短描述"

  s.description  = "这里要写详细的描述，上面写简短的就可以"

  s.homepage     = "https://github.com/feng562925462/YJExtension"

  # s.license      = "MIT"
s.license          = { :type => 'MIT', :file => 'LICENSE' }
  

  s.author             = { "odreamboy" => "562925462@qq.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/feng562925462/YJExtension.git", :tag => "0.0.6" }

  s.source_files  = "YJExtensionDemo/YJExtensionDemo/YJExtension/**/*.{h,m}"
end
