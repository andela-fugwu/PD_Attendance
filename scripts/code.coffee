RandomCodes = require('random-codes')
Firebase = require('firebase')
moment = require('moment')
_ = require('lodash')
authenticate = require('./authentication')
rootRef = authenticate.root
attendanceCodesRef = rootRef.child('attendance_codes')

config = {
  chars: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",
  separator: '-',
  mask: '*',
  parts: 4
  part_size: 4
}

module.exports = 
  generate: (number ,cb ) ->
    rc = new RandomCodes(config)
    attendanceCode = rc.generate()
    codes = []
    i = 1
    while i <= number
      code = rc.generate()
      codes.push(code)
      attendanceCodesRef.push({code: code})
      i++
    cb(codes)

  setAttendance: () ->
    today = moment(Date.now()).format('YYYYMMDD')
    rootRef.child('fellows').once 'value', (fellowSnap) ->
      fellowSnap.forEach (person) ->
        slackName = person.val().slack_id
        cohort = person.val().cohort.name in ['Class I', 'Class II', 'Class III', 'Class IV', 'Class V', 'Class VI', 'Class VII']
        if slackName? & cohort
          user = rootRef.child('attendance').child(today).push()
          user.set({slack: slackName, attended:false, code:'none'})
          console.log {slack: slackName, attended:false, code:'none'}
        false

  verify: (enteredCode, cb) ->
    attendanceCodesRef.orderByChild('code').equalTo(enteredCode).once 'value', (snap) ->
      if snap.val()
        uid =  Object.keys(snap.val())[0]
        if uid
          attendanceCodesRef.child(uid).remove()
          return cb(true)
      return cb(false)

  expireCodes: () ->
    attendanceCodesRef.set 'codes expired'
    return



