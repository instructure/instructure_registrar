require 'require_all'
require_rel 'instructure_registrar'

module InstructureRegistrar

  def self.get_service(service_name)
    InstructureRegistrar::Client.new.lookup(service_name)
  end

  def self.register
    InstructureRegistrar::Client.new.register
  end

  def self.unregister
    InstructureRegistrar::Client.new.unregister
  end

  class << self
    attr_accessor :config
  end

  def self.configure(&block)
    @config = Configuration.new
    yield(config)
  end

  def self.config
    @config || Configuration.new
  end

  class Configuration
    attr_accessor :registry_host, :registry_port
    attr_accessor :service_name, :service_config
  end

end

