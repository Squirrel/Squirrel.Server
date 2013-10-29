require 'bundler'
Bundler.require(:default)

environment_name = ENV['RACK_ENV'] ||= 'development'
if environment_name
  Bundler.require(environment_name.to_sym)
end

ENV['RACK_ROOT'] ||= File.join(File.dirname(__FILE__), "..")
