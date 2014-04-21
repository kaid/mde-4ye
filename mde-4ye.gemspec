# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mde-4ye/version'

Gem::Specification.new do |spec|
  spec.name          = "mde-4ye"
  spec.version       = MDE4ye::VERSION
  spec.authors       = ["kaid"]
  spec.email         = ["kaid@kaid.me"]
  spec.summary       = %q{A markdown editor based on ace code editor.}
  spec.description   = %q{With image paste capability.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "haml"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
