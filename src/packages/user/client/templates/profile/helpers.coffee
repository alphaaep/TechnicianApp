Template.profile.helpers
  email: ->
    @emails[0].address
  isAdmin: ->
    Roles.userIsInRole(@_id, 'admin')
  isManager: ->
    Roles.userIsInRole(@_id, 'manager')
  isTechnician: ->
    Roles.userIsInRole(@_id, 'technician')
  activities: ->
    Logger.Log.find userId: @_id
  hasNoActivity: ->
    Logger.Log.find(userId: @_id).count() is 0