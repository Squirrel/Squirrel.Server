require 'bundler'
Bundler.require(:default)

ENV['RACK_ROOT'] ||= File.join(File.dirname(__FILE__), "..")

environment_name = ENV['RACK_ENV'] ||= 'development'
Bundler.require(environment_name.to_sym)
