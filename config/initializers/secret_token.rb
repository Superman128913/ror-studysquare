# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Studysquare::Application.config.secret_token = ENV['SECRET_TOKEN'] || '069d77dfd94a4f0de33d076b634f2667403c87c807af6ec0109c86402ea794586db816ee845e5592c60c8c22a7dda8fb4dd09c42842b4fc3854cab8c4d8b76ef'
