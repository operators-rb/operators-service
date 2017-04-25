# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'operators/service/version'

Gem::Specification.new do |spec|
  spec.name          = "operators-service"
  spec.version       = Operators::Service::VERSION
  spec.authors       = ["Kirill Shevchenko"]
  spec.email         = ["hello@kirillshevch.com"]

  spec.summary       = %q{operators-service}
  spec.description   = %q{operators-service}
  spec.homepage      = "http://operators-rb.org"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
