module Squirrel
  module Views
    class Releases < Mustache

      def latest_release
        Release.latest_release
      end

    end
  end
end
