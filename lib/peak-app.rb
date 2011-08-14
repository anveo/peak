require 'sinatra/base'
require 'json'
require 'rrd'

require 'pp'

module Peak
  class Application < Sinatra::Base

    @app_root = Pathname.new(File.dirname(__FILE__)).parent.expand_path

    set :public, @app_root.join('lib/peak-app/public')
    set :views,  @app_root.join('lib/peak-app/views')
    puts @app_root.join('lib/peak-app/views')

    get '/' do
      filename = File.join(File.dirname(__FILE__), "..", "tmp/spengler.jetpackweb.com/load/load.rrd")
      rrd = RRD::Base.new(filename)

      stats = rrd.fetch(:average)

      #pp stats

      erb :overlook
    end
  end
end
