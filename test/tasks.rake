require 'rake/testtask'

Rake::TestTask.new :test do |t|
  t.libs << ENV['RACK_ROOT']
  t.verbose = true
end
