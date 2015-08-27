# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'instructure_service_registry_client/version'

Gem::Specification.new do |spec|
  spec.name          = "instructure_registrar"
  spec.version       = InstructureServiceRegistryClient::VERSION
  spec.authors       = ["CoralineAda"]
  spec.email         = ["coraline@idolhands.com"]

  spec.summary       = %q{Client for registering an Instructure service via etcd.}
  spec.description   = %q{Client for registering an Instructure service via etcd.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "etcd", "~> 0.3"
  spec.add_dependency "require_all"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
