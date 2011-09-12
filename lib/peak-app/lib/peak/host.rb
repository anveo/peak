module Peak
  class Host
    attr_accessor :name

    def initialize(name, &block)
      @name = name
      instance_eval(&block) if block
    end

    def graph(name)
    end
  end
end
