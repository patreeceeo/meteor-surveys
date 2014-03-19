
Model = Package['skeletor-model'].Model
SurveyQuestionView = Package['survey-question-view'].SurveyQuestionView


new class extends SurveyQuestionView
  template: Template.survey_question
  initialize: ->
    @model = new SurveyQuestionModel 0








