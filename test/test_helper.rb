require "simplecov"
SimpleCov.start

require "bundler/setup"
require "minitest/utils"
require "minitest/autorun"
require "rails"
require "action_controller/railtie"

require "json_blob"

class TestApp < Rails::Application
  secrets.secret_token    = "secret_token"
  secrets.secret_key_base = "secret_key_base"

  config.logger = Logger.new($stdout)
  Rails.logger = config.logger

  routes.draw do
  end
end

class ApplicationController < ActionController::Base
end
