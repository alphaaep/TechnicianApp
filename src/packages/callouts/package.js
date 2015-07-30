Package.describe({
    name: 'manager:callouts',
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
    api.use([
        'techapp:core',
        'mquandalle:jade',
        'coffeescript',
        'templating',
        'mongo',
        'iron:router',
        'aldeed:tabular',
        'alanning:roles',
        'mizzao:jquery-ui',
        'momentjs:moment',
        'tsega:bootstrap3-datetimepicker@4.14.30_4'
    ]);
    api.addFiles([
        'callouts.jade'
        ],
            'client');
    api.addFiles(['callouts.coffee']);
});

Package.onTest(function (api) {
    api.use('tinytest');
    api.use('manager:callouts');
    api.addFiles('callouts-tests.js');
});
