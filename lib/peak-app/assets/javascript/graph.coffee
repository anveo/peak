root = exports ? this

class root.Graph
  constructor: (host, type, options) ->
    @host = host
    @stacking = null
    @type = type

    if @type == "stacked"
      @type = "area"
      @stacking = "normal"

    @domId = options['domId']
    @title = options['title']
    @chart = null
    @dataSources = []

  addDataSource: (title, path, data) ->
    @dataSources.push (new DataSource(this, path, title, data))

  buildChartOptions: () ->
    chartOptions =
      chart:
        renderTo: @domId
      title:
        text: "#{@host.name} - #{@title}"
      yAxis:
        text: ''
      navigator:
        enabled: false
      scrollbar:
        enabled: false
      rangeSelector:
        enabled: false
        inputEnabled: false
      credits:
        enabled: false
      series: []

    if @type == "area" || @type == "stacked"
      areaOptions =
        plotOptions:
          area:
            stacking: @stacking
      $.extend(chartOptions, areaOptions)

    for ds in @dataSources
      series =
        name: ds.title
        data: ds.datums
        type: @type

      chartOptions.series.push(series)
      ds.seriesIndex - chartOptions.series.length - 1

    chartOptions

  update: (timeRange) ->
    for ds in @dataSources
      ds.fetch()

  render: ->
    options = @buildChartOptions()
    @chart = new Highcharts.StockChart(options)
