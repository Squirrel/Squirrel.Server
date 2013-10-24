module Squirrel
  class Release < ActiveRecord::Base

      validates_uniqueness_of :version

      def self.latest_release
        order("version DESC").first
      end

  end
end
