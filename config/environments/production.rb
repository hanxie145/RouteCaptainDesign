Emailify::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # force ssl
  config.force_ssl = false

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # use dalli memcached store
  config.cache_store = :dalli_store

  # these settings plus the bunlder option in application.rb allows on-the-fly compliation
  config.static_cache_control = "public, max-age=2523234" # this must be set and should be long expiry
  config.assets.enabled = true # this enables the asset pipleline
  config.assets.compress = true # this minifies the js/css into one file
  config.assets.compile = true # this turns on on-the-fly compliation (requires many options to be set as well)
  config.assets.digest = true # this turns on fingerprinting - versioning
  config.serve_static_assets = true # this allows the server to serve assets - if it is off then assets must be hosted elsewhere

  # set paths for thing outside of sprockets main 
  config.assets.precompile += %w(admin.js admin.css batman.css)

  # heroku requires this to be false
  config.assets.initialize_on_precompile = false

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = true

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings = {
      :address => "smtp.mailgun.org",
      :port => 587,
      :domain => "email-smartstox.com",
      :user_name => "errors@email-smartstox.com",
      :password => "this!@#error$$$",
      :enable_starttls_auto => true
  }

  # exception notification
  config.middleware.use ExceptionNotifier,
    sender_address:'errors@email-smartstox.com',
    email_prefix: '[www.routecaptain.com]',
    exception_recipients: 'bevan@smartstox.com'

end
