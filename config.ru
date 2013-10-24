require 'app/app'

map '/admin' do
  run Squirrel::Site
end

run Squirrel::Api
