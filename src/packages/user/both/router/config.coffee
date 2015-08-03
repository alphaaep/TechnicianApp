Router.configure(
  onBeforeAction: ->
    if !Meteor.userId()
      @render 'login'
    else
      @next()
)