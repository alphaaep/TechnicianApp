unless @userExists('admin') and Roles.getUsersInRole('admin').count() > 0
  adminId = Accounts.createUser admin
  Roles.addUsersToRoles adminId, 'admin'