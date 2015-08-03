Template.activity.helpers
  description: ->
    switch
      when @type is 'insert'
        @user().profile.name.toString()+' added to '+@col.toString()+ ' ' + new moment(new Date(@createdAt)).calendar()
      when @type is 'update'
        @user().profile.name.toString()+' updated one of '+@col.toString()+ ' ' + new moment(new Date(@createdAt)).calendar()