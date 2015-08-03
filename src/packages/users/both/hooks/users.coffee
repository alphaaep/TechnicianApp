Meteor.users.before.insert (userId, doc) ->
  Logger.logInsert doc, 'users'
Meteor.users.before.update (userId, doc, fieldName, modifier) ->
  Logger.logUpdate doc, modifier, 'users'
Meteor.users.before.remove (userId, doc) ->
  Logger.logRemove doc, 'users'