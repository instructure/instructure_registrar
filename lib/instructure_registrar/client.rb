module InstructureRegistrar
  class Client

    require 'etcd'

    attr_reader :server_available

    def initialize
      @server_available = healthcheck
    end

    def healthcheck
      begin
        client.version
      rescue
        p "WARNING: etcd server unavailable"
        false
      end
    end

    def lookup(service_name)
      begin
        client.get("/#{service_name}").value
      rescue Etcd::KeyNotFound
        "unknown"
      end
    end

    def register
      return unless server_available
      InstructureRegistrar.config.service_config.keys.each do |key|
        client.set(
          "/#{InstructureRegistrar.config.service_name}/#{key}",
          value: InstructureRegistrar.config.service_config[key]
        )
      end
    end

    def unregister
      return unless server_available
      begin
        InstructureRegistrar.config.service_config.keys.each do |key|
          client.delete(
            "/#{InstructureRegistrar.config.service_name}/#{key}",
            value: InstructureRegistrar.config.service_config[key]
          )
        end
      rescue Etcd::KeyNotFound
        false
      end
    end

    private

    def client
      @client ||= Etcd.client(
        host: InstructureRegistrar.config.registry_host,
        port: InstructureRegistrar.config.registry_port
      )
    end
  end
end