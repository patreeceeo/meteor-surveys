Package.describe({
  summary: "An MVC View class for Meteor that embraces BEM methodology (http://bem.info/method/definitions/) and aim to have an API similar to Backbone."
});

Package.on_use(function (api) {
  api.use('coffeescript', ['client']);
  api.add_files('lib/bem_view.coffee', ['client']);
  api.export('View');
});

Package.on_test(function (api) {
  api.use('bem-view');
});
