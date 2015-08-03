@AppController = RouteController.extend({
  onBeforeAction: ->
    if !Meteor.userId()
      Router.go 'login'
    else
      @next()
});