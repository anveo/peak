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


