# `BEM = {}`
Handlebars = Package['handlebars'].Handlebars

class View
  constructor: ->
    @_assignEventsToTemplate()
    @_assignDataHelpersToTemplate()
    @_assignBlockHelpers()
    @initialize()

  initialize: ->

  _assignDataHelpersToTemplate: ->
    boundHelpers = {}
    for key, fn of @dataHelpers
      boundHelpers[key] = (args...) =>
        fn.apply this, args

    @template.helpers boundHelpers

  _assignBlockHelpers: ->
    for key, fn of @helpers
      Handlebars.registerHelper key, (args...) =>
        fn.apply this, args

  buildEventSelector: (event, block, element = '', modifiers = []) ->
    "#{event} #{
      @buildBEMSelector(
        block
        element
        modifiers
      )
    }"

  buildBEM: (block, element = '', modifiers = [], options) ->
    prefix = options.prefix or ''
    delimiter = options.delimiter or ''

    baseSelector =
      if element isnt ''
        "#{prefix}#{block}--#{element}"
      else
        "#{prefix}#{block}"

    modifierSelectors =
      for modifier in modifiers
        "#{prefix}#{block}-#{modifier}"

    "#{baseSelector} #{modifierSelectors.join(delimiter)}"

  buildBEMSelector: (block, element = '', modifiers = []) ->
    @buildBEM block, element, modifiers,
      prefix: '.'
      delimiter: ''

  buildBEMClassName: (block, element = '', modifiers = []) ->
    @buildBEM block, element, modifiers,
      prefix: ''
      delimiter: ' '

  _assignEventsToTemplate: ->
    @template.events = {}
    for key, object of @events
      eventSelector = @buildEventSelector(
        object.event
        object.block
        object.element
        object.modifiers
      )

      @template.events[eventSelector] = (args...) =>
        # TODO: support strings as well as functions for callback value
        object.callback.apply this, args

