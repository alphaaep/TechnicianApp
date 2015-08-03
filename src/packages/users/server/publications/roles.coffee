Meteor.publish 'admins', ->
  Roles.getUsersInRole 'admins'

Meteor.publish 'technicians', ->
  Roles.getUsersInRole 'technician'

Meteor.publish 'managers', ->
  Roles.getUsersInRole 'manager'