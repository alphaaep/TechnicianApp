Package.describe({
    name: 'alpha:logger',
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
        'coffeescript',
        'mongo',
        'sewdn:collection-behaviours@0.2.0',
        'dburles:collection-helpers@1.0.3']);
    api.addFiles(['var.js','logger.coffee'], ['client','server']);
    api.export('Logger', ['client','server'])
});

Package.onTest(function (api) {
    api.use('tinytest');
    api.use('alphashuro:logger');
    api.addFiles('logger-tests.js');
});
