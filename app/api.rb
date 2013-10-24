module Squirrel
  class Api < Sinatra::Base

    get '/releases/latest' do
      release = Release.latest_release

      if !release.nil? && release.version == params[:version]
        return [ 204, {}, "" ]
      end

      [ 200, {}, release.to_json ]
    end

  end
end
