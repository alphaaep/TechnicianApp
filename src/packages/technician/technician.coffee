if Meteor.isClient
  Techapp.nav.push({
    title: "Technician"
    icon: ""
    role: "technician"
    links: [
      {
        link: 'schedule'
        title: 'Schedule'
      }
    ]
  })
