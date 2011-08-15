module Peak
  class RRDQuery
    def self.as_json(filename, start_at, end_at)

      filename = File.join("/var/lib/collectd/rrd/#{`hostname`.strip}/load/load.rrd")
      rrd = RRD::Base.new(filename)

      stats = rrd.fetch(:average, :start => 1.hour.ago, :end => Time.now)

      #remove header
      stats.shift

      data = []
      stats.each do |s|
        val = s[1].nan? ? 0.0 : s[1].round(2)
        timestamp = s[0] * 1000

        data << [timestamp, val]
      end

      data.to_json
    end
  end
end
