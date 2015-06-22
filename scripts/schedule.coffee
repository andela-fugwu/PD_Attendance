CronJob = require('cron').CronJob
code = require('./code')
cmdHandler = require('./cmd-handler')
_ = require('lodash')

module.exports = 
  run: (robot) ->
    new CronJob('00 38 8 * * 1,4,5', (->
      cmdHandler.getGLeads (leads) ->
        user = new Object
        _.each leads, (codes_number, slack_id) ->
          
          code.generate codes_number, (attendanceCodes) -> 
            user.room = slack_id.toString()
            robot.send user, 'Attendance codes for today are: '
            _.each attendanceCodes, (code) ->
              robot.send user, '`' + code + '`'
            robot.send user, 'Please share to every member of your group that was present for pd today. let them dm the bot in this format "code: your-code" to register for attendance'
        ), null, true, 'Africa/Lagos')

    #runs every at 8 am every monday, thursday and friday
    new CronJob('00 00 8 * * 1,4,5', (->
      code.setAttendance()
    ), null, true, 'Africa/Lagos')