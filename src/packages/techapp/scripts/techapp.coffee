if Meteor.isClient
  Template.nav.helpers
    items: ->
      return Techapp.nav

  Template.registerHelper 'isActiveRoute', (path)->
    currPath = Router.current().route.path()
    if '/'+currPath is path
      'theme_color active'

  @AppController = RouteController.extend({
    onBeforeAction: ->
      if !Meteor.userId()
        @render 'login'
      else
        @next()
  });

  Router.configure
    controller: 'AppController'
    layoutTemplate: "layout"

Router.route '/', ->

  if Roles.userIsInRole(Meteor.userId(), 'admin')
    Router.go 'admins'
  else if Roles.userIsInRole(Meteor.userId(), 'manager')
#    Router.go ''
  else if Roles.userIsInRole(Meteor.userId(), 'technician')
#    Router.go ''
  else
    Router.go 'dashboard'

Router.route 'dashboard', ->



