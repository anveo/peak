module Peak
  class DataSource
    attr_accessor :label
    attr_accessor :path
    attr_accessor :index
    attr_accessor :graph

    def initialize(graph, path, label, index)
      @graph = graph
      @label = label
      @path = path
      @index = index || 1
    end

    def as_json
      start_time = case @graph.time_range
        when "1h" then 1.hours.ago
        when "24h" then 1.day.ago
        when "1d" then 1.day.ago
        when "7d" then 1.week.ago
        when "30d" then 1.month.ago
        when "1y" then 1.year.ago
      end
      RRDQuery.as_json(path, start_time, Time.now, @index)
    end
  end
end
