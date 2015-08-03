Router.route 'login' , {
  layoutTemplate: ''
}
Router.route 'profile' , {
  path: '/profile/:_id'
  data: -> Meteor.users.findOne this.params._id
}