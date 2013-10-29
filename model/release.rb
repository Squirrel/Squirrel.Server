require 'json'

module Squirrel
    class Release

      include Comparable

      def self.load(file)
        @@releases = JSON.parse(File.read(file)).map do |json_release|
          new(json_release)
        end
      end

      def self.unload
        @@releases = nil
      end

      def self.all
        @@releases
      end

      def self.latest_release
        all.sort.last
      end

      def initialize(attributes)
        @attributes = attributes
      end

      def name
        @attributes['name']
      end

      def version
        @attributes['version']
      end

      def pub_date
        DateTime.iso8601(@attributes['pub_date'])
      end

      def notes
        @attributes['notes']
      end

      def url
        @attributes['url']
      end

      def to_json
        @attributes.to_json
      end

      def <=>(other)
        version <=> other.version
      end

    end
end
