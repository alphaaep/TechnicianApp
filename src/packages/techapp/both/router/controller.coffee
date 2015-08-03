@AppController = RouteController.extend({
  onBeforeAction: ->
    if !Meteor.userId()
      @render 'login'
    else
      @next()
});