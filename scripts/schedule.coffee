CronJob = require('cron').CronJob
code = require('./code')
cmdHandler = require('./cmd-handler')

module.exports = 
  run: (robot) ->
    new CronJob('00 00 8 * * 1,4,5', (->
      code.generate (attendanceCode) ->
        cmdHandler.getAdmin (adminId) ->
          user = new Object
          user.room = adminId.toString()
          robot.send user, 'Attendance code for today is; ' + '`' + attendanceCode + '`'
        ), null, true, 'Africa/Lagos')

    #runs every at 8 am every monday, thursday and friday
    new CronJob('00 00 8 * * 1,4,5', (->
      code.setAttendance()
    ), null, true, 'Africa/Lagos')