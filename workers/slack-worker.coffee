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
      if email?
        rootRef.child('fellows').orderByChild('email').equalTo(email).on 'child_added', (snap) ->
          if snap.val()
            uid = snap.ref().key()
            rootRef.child('fellows').child(uid).child('slack_id').set username

module.exports = (rootRef) ->
  #Weekly schedule (4pm every sunday)
  new CronJob('0 0 17 * * 0', (->
    getSlackUserList rootRef
    return
  ), null, true, 'Africa/Lagos')
  # return
