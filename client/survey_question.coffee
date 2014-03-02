class Model
  defaults: {}
  constructor: (@_collection_id) ->
    @_collection_id = "#{@_collection_id}"
    # TODO: figure out why this test lies initially
    unless @collection.findOne(@_collection_id)?
      @doc = _.extend(_id: @_collection_id, @defaults)
      @collection.insert @doc, ->
  set: (key, value) ->
    partial = {}
    partial["#{key}"] = value
    @collection.update @_collection_id, $set: partial
  get: (key) ->
    @collection.findOne(@_collection_id)?[key]

class View
  constructor: ->
    @_assign_events_to_template()
    @_assign_helpers_to_template()
    Meteor.startup =>
      # TODO: does this need to be done in Meteor.startup?
      @initialize()
  initialize: ->
  _assign_helpers_to_template: ->
    boundHelpers = {}
    for key, fn of @helpers
      boundHelpers[key] = (args...) =>
        fn.apply this, args

    @template.helpers boundHelpers
  _assign_events_to_template: ->
    @template.events = {}
    for key, object of @events
      eventSelector = "#{object.event} .#{object.block}"

      if object.element?
        eventSelector = "#{eventSelector}--#{object.element}"

      for modifier in object.modifiers or []
        eventSelector = "#{eventSelector} .#{object.block}-#{modifier}"

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
  helpers:
    selected: (value) ->
      value is @model.get('answer')
    # TODO: write iterative helper for generating radiobutton elements
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







