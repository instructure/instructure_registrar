# InstructureRegistrar

InstructureRegistrar is a Ruby library for registering and retrieving service
information from a central etcd service registry.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'instructure_registrar'
```

And then execute:

    $ bundle

## Usage

Make sure that the following environment variables are set with the appropriate
information for your local etcd instance:

    REGISTRY_HOST
    REGISTRY_PORT

### Integrating with a service

In your service's project folder, create a configuration file with the following contents:

    #/config/initializers/instructure_registrar.rb
    require 'dotenv'
    Dotenv.load
    require 'instructure_registrar'

    InstructureRegistrar.configure do |config|
      config.registry_host = ENV.fetch('REGISTRY_HOST') || "http://instructure-etcd.docker"
      config.registry_port = ENV.fetch("REGISTRY_PORT") || 12379
      config.service_name  = "my.service.name"
      config.service_host  = ENV.fetch("SERVICE_HOST") || "http://localhost/"
      config.service_port  = ENV.fetch("SERVICE_PORT") || 3000
    end

    InstructureRegistrar.register
    at_exit { InstructureRegistrar.unregister }

### Looking up a service

Note that your client application will need a config file similar to that in the section above, but
unless you plan on registering your app as a service your config file will be simpler:

    #/config/initializers/instructure_registrar.rb
    require 'dotenv'
    Dotenv.load
    require 'instructure_registrar'

    InstructureRegistrar.configure do |config|
      config.registry_host = ENV.fetch('REGISTRY_HOST') || "http://instructure-etcd.docker"
      config.registry_port = ENV.fetch("REGISTRY_PORT") || 12379
    end

Then, to fetch connection information for a given service:

    require 'instructure_registrar'
    @some_service_url = InstructureRegistrar.get_service('some_service_name')

