Meteor.methods
  addUser: (user, roles) ->
    userId = Accounts.createUser user
    Roles.addUsersToRoles userId, roles
  updateUser: (_id, user, roles) ->
    Meteor.users.update(_id, {$set: user})
    Roles.setUserRoles _id, roles