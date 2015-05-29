# Description:
#   Allows hubot to run commands.
#
# Commands:
#   information: Display info about the bot
#
# Author:
#   andela-aadesokan, andela-fugwu, andela-fadebayo, andela-unkwocha

firebase =  require('firebase')
moment = require('moment')
_ = require('lodash')
CronJob = require('cron').CronJob
authenticate = require('./authentication')

rootRef = null

module.exports = (robot) ->
  authenticate.firebase (err, ref) ->
    if !err
      rootRef = ref

  robot.hear /(.*)information?/i, (res) ->
    res.send 'I give PD details'
      