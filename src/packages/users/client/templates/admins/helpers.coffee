Template.admins.helpers
  admins: ->
    Roles.getUsersInRole 'admin'