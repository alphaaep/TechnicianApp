Package.describe({
    name: 'manager:clients',
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
    api.use(['mquandalle:jade', 'aldeed:tabular', 'coffeescript', 'templating', 'mongo', 'iron:router']);
    api.addFiles('templates/clients.jade');
    api.addFiles('scripts/clients.coffee');
});

Package.onTest(function (api) {
    api.use('tinytest');
    api.use('clients');
    api.addFiles('clients-tests.js');
});
