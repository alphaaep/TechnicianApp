Router.route '/', ->

  if Roles.userIsInRole(Meteor.userId(), 'admin')
    Router.go 'admins'
  else if Roles.userIsInRole(Meteor.userId(), 'manager')
    Router.go 'clients'
  else if Roles.userIsInRole(Meteor.userId(), 'technician')
    Router.go 'schedule'
#  else
#    Router.go 'dashboard'

#Router.route 'dashboard'