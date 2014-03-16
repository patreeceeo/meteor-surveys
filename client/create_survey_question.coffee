View = Package['bem-view'].View
Model = Package['skeletor-model'].Model

class SurveyQuestionView extends View
  template: Template.create_survey_question

  helpers:
    renderResponseFormatChoices: (choices, options) ->
      out = ""
      responseFormat = @model.get('response_format')
      for choice in choices
        className = @buildBEMClassName(
          'Form'
          'radiobutton'
          ['selected'] if responseFormat is choice.value
        )
        out = """
          #{out}
          <div class='#{className}' data-value='#{choice.value}' style='#{choice.style or ''}'>
            <i class='fa'></i>
            #{options.fn choice}
          </div>
        """
      out

  dataHelpers:
    questionText: -> 
      @model.get 'question_text'

    responseFormatChoices: ->
      [
        { value: 'list_choose_one', title: 'List - Choose One' }
        { value: 'list_choose_multi', title: 'List - Choose Multiple' }
      ]

  initialize: ->
    @model = new SurveyQuestionModel 0

  events:
    clickRadioButton:
      block: 'Form'
      element: 'radiobutton'
      event: 'click'
      callback: (event) ->
        value = $(event.target).data('value')
        if @model.get('response_format') is value
          @model.set 'response_format', null
        else
          @model.set 'response_format', value
    changeQuestionPrompt:
      block: 'Form'
      element: 'input'
      event: 'change'
      callback: ->
        @model.set 'question_text', $(event.target).val()

new SurveyQuestionView







