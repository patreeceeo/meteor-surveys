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

SurveyQuestionCollection = new Meteor.Collection 'SurveyQuestion'

class SurveyQuestionModel extends Model
  collection: SurveyQuestionCollection

  defaults:
    answer: null

class SurveyQuestionView extends View
  template: Template.survey_question

  dataHelpers:
    selected: (value) ->
      value is @model.get('answer')

    choices: -> [
      { value: 'red', title: 'Red', style: "background: red;" }
      { value: 'green', title: 'Green', style: "background: green;" }
      { value: 'blue', title: 'Blue', style: "background: blue; color: white;" }
      { value: 'cantdecide', title: "I can't decide", style: """
    background: red; /* uh oh */
    background: -moz-linear-gradient( left ,
        rgba(255, 0, 0, 1) 0%,
        rgba(255, 255, 0, 1) 15%,
        rgba(0, 255, 0, 1) 30%,
        rgba(0, 255, 255, 1) 50%,
        rgba(0, 0, 255, 1) 65%,
        rgba(255, 0, 255, 1) 80%,
        rgba(255, 0, 0, 1) 100%);
    background: -webkit-gradient(linear,  left top, right top,
        color-stop(0%, rgba(255, 0, 0, 1)),
        color-stop(15%, rgba(255, 255, 0, 1)),
        color-stop(30%, rgba(0, 255, 0, 1)),
        color-stop(50%, rgba(0, 255, 255, 1)),
        color-stop(65%, rgba(0, 0, 255, 1)),
        color-stop(80%, rgba(255, 0, 255, 1)),
        color-stop(100%, rgba(255, 0, 0, 1)));
      """}
    ]

  helpers:
    renderChoices: (choices, options) ->
      out = ""
      answer = @model.get('answer')
      for choice in choices
        className = @buildBEMClassName(
          'Form'
          'radiobutton'
          ['selected'] if answer is choice.value
        )
        out = """
          #{out}
          <div class='#{className}' data-value='#{choice.value}' style='#{choice.style}'>
            <i class='fa'></i>
            #{options.fn choice}
          </div>
        """
      out

  events:
    clickRadioButton:
      block: 'Form'
      element: 'radiobutton'
      event: 'click'
      callback: (event) ->
        value = $(event.target).data('value')
        if @model.get('answer') is value
          @model.set 'answer', null
        else
          @model.set 'answer', value

  initialize: ->
    @model = new SurveyQuestionModel 0

new SurveyQuestionView







