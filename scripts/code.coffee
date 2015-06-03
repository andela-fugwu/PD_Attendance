RandomCodes = require('random-codes')
Firebase = require('firebase')
moment = require('moment')
_ = require('lodash')
authenticate = require('./authentication')
rootRef = authenticate.root
attendanceCodeRef = rootRef.child('attendance_code')

config = {
  chars: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",
  separator: '-',
  mask: '*',
  parts: 4
  part_size: 4
}

module.exports = 
  generate: (cb) ->
    rc = new RandomCodes(config)
    attendanceCode = rc.generate()
    attendanceCodeRef.set(attendanceCode, () ->
      cb(attendanceCode)
      )

  setAttendance: () ->
    today = moment(Date.now()).format('YYYYMMDD')
    rootRef.child('fellows').once 'value', (fellowSnap) ->
      fellowSnap.forEach (person) ->
        slackName = person.val().slack_id
        if slackName?
          user = rootRef.child('attendance').child(today).push()
          user.set({slack: slackName, attended:false})
        false

  verify: (enteredCode, cb) ->
    rootRef.child('attendance_code').once 'value', (codeSnap) ->
      return cb(true) if enteredCode is codeSnap.val()
      cb(false)







