Pod::Spec.new do |spec|
  spec.name         = 'NimbleExtension'
  spec.summary      = 'Swifter Swift development.'
  spec.version      = '0.1.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/nimblehq/NimbleExtension'
  spec.authors      = { 'Nimble' => 'dev@nimblehq.co' }
  spec.source       = { :git => 'https://github.com/nimblehq/NimbleExtension', :branch => 'master' }
  spec.source_files = 'NimbleExtension/Sources/**/*.swift'
  spec.ios.deployment_target  = '13.0'
end
