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
cmdHandler = require('./cmd-handler')
code = require('./code')

rootRef = null

module.exports = (robot) ->
  authenticate.firebase (err, ref) ->
    if !err
      rootRef = ref
      schedule.run(robot)
      skilltreeWorker(rootRef)
      slackWorker(rootRef)

  robot.respond /(.*)information?/i, (res) ->
    res.send 'I give PD details'
  robot.respond /(.*)help?/i, (res) ->
    res.send 'send "code: your-code" to register for attendance'

  robot.respond /code: (.*)/i, (res) ->
    enteredCode = res.match[1] 
    user = res.message.user.name
    code.verify enteredCode, (correct) ->
      if correct
        cmdHandler.setPresent user, enteredCode
        res.reply "You've been registered as present"
        return
      res.reply "Code Incorrect!"