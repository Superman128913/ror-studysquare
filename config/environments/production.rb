Studysquare::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to nil and saved in location specified by config.assets.prefix
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  #config.logger = ActiveSupport::BufferedLogger.new '/var/log/studysquare/production.log'

  # Use a different cache store in production
  config.cache_store = :dalli_store,
    (ENV["MEMCACHIER_SERVERS"] || "").split(","),
    {:username => ENV["MEMCACHIER_USERNAME"],
     :password => ENV["MEMCACHIER_PASSWORD"],
     :failover => true,
     :socket_timeout => 1.5,
     :socket_failure_delay => 0.2
    }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://studysquare.plict.nl"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w(mobile.js, application.css)

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: "www.studysquare.nl" }
  config.action_mailer.asset_host = "https://www.studysquare.nl"
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "mail.studysquare.nl",
    user_name: "noreply@studysquare.nl",
    password: "8dR@f819j",
    enable_starttls_auto: true,
    openssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,
    domain: "studysquare.nl"
  }

  # Enable threaded mode
  # http://stackoverflow.com/a/12570405
  config.threadsafe! unless defined?($rails_rake_task) && $rails_rake_task

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
end

Buckaroo::Ideal::Config.configure BUCKAROO.merge(
  gateway_url: 'https://checkout.buckaroo.nl/html/',
)
