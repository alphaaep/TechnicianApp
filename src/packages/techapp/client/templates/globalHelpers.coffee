Template.registerHelper 'isActiveRoute', (path)->
  currPath = Router.current().route.path()
  if '/'+currPath is path
    'theme_color active'