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