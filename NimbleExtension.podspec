Pod::Spec.new do |spec|
  spec.name         = 'NimbleExtension'
  spec.summary      = 'Swifter Swift development.'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/nimblehq/NimbleExtension'
  spec.authors      = { 'Nimble' => 'dev@nimblehq.co' }
  spec.source       = { :git => 'https://github.com/nimblehq/NimbleExtension', :branch => 'master' }
  spec.source_files = 'Sources/**/*.swift'
  spec.ios.deployment_target  = '8.0'
end
