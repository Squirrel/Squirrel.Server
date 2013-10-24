require 'mustache'

module Squirrel
  class Site < Sinatra::Base

    register Mustache::Sinatra
    set :mustache, {
      :namespace => Squirrel,
      :templates => File.join(File.dirname(__FILE__), "templates"),
      :views => File.join(File.dirname(__FILE__), "views"),
    }

    get '/releases' do
      mustache :releases, :layout => 'releases'
    end

    post '/releases' do
      Release.create!(
        :name => params[:name],
        :version => params[:version],
        :pub_date => Time.now,
        :notes => params[:notes],
        :url => params[:url])

      redirect '/admin/releases'
    end

  end
end
