require 'sinatra/base'
require 'sinatra/content_for'
require 'active_support/all'
require 'json'
require 'rrd'

require 'peak-app/lib/rrd_query'
require 'peak-app/lib/graph'
require 'peak-app/lib/collection'
require 'peak-app/lib/node'
require 'peak-app/lib/data_source'

require 'pp'

module Peak
  class Application < Sinatra::Base

    helpers Sinatra::ContentFor

    @app_root = Pathname.new(File.dirname(__FILE__)).parent.expand_path

    set :public, @app_root.join('lib/peak-app/public')
    set :views,  @app_root.join('lib/peak-app/views')

    get '/' do

      @graphs = []

      load_graph = Peak::Graph.new("Load") do
        type = "area"
        y_min = 0
      end
      load_graph.add_source('load/load' , :label => 'Load')
      @graphs << load_graph

      memory_graph = Peak::Graph.new("Memory") do
        type = "stacked"
        y_min = 0
      end
      memory_graph.add_source('memory/memory-free'     , :label => 'Free')
      memory_graph.add_source('memory/memory-wired'    , :label => 'Wired')
      memory_graph.add_source('memory/memory-inactive' , :label => 'Inactive')
      memory_graph.add_source('memory/memory-active'   , :label => 'Active')
      @graphs << memory_graph

      disk_graph = Peak::Graph.new("Disk /") do
        type = "stacked"
      end
      disk_graph.add_source('df-root/df_complex-free'  , :label => 'Free')
      disk_graph.add_source('df-root/df_complex-used'  , :label => 'Used')
      @graphs << disk_graph

      if_graph = Peak::Graph.new("Interface en0") do
        type = "line"
      end
      if_graph.add_source('interface-en0/if_packets'  , :label => 'Packets')
      if_graph.add_source('interface-en0/if_octets'  , :label => 'Octets')
      if_graph.add_source('interface-en0/if_errors'  , :label => 'Errors')
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
