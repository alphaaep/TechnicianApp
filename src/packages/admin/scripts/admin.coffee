if Meteor.isClient
  Techapp.nav.push({
    title: "User admin"
    icon: 'fa-user'
    role: 'admin'
    links: [
      {
        link: 'admins'
        title: 'Admins'
      }, {
        link: 'managers'
        title: 'Managers'
      }, {
        link: 'technicians'
        title: 'Technicians'
      }, {
        link: 'all'
        title: 'All'
      },
    ]
  });