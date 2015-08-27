require 'dotenv'
Dotenv.load
require 'concierge_service'

InstructureRegistrar.configure do |config|
  config.registry_host = ENV.fetch('REGISTRY_HOST') || "http://instructure-etcd.docker"
  config.registry_port = ENV.fetch("REGISTRY_PORT") || 12379
  config.service_name  = "my.service.name"
  config.service_host  = "localhost"
  config.service_port  = "3000"
end

InstructureRegistrar.register
at_exit { InstructureRegistrar.unregister }
