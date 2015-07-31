Router.route 'login' , {
  layoutTemplate: ''
}
Router.route 'profile' , {
  path: '/profile/:_id'
  data: -> Meteor.users.findOne this.params._id
}

if Meteor.isClient
  Router.configure(
    onBeforeAction: ->
      if !Meteor.userId()
        @render 'login'
      else
        @next()
  )

  Template.login.events
    "submit form": (e) ->
      e.preventDefault()
      user = $(e.target).find('[name=email]').val()
      password = $(e.target).find('[name=password]').val()
      Meteor.loginWithPassword user, password, (err)->
        if err
          console.log('Error: '+err)
        else
          Router.go '/'

  Template.profileMini.helpers
    'user': ->
      Meteor.user()

  Template.profileMini.events
    'click .logout': ->
      Meteor.logout()
      Router.go '/'

  Template.profile.helpers
    email: ->
      @emails[0].address
    isAdmin: ->
      Roles.userIsInRole(@_id, 'admin')
    isManager: ->
      Roles.userIsInRole(@_id, 'manager')
    isTechnician: ->
      Roles.userIsInRole(@_id, 'technician')

  Template.profile.events
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
        password: $(e.target).find('[name=password]').val()
      roles = []
      $(e.target).find('input[name=role]:checked').each ->
        roles.push this.value
      Meteor.call 'updateUser', @_id, user, roles
      Router.go '/'