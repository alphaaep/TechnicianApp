if Meteor.isClient
  Techapp.nav.push({
    title: "Management"
    icon: ""
    role: "manager"
    links: [
      {
        link: 'clients'
        title: 'Clients'
      }
      {
        link: 'callouts'
        title: 'Callouts'
      }
    ]
  })