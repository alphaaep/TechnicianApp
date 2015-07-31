@userExists = (username) ->
  Meteor.users.findOne({username: username})

unless @userExists('admin')
  admin =
    username: "admin"
    email: "admin@admin.com"
    password: "administrator"
    profile:
      name: "Administrator"
  adminId = Accounts.createUser admin
  Roles.addUsersToRoles adminId, 'admin'

unless @userExists('manager')
  manager =
    username: "manager"
    email: "manager@manager.com"
    password: "manager"
    profile:
      name: "Manager"
  managerId = Accounts.createUser manager
  Roles.addUsersToRoles managerId, 'manager'

unless @userExists('technician')
  technician =
    username: "technician"
    email: "technician@technician.com"
    password: "technician"
    profile:
      name: "Technician"
  technicianId = Accounts.createUser technician
  Roles.addUsersToRoles technicianId, 'technician'