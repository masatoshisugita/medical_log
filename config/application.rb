require_relative 'boot'

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MedicalLog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja
    
    Raven.configure do |config|
      config.dsn = 'https://871fda0e90af490495863cac1c2fc886:d78be310a25e4f2f962ad206982d983a@o414573.ingest.sentry.io/5304703'
    end

    config.generators do |g|
    g.test_framework :rspec,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end
  end
end
