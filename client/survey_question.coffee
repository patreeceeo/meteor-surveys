
View = Package['bem-view'].View
Model = Package['skeletor-model'].Model

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
    background: -moz-linear-gradient(left,
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







