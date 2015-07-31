if (Meteor.isClient) {
    Meteor.startup(function () {
        $('body').attr('class', 'light_theme fixed_header left_nav_fixed');
    })
}
