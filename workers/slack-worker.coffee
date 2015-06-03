_ = require('lodash')
env = 'development'
config = require('../config/config')[env]
CronJob = require('cron').CronJob
needle = require('needle')

getSlackUserList = (rootRef) ->
  url = config.slack.userList + '?token=' + config.slack.token
  needle.get url, (err, res) ->
    users = res.body.members
    _.each users, (user) ->
      email = user.profile.email
      username = user.name
      rootRef.child('fellows').orderByChild('email').equalTo(email).on 'child_added', (snap) ->
        if snap.val()
          uid = snap.ref().key()
          rootRef.child('fellows').child(uid).child('slack_id').set username
        return
      return
    return
  return

module.exports = (rootRef) ->
  # Weekly schedule (4pm every sunday)
  new CronJob('* * * * * *', (->
    console.log 'test'
    getSlackUserList rootRef
    return
  ), null, true, 'Africa/Lagos')
  return