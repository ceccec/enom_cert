# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enom_cert/version'

Gem::Specification.new do |spec|
  spec.name          = "enom_cert"
  spec.version       = EnomCert::VERSION
  spec.authors       = ["Tsvetan Roustchev"]
  spec.email         = ["tsv@hitsol.net"]
  spec.description   = "Enom::Cert"
  spec.summary       = "Certificate extension for enom"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "enom"
end
