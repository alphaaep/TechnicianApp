Router.route 'admins', {
  path: '/admins'
  subscriptions: ->
    @subscribe 'admins'
  waitOn: -> Meteor.subscribe 'admins'
  data:
    admins: -> Roles.getUsersInRole 'admin'
}

Router.route 'managers', {
  path: '/managers'
  subscriptions: ->
    @subscribe 'managers'
  waitOn: -> Meteor.subscribe 'managers'
  data: -> Roles.getUsersInRole 'admin'
}

Router.route 'technicians', {
  path: '/technicians'
  subscriptions: ->
    @subscribe 'technicians'
  waitOn: -> Meteor.subscribe 'technicians'
  data: -> Roles.getUsersInRole 'technician'
}

Router.route 'all', {
  path: '/all'
  subscriptions: ->
    @subscribe 'users'
  waitOn: -> Meteor.subscribe 'users'
  data: -> Meteor.users.find()
}

Router.route 'userDetails', {
  path: '/userDetails/:_id'
  subscriptions: ->
    @subscribe 'users'
    @subscribe('user', @params._id).wait()
  waitOn: -> Meteor.subscribe 'user', @params._id
  data: -> Meteor.users.findOne @params._id
}

Router.route 'addUser'