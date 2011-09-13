module Peak
  class Config
    def self.load_config
      config_file = '/etc/peak.conf'
      throw "Missing /etc/peak.conf" unless File.exist? config_file

      instance_eval(File.read(config_file))
    end

    def self.collection(name)
      Peak.collections << Collection.new(name)
    end

    def self.host(name, &block)
      Peak.hosts << Host.new(name, &block)
    end

    def self.graph(name, &block)
      Peak.graphs << Graph.new(name, &block)
    end
  end
end
