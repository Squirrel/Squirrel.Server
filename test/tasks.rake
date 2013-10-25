require 'rake/testtask'

namespace :test do

  desc "Drop/Create and migrate the current database"
  task :create_database do
    [ Rake::Task['db:drop'], Rake::Task['db:create'], Rake::Task['db:migrate'] ].each { |task| task.invoke }
  end

  Rake::TestTask.new :run do |t|
    t.libs << ENV['RACK_ROOT']
    t.verbose = true
  end

end

desc "Create the database and run the tests"
task :test => [ "test:create_database", "test:run" ]
