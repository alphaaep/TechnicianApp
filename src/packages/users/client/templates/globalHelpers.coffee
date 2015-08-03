Template.registerHelper 'getUsers', (role) ->
  if role is 'all'
    return Meteor.users.find()
  else
    return Roles.getUsersInRole role