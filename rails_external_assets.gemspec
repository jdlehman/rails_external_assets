# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_external_assets/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_external_assets"
  spec.version       = RailsExternalAssets::VERSION
  spec.authors       = ["Jonathan Lehman"]
  spec.email         = ["jonathan.lehman91@gmail.com"]

  spec.summary       = %q{Use external assets (those outside of Sprockets' asset pipeline) in Rails.}
  spec.description   = %q{Use external assets (those outside of Sprockets' asset pipeline) in Rails.}
  spec.homepage      = "http://github.com/jdlehman/rails_external_assets"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
