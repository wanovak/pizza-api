# frozen_string_literal: true

require_relative 'database.rb'
require_relative 'api.rb'

# Heavily borrowed from: https://code.dblock.org/2012/01/30/grape-api-mounted-on-rack-w-static-pages.html
module PizzaApi
  class App
    def initialize
      # Serve static content if available
      @filenames = ['', '.html', 'index.html', '/index.html']
      @rack_static = ::Rack::Static.new(
        lambda { [404, {}, []] },
        root: File.expand_path('../../public', __dir__),
        urls: ['/']
      )
    end

    def self.instance
      @instance ||= Rack::Builder.new do
        run PizzaApi::App.new
      end.to_app
    end

    def call(env)
      # api
      PizzaApi::API.compile!
      response = PizzaApi::API.call(env)

      # Check if the App wants us to pass the response along to others
      if response[1]['X-Cascade'] == 'pass'
        # static files
        request_path = env['PATH_INFO']
        @filenames.each do |path|
          response = @rack_static.call(env.merge('PATH_INFO' => request_path + path))
          return response if response[0] != 404
        end
      end

      # Serve error pages or respond with API response
      case response[0]
      when 404, 500
        content = @rack_static.call(env.merge('PATH_INFO' => "/errors/#{response[0]}.html"))
        [response[0], content[1], content[2]]
      else
        response
      end
    end
  end
end
