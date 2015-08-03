Template.user.events
  click: ->
    Router.go 'userDetails', {_id: @_id}