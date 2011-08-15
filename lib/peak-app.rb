require 'sinatra/base'
require 'sinatra/content_for'
require 'active_support/all'
require 'json'
require 'rrd'

require 'pp'

module Peak
  class Application < Sinatra::Base

    helpers Sinatra::ContentFor

    @app_root = Pathname.new(File.dirname(__FILE__)).parent.expand_path

    set :public, @app_root.join('lib/peak-app/public')
    set :views,  @app_root.join('lib/peak-app/views')

    get '/' do
      filename = File.join(File.dirname(__FILE__), "..", "tmp/spengler.jetpackweb.com/load/load.rrd")
      rrd = RRD::Base.new(filename)

      stats = rrd.fetch(:average, :start => 1.hour.ago, :end => Time.now)

      #remove header
      stats.shift

      @data = stats.map { |d| [ d[0] * 1000, rand ] }
      @data = @data.to_json

      haml :overlook
    end

    get '/javascripts/application.js' do
      coffee "javascripts/application".to_sym
    end

    get '/stylesheets/application.css' do
      scss "stylesheets/application".to_sym
    end
  end
end
