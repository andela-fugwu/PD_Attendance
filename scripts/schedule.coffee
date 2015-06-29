CronJob = require('cron').CronJob
code = require('./code')
cmdHandler = require('./cmd-handler')
_ = require('lodash')

module.exports = 
  run: (robot) ->
    new CronJob('00 00 9 * * 1,4,5', (->
      cmdHandler.getGLeads (leads) ->
        user = new Object
        _.each leads, (codes_number, slack_id) ->
          
          code.generate codes_number, (attendanceCodes) -> 
            user.room = slack_id.toString()
            message_string = 'Attendance codes for today are: \n'
            _.each attendanceCodes, (code) ->
              message_string = message_string + '`' + code + '`' + '\n'
            message_string = message_string + 'Please share to every member of your group that was present for pd today. let them dm the bot in this format "code: your-code" to register for attendance \n'
            robot.send user, message_string
            console.log 'code sent to : ' + user.room + '  ' + message_string
        ), null, true, 'Africa/Lagos')

    #runs every at 8 am every monday, thursday and friday
    new CronJob('00 00 8 * * 1,4,5', (->
      code.setAttendance()
    ), null, true, 'Africa/Lagos')

    new CronJob('00 00 12 * * 1,4,5', (->
      code.expireCodes()
    ), null, true, 'Africa/Lagos')

    new CronJob('00 00 11 * * 1,4,5', (->
      cmdHandler.sendReminders(robot)
    ), null, true, 'Africa/Lagos')

    new CronJob('00 30 10 * * 1,4,5', (->
      cmdHandler.sendReminders(robot)
    ), null, true, 'Africa/Lagos')

    new CronJob('00 45 10 * * 1,4,5', (->
      cmdHandler.sendReminders(robot)
    ), null, true, 'Africa/Lagos')

    new CronJob('00 30 12 * * 1,4,5', (->
      cmdHandler.getNotAttended(robot)
    ), null, true, 'Africa/Lagos')