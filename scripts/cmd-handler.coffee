firebase =  require('firebase')
moment = require('moment')
_ = require('lodash')
authenticate = require('./authentication')

rootRef = authenticate.root

module.exports = 
  
  getAdmin: (cb) ->
    rootRef.child('admin').once 'value', (snap) ->
      cb(Object.keys snap.val())

  setPresent: (slackId) ->
    today = moment(Date.now()).format('YYYYMMDD')
    rootRef.child('attendance').child(today).orderByChild('slack').equalTo(slackId).limitToFirst(1).on 'child_added', (snap) ->
      console.log snap.ref().key()
      val = snap.val()
      val.attended = true
      snap.ref().set(val)



