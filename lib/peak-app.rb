require 'sinatra/base'
require 'sinatra/content_for'
require 'active_support/all'
require 'json'
require 'rrd'

require 'peak-app/lib/peak'

require 'pp'

module Peak
  class Application < Sinatra::Base

    helpers Sinatra::ContentFor

    @app_root = Pathname.new(File.dirname(__FILE__)).parent.expand_path

    set :public, @app_root.join('lib/peak-app/public')
    set :views,  @app_root.join('lib/peak-app/views')

    get '/' do

      load_graph = Peak::Graph.new("Load") do
        type = "area"
        y_min = 0
        add_source 'load/load' , :label => 'Load' 
      end

      memory_graph = Peak::Graph.new("Memory") do
        type = "stacked"
        y_min = 0
        add_source 'memory/memory-free'     , :label => 'Free'
        add_source 'memory/memory-wired'    , :label => 'Wired'
        add_source 'memory/memory-inactive' , :label => 'Inactive'
        add_source 'memory/memory-active'   , :label => 'Active'
      end

      disk_graph = Peak::Graph.new("Disk /") do
        type = "stacked"
        add_source 'df-root/df_complex-free' , :label => 'Free'
        add_source 'df-root/df_complex-used' , :label => 'Used'
      end

      if_graph = Peak::Graph.new("Interface en0") do
        type = "line"
        add_source 'interface-en0/if_packets' , :label => 'Packets'
        add_source 'interface-en0/if_octets'  , :label => 'Octets'
        add_source 'interface-en0/if_errors'  , :label => 'Errors'
      end

      @graphs = []
      @graphs << load_graph
      @graphs << memory_graph
      @graphs << disk_graph
      @graphs << if_graph

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

      haml :overlook
    end
  end
end
