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
    today = moment(Date.now()).format('YYYYMMDD')
    rootRef.child('attendance').child(today).orderByChild('slack').on 'child_added', (snap) ->
      val = snap.val()
      if val.attended == false
        user = new Object
        user.room = val.slack.toString()
        robot.send user, "You have not submitted your attendance code for today, please get from your group leader if you dont have one\n If you don't enter one by 12pm you will be marked absent for pd today"

  getNotAttended: (robot) ->
    today = moment(Date.now()).format('YYYYMMDD')
    notattended = 'The following persons did not attend pd today\n'

    rootRef.child('attendance').child(today).orderByChild('slack').on 'child_added', (snap) -> 
      val = snap.val()
      if val.attended == false 
        notattended = notattended + '`' + val.slack.toString() + '`' + '\n'

    rootRef.child('admin').once 'value', (admin) ->
      user = new Object
      user.room = admin.val().toString()
      robot.send user, notattended
