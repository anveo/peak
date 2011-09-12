module Peak
  class Collection

    attr_accessor :name
    attr_accessor :hosts

    def self.find_by_name(name)
      Peak.collection.find { |c| c.name == name }
    end

    def initialize(name)
      @name = name
      @hosts = []
    end

    def host(name)
      @hosts << name
    end
  end
end
