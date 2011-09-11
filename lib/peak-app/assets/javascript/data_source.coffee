root = exports ? this

class root.DataSource
  constructor: (title, datums) ->
    @title = title
    @datums = datums
    @color = null
