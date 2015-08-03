Meteor.publish 'admins', -> Roles.getUsersInRole 'admin'

Meteor.publish 'technicians', -> Roles.getUsersInRole 'technician'

Meteor.publish 'managers', -> Roles.getUsersInRole 'manager'