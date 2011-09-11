root = exports ? this

class root.Graph
  constructor: (type, options) ->
    @stacking = "none"
    @type = type

    if @type == "stacked"
      @type = "area"
      @stacking = "normal"

    @domId = options['domId']
    @title = options['title']
    @chart = null
    @dataSources = []

  addDataSource: (title, data) ->
    @dataSources.push (new DataSource(title, data))

  buildChartOptions: () ->
    chartOptions =
      chart:
        renderTo: @domId
      title:
        text: @title
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
      plotOptions:
        area:
          stacking: @stacking
      series: []

    for ds in @dataSources
      series =
        name: ds.title
        data: ds.datums
        type: @type

      chartOptions.series.push(series)

    chartOptions

  render: ->
    options = @buildChartOptions()
    @chart = new Highcharts.StockChart(options)
