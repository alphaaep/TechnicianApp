@Tables = {}

Meteor.isClient && Template.registerHelper 'Tables', Tables

Tables.CalloutsNotDone = new Tabular.Table
  name: "Callouts Not Done"
  collection: Callouts
  extraFields: ['done', 'clientId','end']
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
      data: "start"
      title: "Start Time"
      render: (val) ->
        if val
          moment(new Date val).calendar()
        else
          'Not set'
    }
    { tmpl: Meteor.isClient and Template.calloutDoneButton }
  ]

Tables.CalloutsDone = new Tabular.Table
  name: 'Callouts Done'
  collection: Callouts
  extraFields: ['done', 'clientId']
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
      data: "start"
      title: "Start Time"
      render: (val) ->
        if val
          moment(new Date val).calendar()
        else
          'Not set'
    }
    {
      data: 'end'
      title: 'End Time'
      render: (val) ->
        if val
          moment(new Date val).calendar()
        else
          'Not set'
    }
    {
      title: 'Hours'
      render: (v,t,d)->
        start = moment(new Date(d.start))
        end = moment(new Date(d.end))
        end.diff(start, 'hours')
    }
    { tmpl: Meteor.isClient and Template.calloutDoneButton }

  ]


Router.route 'schedule',{
  path: '/schedule'
  subscriptions: ->
    @subscribe 'clients'
  data: ->
    callouts: ->
      Callouts.find(technicianId: Meteor.userId())
    clients: ->
      Clients.find()
}

Router.route 'completeCallout',{
  path: '/completeCallout/:_id'
  subscriptions: ->
    @subscribe 'callouts'
    @subscribe 'callout', @params._id
    @subscribe 'clients'
  data: ->
      Callouts.findOne(@params._id)
}

if Meteor.isClient
  Template.schedule.helpers
    doneSelector: ->
      {done: true}
    notDoneSelector: ->
      {done: false}

  Template.calloutDoneButton.helpers
    text: ->
      if @end then "Edit" else "Done"

  Template.completeCallout.events
    'submit form': (e) ->
      e.preventDefault()
      callout = @_id
      data = {
        done: $(e.target).find('[name=done]').is(':checked')
        start: $(e.target).find('[name=start]').val()
        end: $(e.target).find('[name=end]').val()
        cost: $(e.target).find('[name=cost]').val()
        note: $(e.target).find('[name=note]').val()
      }
      Meteor.call 'updateCallout', callout, data
      Router.go 'schedule'

  Template.completeCallout.onRendered ->
    @$('.datetimepicker').datetimepicker()