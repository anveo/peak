require 'sinatra/base'
require 'sinatra/content_for2'
require 'active_support/all'
require 'json'
require 'rrd'

require 'peak-app/lib/peak'

require 'pp'

module Peak
  class Application < Sinatra::Base

    helpers Sinatra::ContentFor2

    @app_root = Pathname.new(File.dirname(__FILE__)).parent.expand_path

    set :public, @app_root.join('lib/peak-app/public')
    set :views,  @app_root.join('lib/peak-app/views')

    get '/' do

      Peak.load_config

      #@deploy_data = [{
        #:title => 'Deploy',
        #:x => (Time.now - 50.minutes).to_i * 1000
      #},
      #{
        #:title => 'Deploy',
        #:x => (Time.now - 20.minutes).to_i * 1000
      #}].to_json

      #@analytics_data = [{
        #:title => 'Article on TechCrunch',
        #:x => (Time.now - 13.minutes).to_i * 1000
      #}].to_json

      erb :overlook
    end
  end
end
