CronJob = require('cron').CronJob
code = require('./code')

module.exports = 
  run: (robot) ->
    new CronJob('00 12 16 * * 1-5', (->
      code.generate (attendanceCode) ->
        user = new Object
        user.room = "dewunmi" #still hard-coded, would change to admin from firebase later
        robot.send user, 'Attendance code for today is; ' + '`' + attendanceCode + '`'
      return
    ), null, true, 'Africa/Lagos')

   