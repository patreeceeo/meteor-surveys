
Handlebars.registerHelper 'equals', (a, b) ->
  a is b

class SurveyQuestionView extends View

  dataHelpers:
    questionText: -> 
      @model.get 'questionText'

    responseFormat: ->
      @model.get 'responseFormat'

    choices: ->
      SurveyEnumeratedResponseCollection.find().fetch()

    answer: ->
      @model.get 'answer'

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
