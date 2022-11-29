require 'action_dispatch/middleware/session/dalli_store'
Rails.application.config.session_store ActionDispatch::Session::CacheStore, expire_after: 1.hour
