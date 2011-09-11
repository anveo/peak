module Peak
  class RRDQuery
    def self.as_json(filename, start_at, end_at)

      # support both ubuntu and homebrew collectd locations
      rrd_path = File.directory?("/var/lib/collectd") ? "/var/lib/collectd/rrd" : "/usr/local/var/lib/collectd"
      filename = File.join(rrd_path, "#{`hostname`.strip}/#{filename}.rrd")

      rrd = RRD::Base.new(filename)
      stats = rrd.fetch(:average, :start => 1.hour.ago, :end => Time.now)

      p rrd
      p rrd.error

      #remove header
      stats.shift

      data = []
      stats.each do |s|
        val = s[1].nan? ? 0.0 : s[1].round(2)
        timestamp = s[0] * 1000

        if filename =~ /memory/
          val = (val / 1024 / 1024).round(2)
        end

        if filename =~ /df/
          val = (val / 1024 / 1024 / 1024).round(2)
        end

        data << [timestamp, val]
      end

      data.to_json
    end
  end
end
