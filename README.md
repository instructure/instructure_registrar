# InstructureRegistrar

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/instructure_service_registry_client`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'instructure_registrar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install instructure_registrar

## Usage

Make sure that the following environment variables are set with the appropriate
information for your local etcd instance:

    export REGISTRY_HOST=
    export REGISTRY_PORT=

### Integrating with a service

Create a /config/instructure_registrar.rb file with the following contents:

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

### Looking up a service

    require 'instructure_registrar'
    @my_service_url = InstructureRegistrar.get_service('my_service_name')

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/instructure_registrar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
