Template.login.events
  "submit form": (e) ->
    e.preventDefault()
    user = $(e.target).find('[name=email]').val()
    password = $(e.target).find('[name=password]').val()
    Meteor.loginWithPassword user, password, (err)->
      if err
        console.log(err)
        toastr.error(err.reason, 'Login Error')
      else
        Router.go '/'