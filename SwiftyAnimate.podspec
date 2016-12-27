Pod::Spec.new do |spec|
  spec.name         = "SwiftyAnimate"
  spec.version      = "1.0.1"
  spec.license      = "MIT" 
  spec.homepage     = "https://github.com/rchatham/SwiftyAnimate"
  spec.authors      = { "Reid Chatham" => "reid.chatham@gmail.com" }
  spec.summary      = "Swift animation"
  spec.source       = { :git => "https://github.com/rchatham/SwiftyAnimate.git", :tag => "#{spec.version}" }
  spec.platform     = :ios, "8.0"
  spec.source_files = "Sources/*"
end