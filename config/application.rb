require_relative "boot"
<<<<<<< HEAD
require "rails/all"
=======

require "rails/all"

>>>>>>> 163facfe99ef8952c0da165f3074ecca34823caa
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.load_defaults 5.2
<<<<<<< HEAD
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :vi]
=======
>>>>>>> 163facfe99ef8952c0da165f3074ecca34823caa
  end
end
