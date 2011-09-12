module Peak
  class DataSource
    attr_accessor :label
    attr_accessor :path
    attr_accessor :index

    def initialize(path, label, index)
      @label = label
      @path = path
      @index = index || 1
    end

    def as_json
      RRDQuery.as_json(path, 1.hour.ago, Time.now, @index)
    end
  end
end
