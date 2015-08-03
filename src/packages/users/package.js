Package.describe({
    name: 'admin:users',
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
    /* ---------- packages ----------- */

    // both
    api.use([
        'ultimo:ultimo',
        'coffeescript',
        'techapp:core',
        'alanning:roles',
        'accounts-base',
        'accounts-password',
        'iron:router',
        'alpha:logger',
        'dburles:collection-helpers@1.0.3',
        'matb33:collection-hooks@0.7.13',
        'reywood:publish-composite@1.3.6',
    ], ['client', 'server']);
    // client
    api.use([
        'templating',
        'mquandalle:jade',
        'less',
        'momentjs:moment'
        ],
        'client'
    );

    /* ----------- files ----------- */

    // client
    api.addFiles([
            //styles
        'client/styles/_add_user_button.less',
        'client/styles/styles.less',
            //templates
        'client/templates/user/user.jade',
        'client/templates/user/events.coffee',
        'client/templates/user/helpers.coffee',

        'client/templates/userDetails/userDetails.jade',
        'client/templates/userDetails/helpers.coffee',
        'client/templates/userDetails/events.coffee',

        'client/templates/userDetails/activity/activity.jade',
        'client/templates/userDetails/activity/helpers.coffee',

        'client/templates/globalHelpers.coffee',

        'client/templates/all/all.jade',

        'client/templates/admins/admins.jade',
        //'client/templates/admins/helpers.coffee',

        'client/templates/addUser/addUser.jade',
        'client/templates/addUser/events.coffee',
        'client/templates/addUser/helpers.coffee',

        'client/templates/managers/managers.jade',
        //'client/templates/managers/helpers.coffee',

        'client/templates/technicians/technicians.jade',
        //'client/templates/technicians/helpers.coffee'
        ],
        'client');
    // server
    api.addFiles([
        'lib/lib.coffee',
        'private/default_users.coffee',
        'server/methods/user.coffee',
        'server/publications/roles.coffee',
        'server/publications/users.coffee',
        'server/seeds/admin.coffee'
        ],
        'server');
    // both
    api.addFiles([
        'both/hooks/users.coffee',
        'both/router/routes.coffee'
    ],['client','server']);
});

Package.onTest(function (api) {
    api.use('tinytest');
    api.use('admin:users');
    api.addFiles('users-tests.js');
});
