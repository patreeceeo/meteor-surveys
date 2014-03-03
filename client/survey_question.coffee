
View = Package['bem-view'].View
Model = Package['skeletor-model'].Model

SurveyQuestionCollection = new Meteor.Collection 'SurveyQuestion'
SurveyEnumeratedResponseCollection = new Meteor.Collection 'SurveyEnumeratedResponse'

class SurveyQuestionModel extends Model
  collection: SurveyQuestionCollection

  defaults:
    answer: null

class SurveyQuestionView extends View
  template: Template.survey_question

  dataHelpers:
    selected: (value) ->
      value is @model.get('answer')

    choices: ->
      SurveyEnumeratedResponseCollection.find().fetch()

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







