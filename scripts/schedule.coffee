CronJob = require('cron').CronJob
code = require('./code')
cmdHandler = require('./cmd-handler')
_ = require('lodash')

module.exports =
  run: (robot) ->
    new CronJob('00 00 9 * * 1,4,5', (->
      cmdHandler.getGroups (groups) ->
        user = new Object
        _.each groups, (group) ->
          cmdHandler.getGLead group.leader, (slack_id) ->
            code.generate group.length, (attendanceCodes) ->
              user.room = slack_id.toString()
              message_string = 'Attendance codes for today are: \n'
              _.each attendanceCodes, (code) ->
                message_string = message_string + '`' + code + '`' + '\n'
              message_string = message_string + 'Please share to every member of your group that was present for pd today. let them dm the bot in this format "code: your-code" to register for attendance \n'
              robot.send user, message_string
              console.log 'code sent to : ' + user.room
              console.log message_string
        ), null, true, 'Africa/Lagos')

    #runs every at 8 am every monday, thursday and frid
    new CronJob('00 00 8 * * 1,4,5', (->
      code.setAttendance()
    ), null, true, 'Africa/Lagos')

    new CronJob('00 00 16 * * 1,4,5', (->
      code.expireCodes()
    ), null, true, 'Africa/Lagos')

    new CronJob('00 30 15 * * 1,4,5', (->
      cmdHandler.sendReminders(robot)
    ), null, true, 'Africa/Lagos')

    new CronJob('00 50 15 * * 1,4,5', (->
      cmdHandler.sendReminders(robot)
    ), null, true, 'Africa/Lagos')

    # new CronJob('00 45 10 * * 1,4,5', (->
    #   cmdHandler.sendReminders(robot)
    # ), null, true, 'Africa/Lagos')

    new CronJob('00 05 16 * * 1,4,5', (->
      cmdHandler.getNotAttended(robot)
    ), null, true, 'Africa/Lagos')
