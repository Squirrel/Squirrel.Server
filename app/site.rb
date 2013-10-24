require 'mustache'

module Squirrel
  class Site < Sinatra::Base

    register Mustache::Sinatra
    set :mustache, {
      :namespace => Squirrel,
      :templates => File.join(File.dirname(__FILE__), "templates"),
      :views => File.join(File.dirname(__FILE__), "views"),
    }

    get '/latest' do
      @latest_release = Release.latest_release
      mustache :releases, :layout => 'releases'
    end

    post '/latest' do


      redirect '/admin/latest'
    end

  end
end
