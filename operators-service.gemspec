# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'operators-service'
  spec.version       = '0.2.1'
  spec.authors       = ['Yaroslav Bezrukavyi', 'Kirill Shevchenko']
  spec.email         = ['yaroslav.bezrukavyi@gmail.com', 'hello@kirillshevch.com']

  spec.summary       = 'You will always know the type of the result'
  spec.description   = 'Service Object is based on Either Monad'
  spec.homepage      = 'https://github.com/operators-rb/operators-service'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-monads', '~> 0.3.1'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'byebug', '~> 3.5.0'
  spec.add_development_dependency 'rubocop', '~> 0.48.0'
end
