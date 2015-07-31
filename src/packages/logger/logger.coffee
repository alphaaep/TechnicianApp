Logger.Log = new Mongo.Collection 'log'
Logger.Log.timestampable()
Logger.Log.softRemovable()

Logger.logInsert = (doc, collection)->
 Meteor.call 'logInsert', doc, collection

Logger.logUpdate = (d, m, col) ->
 Meteor.call 'logUpdate', d, m, col

Logger.logRemove = (d, col) ->
  Meteor.call 'logRemove', d, col

if Meteor.isServer
  Meteor.publish ->
    Logger.Log.find()

  Meteor.methods
    logInsert: (doc, colName) ->
      log =
        userId: @userId
        type: 'insert'
        col: colName
        doc: doc
      Logger.Log.insert log
    logUpdate: (d, m, colName) ->
      log =
        userId: @userId
        type: 'update'
        col: colName
        old: oldDoc
        new: newDoc
      Logger.Log.insert log
    logRemove: (doc, colName) ->
      log =
        userId: @userId
        type: 'remove'
        col: colName
        doc: doc
      Logger.Log.insert log
