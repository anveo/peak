root = exports ? this

class root.DataSource
  constructor: (graph, path, title, datums) ->
    @graph  = graph
    @path   = path
    @host   = graph.host
    @title  = title
    @datums = datums
    @color  = null
    @seriesIndex = null

  fetch: (timeRange) ->
    timeRange ||= @graph.timeRange
    #console.log "fetching #{@host}/#{@path}"

    #$.post "/hosts/#{@host.name}/graphs", {
      #path: @path,
      #time_range: timeRange
    #}, (data) =>
      #console.log "foo"
    # POST /hosts/www.example.com/graphs
    #   name: "interface-eth0"
    #   ds_name: "interface/if_packets-eth0"
    #   time_range: "30d"

