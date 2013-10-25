namespace :db do
  require_relative 'database'

  desc "Create the database"
  task :create do
    database_url = URI.parse(ENV['DATABASE_URL'])
    if database_url.scheme == 'sqlite3'
      db_directory = File.dirname(File.join(ENV['RACK_ROOT'], database_url.path))
      Dir.mkdir(db_directory) unless File.directory?(db_directory)
    end

    ActiveRecord::Tasks::DatabaseTasks.create_database_url
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Tasks::DatabaseTasks.drop_database_url
  end

  desc "Run the migration(s)"
  task :migrate do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate(migration_directory)

    Rake::Task["db:schema:dump"].invoke
  end

  desc 'Rolls the schema back to the previous version.'
  task :rollback do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.rollback(migration_directory, 1)

    Rake::Task["db:schema:dump"].invoke
  end

  namespace :schema do
    desc "Dump the database schema into a standard Rails schema.rb file"
    task :dump do
      require "active_record/schema_dumper"

      path = File.join(database_directory, "schema.rb")

      File.open(path, "w:utf-8") do |fd|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, fd)
      end
    end
  end

  def self.database_directory
    @db_dir ||= File.dirname(__FILE__)
  end

  def self.migration_directory
    File.join(database_directory, "migrations")
  end

end
