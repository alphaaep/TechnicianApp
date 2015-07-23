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


Router.route '/', ->
  this.render 'login'