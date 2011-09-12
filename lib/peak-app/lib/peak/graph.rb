module Peak
  class Graph

    VALID_TYPES = [:area, :line, :stacked]

    attr_accessor :id
    attr_accessor :title
    attr_accessor :type
    attr_accessor :data_sources
    attr_reader :y_min, :y_max

    def initialize(id, &block)
      @title = id.humanize
      @data_sources = []
      @type = :area

      instance_eval(&block) if block
    end

    def add_source(path, options)
      @data_sources << DataSource.new(path, options[:label])
    end

    def dom_id
      "graph-" + title.downcase.dasherize.gsub(/\s+/, '-')
    end
  end
end
