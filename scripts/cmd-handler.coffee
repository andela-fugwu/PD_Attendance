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