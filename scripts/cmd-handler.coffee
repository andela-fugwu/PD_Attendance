firebase =  require('firebase')
moment = require('moment')
_ = require('lodash')
authenticate = require('./authentication')

rootRef = authenticate.root

module.exports = 
  
  getGLeads: (cb) ->
    rootRef.child('group_leaders').once 'value', (snap) ->
      cb(snap.val())

  setPresent: (slackId, code_used) ->
    today = moment(Date.now()).format('YYYYMMDD')
    rootRef.child('attendance').child(today).orderByChild('slack').equalTo(slackId).limitToFirst(1).on 'child_added', (snap) ->
      val = snap.val()
      val.attended = true
      val.code = code_used
      snap.ref().set(val)

  sendReminders: (robot) ->
    counter = 0;
    today = moment(Date.now()).format('YYYYMMDD')
    rootRef.child('attendance').child(today).orderByChild('slack').on 'child_added', (snap) ->
      val = snap.val()
      if val.attended == false
        user = new Object
        user.room = val.slack.toString()
        console.log 'reminder sent to', user.room
        robot.send user, "You have not submitted your attendance code for today, please get from your group leader if you don't have one\n If you don't enter one by 4pm `you will be marked absent for pd today`\n Send your code in this format `code: your-code-today`"
        if counter == 8
          setTimeout (->
            counter = 0
            return
          ), 120000

  getNotAttended: (robot) ->
    notattended = 'The following persons did not attend pd today\n'
    today = moment(Date.now()).format('YYYYMMDD')
    rootRef.child('attendance').child(today).orderByChild('slack').on 'child_added', (snap) ->
      val = snap.val()
      if val.attended == false
        user = new Object
        user.room = val.slack.toString()
        notattended = notattended + '`' + user.room + '`\n'
    console.log notattended

    rootRef.child('admin').once 'value', (admin) ->
      user = new Object
      user.room = admin.val().toString()
      robot.send user, notattended
