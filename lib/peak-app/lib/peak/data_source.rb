module Peak
  class DataSource
    attr_accessor :label
    attr_accessor :path

    def initialize(path, label)
      @label = label
      @path = path
    end

    def as_json
      RRDQuery.as_json(path, 1.hour.ago, Time.now)
    end
  end
end
