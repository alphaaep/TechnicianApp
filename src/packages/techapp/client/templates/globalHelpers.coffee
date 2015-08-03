Template.registerHelper 'isActiveRoute', (path)->
  currPath = Router.current().route.path()
  if currPath is '/'+path
    return 'theme_color active'