Template.profile.helpers
  email: ->
    @emails[0].address
  isAdmin: ->
    Roles.userIsInRole(@_id, 'admin')
  isManager: ->
    Roles.userIsInRole(@_id, 'manager')
  isTechnician: ->
    Roles.userIsInRole(@_id, 'technician')