require 'json'
require 'time'

module Squirrel
    class Release

      include Comparable

      @@releases = []

      def self.load(file)
        @@releases = JSON.parse(File.read(file)).map do |json_release|
          new(json_release)
        end
        @@releases.sort!
      end

      def self.unload
        @@releases.clear
      end

      def self.all
        @@releases
      end

      def self.latest_release
        all.last
      end

      def self.hash_reader(key, &block)
        define_method key do
          value = @attributes[key.to_s]
          value = block.call(value) if block
          value
        end
      end

      hash_reader :name
      hash_reader :version

      hash_reader :pub_date do |value|
        DateTime.iso8601(value)
      end

      hash_reader :notes

      hash_reader :url

      def initialize(attributes)
        @attributes = attributes
      end

      def to_json
        @attributes.to_json
      end

      def <=>(other)
        version <=> other.version
      end

    end
end
