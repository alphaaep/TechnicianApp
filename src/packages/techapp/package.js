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
    api.addFiles([

        'client/styles/theme.less',

        'client/templates/globalHelpers.coffee',

        'client/templates/brand/brand.jade',

        'client/templates/head/head.jade',

        'client/templates/layout/layout.jade',

        'client/templates/nav/nav.jade',
        'client/templates/nav/helpers.coffee',

            'client/templates/nav/link/link.jade',
            'client/templates/nav/menu/menu.jade'

    ], 'client');

    api.addFiles([

        'both/router/config.coffee',
        'both/router/controller.coffee',
        'both/router/routes.coffee',

    ],['client','server'])
});

Package.onTest(function (api) {
    api.use('tinytest');
    api.use('techapp:techapp');
    api.addFiles('tests/techapp-tests.js');
});
