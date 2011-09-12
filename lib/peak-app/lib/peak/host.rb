module Peak
  class Host
    attr_accessor :name
    attr_accessor :graph_names

    def self.find(hostname)
      Peak.hosts.find { |h| h.name == hostname }
    end

    def initialize(name, &block)
      @name = name
      @graph_names = []
      instance_eval(&block) if block
    end

    def graph(id)
      # we store the id string, not actual graph instance because these names may
      # be added before the graph instance exists
      @graph_names << id
      p @graph_names
    end

    def graphs
      @graph_names.map { |g| Graph.find(g) }
    end
  end
end
