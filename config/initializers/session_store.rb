# Be sure to restart your server when you modify this file.

#Emailify::Application.config.session_store :cookie_store, key: '_emailify_session'

# use memcached to store sessions
#Emailify::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 1.hour

Emailify::Application.config.session_store ActionDispatch::Session::CacheStore


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Emailify::Application.config.session_store :active_record_store
