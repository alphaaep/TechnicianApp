Meteor.users.after.insert (userId, doc) ->
  Logger.logInsert doc, 'users'
Meteor.users.after.update (userId, doc) ->
  Logger.logUpdate this.previous, doc, 'users'
Meteor.users.after.remove (userId, doc) ->
  Logger.logRemove doc, 'users'