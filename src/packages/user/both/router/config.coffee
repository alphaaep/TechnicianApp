Router.configure(
  onBeforeAction: ->
    if !Meteor.userId()
      Router.go 'login'
    else
      @next()
)