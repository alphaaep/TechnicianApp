Router.route 'admins'
Router.route 'managers'
Router.route 'technicians'
Router.route 'all'
Router.route 'addUser'
Router.route 'userDetails', {
  path: '/userDetails/:_id'
  subscriptions: ->
    @subscribe 'users'
    @subscribe('user', @params._id).wait()
  waitOn: -> Meteor.subscribe 'user', @params._id
  data: ->
    Meteor.users.findOne @params._id
}

if Meteor.isClient
  Meteor.subscribe 'users'

  Template.admins.helpers
    admins: ->
      Roles.getUsersInRole 'admin'

  Template.addUser.events
    'submit form': (e) ->
      e.preventDefault()
      user =
        profile:
          name: $(e.target).find('[name=name]').val()
          phone: $(e.target).find('[name=phone]').val()
          skype: $(e.target).find('[name=skype]').val()
        email: $(e.target).find('[name=email]').val()
        username: $(e.target).find('[name=username]').val()
        password: $(e.target).find('[name=password]').val()
      roles = []
      $(e.target).find('input[name=role]:checked').each ->
        roles.push this.value
      Meteor.call 'createUser', user, roles
      Router.go '/admins'

  Template.userDetails.helpers
    email: ->
      @emails[0].address
    isAdmin: ->
      Roles.userIsInRole(@_id, 'admin')
    isManager: ->
      Roles.userIsInRole(@_id, 'manager')
    isTechnician: ->
      Roles.userIsInRole(@_id, 'technician')

  Template.userDetails.events
    'submit form.edit_user': (e) ->
      e.preventDefault()
      user =
        profile:
          name: $(e.target).find('[name=name]').val()
          phone: $(e.target).find('[name=phone]').val()
          skype: $(e.target).find('[name=skype]').val()
        emails: [
          {
            address: $(e.target).find('[name=email]').val()
            verified: false
          }
        ]
#        username: $(e.target).find('[name=username]').val()
        password: $(e.target).find('[name=password]').val()
      roles = []
      $(e.target).find('input[name=role]:checked').each ->
        roles.push this.value
      Meteor.call 'updateUser', @_id, user, roles
      Router.go '/'

  Template.managers.helpers
    managers: ->
      Roles.getUsersInRole 'manager'

  Template.technicians.helpers
    technicians: ->
      Roles.getUsersInRole 'technician'

  Template.all.helpers
    unspecified: ->
      Meteor.users.find()

  Template.user.helpers
    email: ->


  Template.user.events
    click: ->
      Router.go 'userDetails', {_id: @_id}

Meteor.users.timestampable()

Meteor.users.before.insert (userId, doc) ->
  Logger.logInsert doc, 'users'
Meteor.users.before.update (userId, doc, fieldName, modifier) ->
  Logger.logUpdate doc, modifier, 'users'
Meteor.users.before.remove (userId, doc) ->
  Logger.logRemove doc, 'users'

if Meteor.isServer
  Meteor.publish 'users', ->
    Meteor.users.find()
  Meteor.publish 'user', (_id) ->
    Meteor.users.find(_id)

  Meteor.publish 'technicians', ->
    Roles.getUsersInRole 'technician'

  Meteor.publish 'managers', ->
    Roles.getUsersInRole 'manager'

  Meteor.methods
    addUser: (user, roles) ->
      userId = Accounts.createUser user
      Roles.addUsersToRoles userId, roles
    updateUser: (_id, user, roles) ->
      Meteor.users.update(_id, {$set: user})
      Roles.setUserRoles _id, roles