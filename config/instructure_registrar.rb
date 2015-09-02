require 'dotenv'
Dotenv.load
require 'concierge_service'

InstructureRegistrar.configure do |config|
  config.registry_host = ENV.fetch('REGISTRY_HOST') || "http://instructure-etcd.docker"
  config.registry_port = ENV.fetch("REGISTRY_PORT") || 12379
  config.service_name  = "my.service.name"
  confif.service_config = {
    host: "localhost",
    port: "3000"
  }
end

InstructureRegistrar.register
at_exit { InstructureRegistrar.unregister }
