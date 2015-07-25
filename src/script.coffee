if Meteor.isClient
  Template.login.events
    "submit form": (e) ->
      e.preventDefault()
      user = $(e.target).find('[name=username]').val()
      password = $(e.target).find('[name=password]').val()
      Meteor.loginWithPassword(user, password)

  Template.admins.helpers
    admins: ->
      Roles.getUsersInRole 'admin'

  Template.managers.helpers
    managers: ->
      Roles.getUsersInRole 'manager'

  Template.technicians.helpers
    technicians: ->
      Roles.getUsersInRole 'technician'



  Router.configure
    layoutTemplate: "layout"

  Router.route '/', ->
    user = Meteor.userId()
    if (!user)
      Router.go '/login'
    if (Roles.userIsInRole user, ['admin'])
      Router.go '/users'

  Router.route '/login', ->
    @render 'login'
  Router.route '/users', ->
    @render 'users'

if Meteor.isServer
  if Roles.getUsersInRole('admin').count() is 0
    admin =
      username: "alphashuro"
      email: "alpha@aepit.co.za"
      password: "administrator"
      profile: {
        name: "Alpha Shuro"
      }
    adminId = Accounts.createUser(admin)
    Roles.addUsersToRoles(adminId, ['admin'])

