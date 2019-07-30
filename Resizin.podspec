Pod::Spec.new do |s|
  s.name             = 'Resizin'
  s.version          = '0.4.0'
  s.summary          = 'Resizin iOS SDK'
  s.description      = <<-DESC
Manipulate with images
                       DESC
  s.homepage         = 'https://github.com/AckeeCZ/Resizin-iOS-SDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Mísař' => 'misar.jan@gmail.com' }
  s.source           = { :git => 'https://github.com/AckeeCZ/Resizin-iOS-SDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files     = 'Resizin/Classes/**/*.swift'
  s.swift_version    = '5.0'
end
