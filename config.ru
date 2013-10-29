$LOAD_PATH << File.dirname(__FILE__)

require 'config/boot'

get '/releases/latest' do
  release = Release.latest_release

  if release.nil? || release.version == params['version'].to_i
    return [ 204, {}, "" ]
  end

  [ 200, {}, release.to_json ]
end
