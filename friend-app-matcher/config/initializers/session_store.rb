# Be sure to restart your server when you modify this file.

FriendAppMatcher::Application.config.session_store :cookie_store, key: '_friend-app-matcher_session'
FriendAppMatcher::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# FriendAppMatcher::Application.config.session_store :active_record_store
