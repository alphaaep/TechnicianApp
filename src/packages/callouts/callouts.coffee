@Callouts = new Mongo.Collection 'callouts'

@TabularCallouts = new Tabular.Table
  name: "Callouts"
  collection: Callouts
  columns: [
    {
      data: "clientId"
      title: "Client"
      render: (val) ->
        client = Clients.findOne(val)
        return client.name
    }
    { data: "request", title: "Request" }
    {
      data: "done"
      title: "Done"
      render: (val) ->
        if val is yes then return 'Yes'
        else return 'No'
    }
    {
      data: "start"
      title: "Start Date"
    }
    {
      data: "end"
      title: "End Date"
    }
    {
      data: "hours",
      title: "Hours",
      render: (v, t, d) ->
        start = moment((d.start))
        end = moment((d.end))
        start.diff(end, 'hours')
    }
    {data: "cost", title: "Cost"}
    {
      data: "technicianId",
      title: "Technician",
      render: (val) ->
        user =  Meteor.users.findOne val
        return user.profile.name
    }
    {tmpl: Meteor.isClient and Template.editCalloutButton }
    {tmpl: Meteor.isClient and Template.deleteCalloutButton }
  ]
Meteor.isClient && Template.registerHelper('TabularCallouts', TabularCallouts)

Router.route 'callouts', {
  subscriptions: ->
    @subscribe 'callouts'
    @subscribe 'clients'
    @subscribe 'users'
  waitOn: ->
    Meteor.subscribe 'callouts'
    Meteor.subscribe 'clients'
    Meteor.subscribe 'technicians'
  data: -> Callouts.find()
}
Router.route 'addCallout', {
  subscriptions: ->
    @subscribe 'clients'
    @subscribe 'technicians'
  waitOn: ->
    Meteor.subscribe 'clients'
    Meteor.subscribe 'technicians'
  data: ->
    clients: Clients.find()
    technicians: Roles.getUsersInRole 'technician'
}
Router.route 'editCallout', {
  path: '/editCallout/:_id'
  subscriptions: ->
    @subscribe 'technicians'
    @subscribe 'callouts'
    @subscribe('callout', @params._id).wait()
    @subscribe 'clients'
  waitOn: -> Meteor.subscribe 'callout', @params._id
  data: -> Callouts.findOne @params._id
}

if Meteor.isClient
  Template.editCalloutButton.events
    'click .edit': ->
      Router.go 'editCallout', {_id:this._id}
  Template.deleteCalloutButton.events
    'click .delete': ->
      Meteor.call 'deleteCallout', {_id:this._id}

  Template.addCallout.events
    'submit form': (e)->
      e.preventDefault()
      callout = {
        clientId: $(e.target).find('[name=client]').val()
        request: $(e.target).find('[name=request]').val()
        done: $(e.target).find('[name=done]').is(':checked')
        hours: $(e.target).find('[name=hours]').val()
        cost: $(e.target).find('[name=cost]').val()
        note: $(e.target).find('[name=note]').val()
        technicianId: $(e.target).find('[name=technician]').val()
      }
      Meteor.call 'insertCallout', callout
      Router.go 'callouts'

  Template.editCallout.helpers
    technicians: ->
      Roles.getUsersInRole 'technician'
    technician: ->
      Meteor.users.findOne @technicianId
    client: ->
      Clients.findOne @clientId
    isAssigned: (_id)->
      return _id is this._id

  Template.editCallout.events
    'submit form': (e)->
      e.preventDefault()
      callout = @_id
      data = {
        request: $(e.target).find('[name=request]').val()
        done: $(e.target).find('[name=done]').is(':checked')
        start: $(e.target).find('[name=start]').val()
        end: $(e.target).find('[name=end]').val()
        hours: $(e.target).find('[name=hours]').val()
        cost: $(e.target).find('[name=cost]').val()
        technicianId: $(e.target).find('[name=technician]').val()
      }
      Meteor.call 'updateCallout', callout, data
      Router.go 'callouts'
  Template.editCallout.onRendered ->
    @$('.datetimepicker').datetimepicker()

if Meteor.isServer
  Meteor.publish 'callouts', ->
    Callouts.find()

  Meteor.publish 'callout', (id)->
    Callouts.find id

  Meteor.methods
    insertCallout: (callout) ->
      Callouts.insert callout
    updateCallout: (callout, data) ->
      Callouts.update callout, {$set: data}
    deleteCallout: (callout) ->
      Callouts.remove callout