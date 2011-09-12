$(document).ready ->
  $('#filter').keyup (e) ->
    query = $(this).val().toLowerCase()
    $('.graph-container > div').each (index) ->
      name = $(this).attr('id')

      # skip if element doesn't have an id
      return unless name?

      if(name.indexOf(query) >= 0)
        $(this).show()
      else
        $(this).hide()

  $('button').click (e) ->
    timeRange = $(this).html()
    newUrl = $.param.querystring window.location.href, "time_range=#{timeRange}"
    window.location = newUrl
    #for graph in host.graphs
      #graph.update()

