module InstructureRegistrar
  class Client

    def lookup(service_name)
      client.get(service_name).value || "unknown"
    end

    def register
      client.set(
        InstructureRegistrar.config.service_name,
        "#{InstructureRegistrar.service_host}:#{InstructureRegistrar.config.service_port}"
      )
    end

    def unregister
      client.delete(InstructureRegistrar.config.service_name)
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