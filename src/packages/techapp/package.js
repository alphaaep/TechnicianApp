Package.describe({
    name: 'techapp:techapp',
    version: '0.0.1',
    // Brief, one-line summary of the package.
    summary: '',
    // URL to the Git repository containing the source code for this package.
    git: '',
    // By default, Meteor will default to using README.md for documentation.
    // To avoid submitting documentation, set this field to null.
    documentation: 'README.md'
});

Package.onUse(function (api) {
    api.versionsFrom('1.1.0.2');
    api.use(['templating', 'alanning:roles', 'iron:router', 'coffeescript', 'less', 'mquandalle:jade','ultimo:user','techapp:core','techapp:admin','techapp:manager','techapp:technician']);
    api.addFiles(['styles/styles.less', 'templates/app.jade'], 'client');
    api.addFiles(['scripts/techapp.coffee']);

    //api.addFiles([''], 'server');
});

Package.onTest(function (api) {
    api.use('tinytest');
    api.use('techapp:techapp');
    api.addFiles('techapp-tests.js');
});
