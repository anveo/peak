module Peak
  class RRDQuery
    def self.as_json(filename, start_at, end_at, index = 1)

      filename = File.join(Peak.collectd_dir, "#{Peak.current_host.name}/#{filename}.rrd")

      rrd = RRD::Base.new(filename)
      stats = rrd.fetch(:average, :start => 1.month.ago, :end => Time.now)

      #p filename
      #p rrd
      #p rrd.error

      #remove header
      stats.shift

      #p stats.first

      data = []
      stats.each do |s|
        val = s[index].nan? ? 0.0 : s[index].round(2)
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
