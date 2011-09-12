module Peak
  class Config
    def self.load_config
      config_file = File.expand_path(File.join(__FILE__, "../../../../../", "config/config.rb"))

      instance_eval(File.read(config_file))
    end

    def self.collection(name)
      Peak.collections << Collection.new(name)
    end

    def self.host(name)
      Peak.hosts << Host.new(name)
    end

    def self.graph(name, &block)
      Peak.graphs << Graph.new(name, &block)
    end
  end
end
