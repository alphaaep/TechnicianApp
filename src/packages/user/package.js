Package.describe({
    name: 'ultimo:user',
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

        'ultimo:ultimo',
        'coffeescript',
        'accounts-base',
        'accounts-password',
        'iron:router',
        'alanning:roles',
        'alpha:logger'

    ], ['client', 'server']);
    api.use([
        'templating',
        'momentjs:moment',
        'mquandalle:jade'
    ], 'client');

    api.addFiles([

        'client/templates/login/login.jade',
        'client/templates/login/events.coffee',

        'client/templates/profile/profile.jade',
        'client/templates/profile/events.coffee',
        'client/templates/profile/helpers.coffee',

        'client/templates/profile/activity/activity.jade',
        'client/templates/profile/activity/helpers.coffee',

        'client/templates/profileMini/profileMini.jade',
        'client/templates/profileMini/events.coffee',
        'client/templates/profileMini/helpers.coffee'

    ], 'client');

    api.addFiles([

            'both/router/config.coffee',

            'both/router/routes.coffee'

        ] ,['client', 'server']);
});

Package.onTest(function (api) {
    api.use('tinytest');
    api.use('ultimo:user');
    api.addFiles('tests/user-tests.js');
});
