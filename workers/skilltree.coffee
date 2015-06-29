_ = require('lodash')
env = 'development'
config = require('../config/config')[env]
CronJob = require('cron').CronJob
needle = require('needle')
async = require('async')
page = 1

getUsers = (rootRef, url, header) ->
  options = headers: header
  needle.get url, options, (err, resp) ->
    if resp
      async.waterfall [ (callback) ->
        users = resp.body
        _.each users, (user) ->
          uid = user.uid
          delete user.uid
          delete user.first_name
          delete user.last_name
          delete user.known_as
          delete user.tags
          if user.cohort
            if user.cohort.name is "Management" or user.cohort.name is "Ninjas"
              console.log 'mgt or ninja'
            else
              rootRef.child('fellows').child(uid).set user
          return
        callback null, users
        return
      ], (err, result) ->
            if result.length != 0
              newUrl = config.skilltree.users + '?page=' + page
              getUsers rootRef, newUrl, config.skilltree.headers
              page += 1
            return
        return
      return

module.exports = (rootRef) ->
  #Weekly schedule (4pm every sunday)
  new CronJob('0 0 16 * * 0', (->
    getUsers rootRef, config.skilltree.users, config.skilltree.headers
    return
  ), null, true, 'Africa/Lagos')
  return

