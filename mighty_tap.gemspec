# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mighty_tap/version"

Gem::Specification.new do |spec|
  spec.name          = "mighty_tap"
  spec.version       = MightyTap::VERSION
  spec.authors       = ["Michael Sievers"]
  spec.summary       = %q{A more mighty tap}
  spec.homepage      = "https://github.com/msievers/mighty_tap"
  spec.description   = "A tap for ruby with some extra sugar"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",   ">= 1.3"
  spec.add_development_dependency "rake",      "~> 10.0"
  spec.add_development_dependency "rspec",     ">= 3.0.0", "< 4.0.0"
  spec.add_development_dependency "rspec-its", ">= 1.2.0"
  spec.add_development_dependency "simplecov", ">= 0.8.0"
end
