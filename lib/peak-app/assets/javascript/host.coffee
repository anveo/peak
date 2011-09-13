root = exports ? this

class root.Host
  constructor: (name, alias='') ->
    @name = name
    @alias = alias
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
