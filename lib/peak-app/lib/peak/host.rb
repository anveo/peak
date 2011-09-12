module Peak
  class Host
    attr_accessor :name
    attr_accessor :graph_names
    attr_accessor :time_range

    def self.find(hostname)
      Peak.hosts.find { |h| h.name == hostname }
    end

    def initialize(name, &block)
      @name = name
      @graph_names = []
      @time_range = "1h"
      instance_eval(&block) if block
    end

    def time_range(range)
      graphs.each do |g|
        g.time_range = range
      end
    end

    def graph(id)
      # we store the id string, not actual graph instance because these names may
      # be added before the graph instance exists
      @graph_names << id
    end

    def graphs
      @graph_names.map { |g| Graph.find(g) }
    end
  end
end
