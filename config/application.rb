require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Fdf31
  class Application < Rails::Application
    config.eager_load_paths << Rails.root.join("lib/cookies_product")
    config.eager_load_paths << Rails.root.join("lib/session_cart")
  end
end
