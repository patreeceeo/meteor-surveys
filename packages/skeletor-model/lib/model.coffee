
Utils =
  extend: (obj, withObj) ->
    for key, value of withObj
      obj[key] = withObj

  defaults: (obj, defaults) ->
    for key, value of defaults
      unless obj[key]?
        obj[key] = defaults[key]

class Model
  defaults: {}

  constructor: (@_collectionID) ->
    @_collectionID = "#{@_collectionID}"
    # TODO: figure out why this test lies initially
    unless @collection.findOne(@_collectionID)?
      @doc = Utils.defaults _id: @_collectionID, @defaults
      @collection.insert @doc, ->

  set: (key, value) ->
    partial = {}
    partial["#{key}"] = value
    @collection.update @_collectionID, $set: partial

  get: (key) ->
    @collection.findOne(@_collectionID)?[key]
