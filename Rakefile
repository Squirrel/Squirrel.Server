$LOAD_PATH << File.dirname(__FILE__)

require 'config/boot'

namespace :db do
  require 'app/database/database'

  desc "Create the database"
  task :create do
    ActiveRecord::Tasks::DatabaseTasks.create_database_url
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Tasks::DatabaseTasks.drop_database_url
  end

  desc "Run the migration(s)"
  task :migrate do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate(migration_dir)

    Rake::Task["db:schema:dump"].invoke
  end

  desc 'Rolls the schema back to the previous version.'
  task :rollback do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.rollback(migration_dir, 1)

    Rake::Task["db:schema:dump"].invoke
  end

  namespace :schema do
    desc "Dump the database schema into a standard Rails schema.rb file"
    task :dump do
      require "active_record/schema_dumper"

      path = File.join(db_dir, "schema.rb")

      File.open(path, "w:utf-8") do |fd|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, fd)
      end
    end
  end

  def self.db_dir
    @db_dir ||= File.join(File.dirname(__FILE__), "app", "database")
  end

  def self.migration_dir
    File.join(db_dir, "migrations")
  end

end
