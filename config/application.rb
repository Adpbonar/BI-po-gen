require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PoGen
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :utc
    config.action_view.sanitized_allowed_tags = ['strong', 'em', 'del', 'a', 'b', 'div', 'blockquote', 'p', 'i', 'u', 'span', 'center', 'pre', 'table', 'th', 'tbody' 'td', 'tr', 'code', 'pre', 'section', 'article', 'ul', 'ol', 'li', 'img', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'button', 'small', 'br', 'sub', 'sup']
    config.action_view.sanitized_allowed_attributes = ['href', 'src', 'title', 'class', 'style', 'id', 'type', 'target', 'height', 'width', 'alt']
    Loofah::HTML5::SafeList::ALLOWED_CSS_PROPERTIES.merge %w(margin-bottom margin-top margin overflow border-radius padding padding-top padding-bottom position box-shadow color background-color background margin text-align font-family line-height letter-spacing border width height align text-align font-size font-weight text-decoration font-style)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
