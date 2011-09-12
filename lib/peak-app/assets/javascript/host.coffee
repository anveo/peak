root = exports ? this

class root.Host
  constructor: (name) ->
    @name = name
    @graphs = []
    @timeRange = '1h'

  addGraph: (graph) ->
    @graphs.push graph

  updateGraphs: ->
    for graph in @graphs
      graph.update @name, @timeRange

  render: ->
    for graph in @graphs
      graph.render()
