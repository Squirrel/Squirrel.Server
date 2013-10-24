require 'bundler'
Bundler.require(:default)

environment_name = ENV['RACK_ENV']
if environment_name
  Bundler.require(environment_name.to_sym)

  environment_config = File.join(File.dirname(__FILE__), "environments", "#{environment_name}.rb")
  require environment_config if File.exists?(environment_config)
end
