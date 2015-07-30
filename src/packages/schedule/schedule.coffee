Router.route 'schedule',{
  path: '/schedule'
  subscriptions: ->
    @subscribe 'callouts'
    @subscribe 'clients'
  data: ->
    callouts: ->
      Callouts.find(technicianId: Meteor.userId())
    clients: ->
      Clients.find()
}