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