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
    api.use([
        'ultimo:ultimo',
        'coffeescript',
        'alanning:roles',
        'accounts-base',
        'accounts-password',
        'iron:router',
        'less',
        'alpha:logger',
        'dburles:collection-helpers@1.0.3',
        'matb33:collection-hooks@0.7.13'
    ], ['client', 'server']);
    api.use(['templating', 'mquandalle:jade']);
    api.addFiles(['templates/users.jade', 'styles/styles.less'], 'client');
    api.addFiles('scripts/seed/users.coffee', 'server');
    api.addFiles('scripts/users.coffee');
});

Package.onTest(function (api) {
    api.use('tinytest');
    api.use('admin:users');
    api.addFiles('users-tests.js');
});
