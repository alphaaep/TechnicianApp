Template.profileMini.events
  'click .logout': ->
    Meteor.logout()
    Router.go '/'