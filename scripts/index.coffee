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

rootRef = null

module.exports = (robot) ->
  authenticate.firebase (err, ref) ->
    if !err
      rootRef = ref
      schedule.run(robot)
      skilltreeWorker(rootRef)

  robot.hear /(.*)information?/i, (res) ->
    res.send 'I give PD details'