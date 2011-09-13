module Peak
  class GraphSet
    attr_accessor :id
    attr_accessor :graph_names

    def self.find(id)
      Peak.graph_sets.find { |g| g.id == id }
    end

    def initialize(id, &block)
      @id = id
      @graph_names = []

      instance_eval(&block) if block
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
