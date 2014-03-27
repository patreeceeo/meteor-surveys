View = Package['bem-view'].View
Model = Package['skeletor-model'].Model

new class extends SurveyQuestionView
  template: Template.create_survey_question
  initialize: ->
    @model = new SurveyQuestionModel 0
  events:
    changeQuestionPrompt:
      block: 'Form'
      element: 'input'
      event: 'change'
      callback: ->
        @model.set 'questionText', $(event.target).val()








