Package.describe({
  summary: "An MVC Model class for Meteor that aims to have an API similar to Backbone."
});

Package.on_use(function (api) {
  api.use('coffeescript', ['client']);
  api.add_files('lib/model.coffee', ['client', 'server']);
  api.export('Model');
});

Package.on_test(function (api) {
  api.use('model');
});
