# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dmg/notam/opening_hours_parser'

Gem::Specification.new do |spec|
  spec.name          = "dmg-notam-parser"
  spec.version       = Dmg::Notam::OpeningHoursParser::VERSION
  spec.authors       = ["Dawid Marcin Grzesiak"]
  spec.email         = ["no-spam"]
  spec.summary       = %q{NOTAM parser for StrataJet}
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['Rakefile', '{bin,lib,man,test,spec,fixtures}/**/*', 'README*', 'LICENSE*'] # & `git ls-files -z`.split("\0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "byebug"
end
