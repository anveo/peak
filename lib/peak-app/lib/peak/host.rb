module Peak
  class Host
    attr_accessor :name
    attr_accessor :the_alias
    attr_accessor :graph_names
    attr_accessor :graph_set_names
    attr_accessor :time_range

    def self.find(hostname)
      Peak.hosts.find { |h| h.name == hostname }
    end

    def initialize(name, &block)
      @name = name
      @the_alias = ""
      @graph_names = []
      @graph_set_names = []
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

    def graph_set(id)
      @graph_set_names << id
    end

    def alias_name(the_alias = '')
      @the_alias = the_alias
    end

    def graph_sets
      @graph_set_names.map { |g| GraphSet.find(g) }
    end

    def graphs
      (@graph_names.map { |g| Graph.find(g) } + graph_sets.map { |g| g.graphs }).flatten
    end
  end
end
