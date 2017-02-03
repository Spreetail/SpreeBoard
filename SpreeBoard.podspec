# Be sure to run `pod lib lint SpreeBoard.podspec' to ensure this is a
# valid spec before submitting.

Pod::Spec.new do |s|
  s.name             = 'SpreeBoard'
  s.version          = '0.1.0'
  s.summary          = 'SpreeBoard is a plugin keyboard meant to be used when an HID device is connected to an iOS device, but an onscreen keyboard is still needed.'

  s.description      = <<-DESC
                        Problem: iOS doesn't allow on screen keyboards when an HID(Human Interface Device) is connected to the iOS device via bluetooth. Example: you need a Bluetooth UPC/Barcode Scanner connected, but also want to allow keyboard input on certain fields or views.

                        Solution: SpreeBoard acts as an alternate input source for input fields in your application. 
                       DESC

  s.homepage         = 'https://github.com/Trevor Poppen/SpreeBoard'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Trevor Poppen' => 'trevor.poppen@spreetail.com' }
  s.source           = { :git => 'https://github.com/Trevor Poppen/SpreeBoard.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'SpreeBoard/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SpreeBoard' => ['SpreeBoard/Assets/*.png']
  # }

  s.frameworks = 'UIKit'
  s.dependency 'UIColor_Hex_Swift', '~> 2.1'
end
