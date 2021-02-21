require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ReaderTrackerBackend
  class Application < Rails::Application
    config.load_defaults 6.1
    config.api_only = true
    config.generators.test_framework :rspec
    config.generators.integration_tool :rspec
  end
end
