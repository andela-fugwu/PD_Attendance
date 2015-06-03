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
schedule = require('./schedule')
skilltreeWorker = require('../workers/skilltree')
slackWorker = require('../workers/slack-worker')

rootRef = null

module.exports = (robot) ->
  authenticate.firebase (err, ref) ->
    if !err
      rootRef = ref
      schedule.run(robot)
      skilltreeWorker(rootRef)
      console.log 'run'
      slackWorker(rootRef)

  robot.hear /(.*)information?/i, (res) ->
    res.send 'I give PD details'