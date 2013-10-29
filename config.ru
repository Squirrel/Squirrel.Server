$LOAD_PATH << File.dirname(__FILE__)

require 'config/boot'

require 'model/release'

if %w(development production).include?(ENV['RACK_ENV'])
  releases_path = File.join(ENV['RACK_ROOT'], 'db', 'releases.json')
  Squirrel::Release.load(releases_path) if File.exists?(releases_path)
end

module Squirrel
  class Api < Sinatra::Base

    get '/releases/latest' do
      release = Release.latest_release

      if release.nil? || release.version == params['version'].to_i
        return [ 204, {}, "" ]
      end

      [ 200, {}, release.to_json ]
    end

  end
end

run Squirrel::Api
