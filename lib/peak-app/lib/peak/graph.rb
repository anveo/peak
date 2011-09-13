module Peak
  class Graph

    VALID_TYPES = [:area, :line, :stacked]

    attr_accessor :id
    attr_accessor :title
    attr_accessor :graph_type
    attr_accessor :data_sources
    attr_accessor :time_range
    attr_reader :y_min, :y_max

    def self.find(id)
      Peak.graphs.find { |g| g.id == id }
    end

    def initialize(id, &block)
      @id = id
      @title = id.humanize
      @data_sources = []
      @graph_type = :area
      @time_range = "1h"

      instance_eval(&block) if block
    end

    def type (type = :area)
      @graph_type = type
    end

    def add_source(path, options)
      @data_sources << DataSource.new(self, path, options[:label], options[:index])
    end

    def dom_id
      "graph-" + title.downcase.dasherize.gsub(/\s+/, '-')
    end
  end
end
