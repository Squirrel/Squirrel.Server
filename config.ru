require 'app/app'

map '/admin' do
  admin_username, admin_password = ENV['ADMIN_USERNAME'], ENV['ADMIN_PASSWORD']
  throw ArgumentError, "ADMIN_USERNAME and ADMIN_PASSWORD must be provided" unless admin_username && admin_password
  use Rack::Auth::Basic do |username, password|
    username == admin_username && password == admin_password
  end

  run Squirrel::Site
end

run Squirrel::Api
