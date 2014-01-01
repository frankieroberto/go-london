require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module GoLondon
  class Application < Rails::Application

    config.time_zone = 'London'

    config.session_store :disabled
    config.encoding = "utf-8"
    config.logger = Logger.new(STDOUT)
    config.secret_key_base = ENV['SECRET_KEY_BASE']

    config.active_support.escape_html_entities_in_json = true
    config.active_support.deprecation = :log

    config.assets.enabled = true
    config.assets.version = '1.0'

  end
end
