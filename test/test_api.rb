require 'test/unit'

require 'config/boot'
require 'app/app'

module Squirrel
  class ApiTest < Test::Unit::TestCase
    include Rack::Test::Methods

    def app
      return @app unless @app.nil?
      app, options = Rack::Builder.parse_file(File.join(File.dirname(__FILE__), "..", "config.ru"))
      @app = app
    end

    def setup
      @release = Release.create!(
        :name => "Test Release",
        :version => 100,
        :pub_date => Time.now,
        :notes => "• Feature\n• Bug fix\n• Improvement",
        :url => "https://github.com/mac/latest"
      )
    end

    def teardown
      @release.destroy!
    end

    def test_release_latest
      get '/releases/latest'

      # Response should be 200 without a version parameter
      assert last_response.ok?

      # Body should be parsable as JSON
      body = JSON.parse(last_response.body)
      assert body

      # The only required property is url
      assert body['url']
    end

    def test_time_is_iso8601
      get '/releases/latest'

      body = JSON.parse(last_response.body)

      # If pub_date is present, it must be parsable as ISO 8601
      if pub_date = body['pub_date']
        assert DateTime.iso8601(pub_date)
      end
    end

    def test_version_match_yields_204
      get "/releases/latest?version=#{@release.version}"

      assert_equal 204, last_response.status
    end

    def test_expected_types
      get '/releases/latest'

      body = JSON.parse(last_response.body)

      url = body['url']
      assert url.is_a? String

      if name = body['name']
        assert name.is_a? String
      end

      if notes = body['notes']
        assert notes.is_a? String
      end

      if pub_date = body['pub_date']
        assert pub_date.is_a? String
      end
    end

  end
end
