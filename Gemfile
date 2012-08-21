source :rubygems
ruby '1.9.3'

gem 'thin'
gem 'rails'
gem 'mongoid', '~> 3.0.0'
gem 'jquery-rails'
gem 'simple_form'
gem 'json'
gem 'sorcery'
gem 'cancan'
gem 'haml-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'quiet_assets'
gem 'dalli'
gem 'memcachier'

group :development, :test do
  gem 'heroku'
  gem 'zencoder-fetcher'
  gem 'pry_debug'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'ffi', '1.1.0'
  gem 'factory_girl_rails'
  gem 'debugger'
  gem 'mongoid-rspec', :require => false
  gem 'rb-fsevent', :require => false
  gem 'guard-pow', :require => false
  gem 'guard-rspec', :require => false
  gem 'guard-livereload', :require => false
  gem 'yajl-ruby'
  gem 'simplecov', '>= 0.4.0', :require => false
  gem 'turn', :require => false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'bootstrap-sass'
end

group :production do
  gem 'exception_notification'
end
