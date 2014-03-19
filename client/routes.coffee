Router.configure
  layoutTemplate: 'layout'

Router.map ->
  @route 'home',
    path: '/'
    template: 'home'

  @route 'survey_question',
    path: '/survey/:survey_id/question/:survey_question_id'
    template: 'survey_question'

  @route 'create_survey_question',
    path: '/survey/:survey_id/create_question'
    template: 'create_survey_question'
    layoutTemplate: 'vertically_split_layout'
    yieldTemplates:
      'survey_question': to: 'leftContent'
      'create_survey_question': to: 'rightContent'


