Package.describe({
  summary: "/* fill me in */"
});

Package.on_use(function (api, where) {
  api.use('coffeescript', ['client']);
  api.use('templating', ['client']);
  api.use('ui', ['client']);
  api.use('bem-view', ['client']);
  api.add_files('lib/survey_question_view.coffee', ['client']);
  api.export('SurveyQuestionView', ['client']);
});

Package.on_test(function (api) {
  api.use('survey-question-view');
});
