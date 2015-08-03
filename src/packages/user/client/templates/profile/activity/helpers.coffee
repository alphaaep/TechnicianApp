Template.profileActivity.helpers
  description: ->
    switch
      when @type is 'insert'
        'You added to '+@col.toString()+ ' ' + new moment(new Date @createdAt ).calendar()
      when @type is 'update'
        'You updated one of '+@col.toString()+ ' ' + new moment(new Date @createdAt ).calendar()