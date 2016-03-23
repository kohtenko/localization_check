# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'localization_check/version'

Gem::Specification.new do |spec|
  spec.name          = "localization_check"
  spec.version       = LocalizationCheck::VERSION
  spec.authors       = ["Oleg Kokhtenko"]
  spec.email         = ["kohtenko@gmail.com"]

  spec.summary       = ""
  spec.description   = ""
  spec.homepage      = "https://github.com/kohtenko/version_checker"
  spec.license       = "MIT"


  spec.files         = Dir["lib/**/*"]
  spec.executables   = ["localization_check"]
  spec.require_paths = ["lib"]

  spec.add_dependency "version_checker", '~>0.0'
  spec.add_dependency "colorize", '~>0.7'
  
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
