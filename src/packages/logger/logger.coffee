Logger.Log = new Mongo.Collection 'log'
Logger.Log.timestampable()
Logger.Log.softRemovable()

Logger.logInsert = (doc, collection)->
 Meteor.call 'logInsert', doc, collection

Logger.logUpdate = (oldD, newD, col) ->
 Meteor.call 'logUpdate', oldD, newD, col

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
    logUpdate: (oldD, newD, colName) ->
      log =
        userId: @userId
        type: 'update'
        col: colName
        old: oldD
        new: newD
      Logger.Log.insert log
    logRemove: (doc, colName) ->
      log =
        userId: @userId
        type: 'remove'
        col: colName
        doc: doc
      Logger.Log.insert log
