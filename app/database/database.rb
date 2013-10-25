# Patch this in while using ActiveRecord 4.0.0
#
# SQLiteDatabaseTasks#initialize uses Rails directly
module ActiveRecord
  module Tasks
    class SQLiteDatabaseTasks
      class Rails
        def self.root
          ENV['RACK_ROOT']
        end
      end
    end
  end
end

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
