@userExists = (username) ->
  Meteor.users.findOne({username: username})