require 'sinatra/base'
require 'sinatra/content_for'
require 'active_support/all'
require 'json'
require 'rrd'

require 'rrd_query'

require 'pp'

module Peak
  class Application < Sinatra::Base

    helpers Sinatra::ContentFor

    @app_root = Pathname.new(File.dirname(__FILE__)).parent.expand_path

    set :public, @app_root.join('lib/peak-app/public')
    set :views,  @app_root.join('lib/peak-app/views')

    get '/' do

      @data = RRDQuery.as_json('load', 1.hour.ago, Time.now)

      @deploy_data = [{
        :title => 'Deploy',
        :x => (Time.now - 50.minutes).to_i * 1000
      },
      {
        :title => 'Deploy',
        :x => (Time.now - 20.minutes).to_i * 1000
      }].to_json

      @analytics_data = [{
        :title => 'Article on TechCrunch',
        :x => (Time.now - 13.minutes).to_i * 1000
      }].to_json

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
