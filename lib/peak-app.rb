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

    set :root, @app_root.join('lib/peak-app')
    set :public, root.join('public')
    set :views,  root.join('views')

    Peak.load_config

    get '/' do
      erb :overlook
    end

    get '/hosts/:hostname' do
      @hostname = params[:hostname]
      @host = Host.find(@hostname)
      @host.time_range(params[:time_range] || "1h")
      Peak.current_host = @host
      erb :overlook
    end
  end
end
