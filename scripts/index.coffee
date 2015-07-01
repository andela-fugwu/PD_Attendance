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

  robot.respond /hi?/i, (res) ->
    username = res.message.user.name
    console.log 'hi', username
    res.send 'Hello ' + username + '; I am pd-bot. I give PD details'
      
  robot.respond /information?/i, (res) ->
    console.log 'information' + ' ' + res.message.user.name
    res.send 'I give PD details'

  robot.respond /(.*)help?/i, (res) ->
    console.log 'help', res.message.user.name
    res.send 'send "code: your-code" to register for attendance'

  robot.respond /code: (.*)/i, (res) ->
    console.log 'code', res.message.user.name
    enteredCode = res.match[1] 
    user = res.message.user.name
    code.verify enteredCode, (correct) ->
      if correct
        cmdHandler.setPresent user, enteredCode
        res.reply "You've been registered as present"
        return
      else 
        res.reply "Code Incorrect!"
        return

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"
    if res?
      res.reply "DOES NOT COMPUTE"


