View = Package['bem-view'].View
Template = Package.templating.Template

class SurveyQuestionView extends View

  dataHelpers:
    questionText: -> 
      @model.get 'question_text'

    choices: ->
      SurveyEnumeratedResponseCollection.find().fetch()

  helpers:
    renderAnswerChoices: (choices, options) ->
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
          <div class='#{className}' data-value='#{choice.value}' style='#{choice.style or ''}'>
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
