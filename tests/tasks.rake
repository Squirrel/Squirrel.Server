require 'rake/testtask'

Rake::TestTask.new :test do |t|
  t.libs.concat [ "test", "app" ]
end
