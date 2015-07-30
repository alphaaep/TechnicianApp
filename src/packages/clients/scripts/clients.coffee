@Clients = new Mongo.Collection 'clients'

@TabularClients = new Tabular.Table
  name: "Clients"
  collection: Clients
  columns: [
    {data: "name", title: "Name"}
    {data: "contact", title: "Contact"}
    {data: "address", title: "Address"}
    {data: "phone", title: "Phone"}
    {data: "email", title: "Email"}
    {tmpl: Meteor.isClient and Template.editClientButton }
    {tmpl: Meteor.isClient and Template.deleteClientButton }
  ]
Meteor.isClient and Template.registerHelper 'TabularClients', TabularClients

Router.route 'clients', {
  subscriptions: ->
    @subscribe 'clients'
  waitOn: -> Meteor.subscribe 'clients'
  data: -> Clients.find()
}
Router.route 'addClient'
Router.route 'editClient', {
  path: '/editClient/:_id'
  subscriptions: ->
    @subscribe 'clients'
    @subscribe('client', @params._id).wait()
  waitOn: -> Meteor.subscribe 'client', @params._id
  data: -> Clients.findOne @params._id
}


if Meteor.isClient
  Template.editClientButton.events
    'click .edit': ->
      Router.go 'editClient', {_id:this._id}
  Template.deleteClientButton.events
    'click .delete': ->
      Meteor.call 'deleteClient', {_id:this._id}

  Template.addClient.events
    'submit form': (e)->
      e.preventDefault()
      client = {
        name: $(e.target).find('[name=name]').val()
        contact: $(e.target).find('[name=contact]').val()
        address: $(e.target).find('[name=address]').val()
        phone: $(e.target).find('[name=phone]').val()
        email: $(e.target).find('[name=email]').val()
      }
      Meteor.call 'insertClient', client
      Router.go 'clients'

  Template.editClient.events
    'submit form': (e)->
      e.preventDefault()
      client = @_id
      data = {
        name: $(e.target).find('[name=name]').val()
        contact: $(e.target).find('[name=contact]').val()
        address: $(e.target).find('[name=address]').val()
        phone: $(e.target).find('[name=phone]').val()
        email: $(e.target).find('[name=email]').val()
      }
      Meteor.call 'updateClient', client, data
      Router.go 'clients'

if Meteor.isServer
  Meteor.publish 'clients', ->
    Clients.find()

  Meteor.publish 'client', (id)->
    Clients.find id

  Meteor.methods
    insertClient: (client) ->
      Clients.insert client
    updateClient: (client, data) ->
      Clients.update client, {$set: data}
    deleteClient: (client) ->
      Clients.remove client