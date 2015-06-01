RandomCodes = require('random-codes')
Firebase = require('firebase')
authenticate = require('./authentication')
rootRef = authenticate.root
attendanceCodeRef = rootRef.child('attendance_code')

config = {
  chars: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",
  separator: '-',
  mask: '*',
  parts: 4
  part_size: 4
}

module.exports = 
  generate: (cb) ->
    rc = new RandomCodes(config)
    attendanceCode = rc.generate()
    attendanceCodeRef.set(attendanceCode, () ->
      cb(attendanceCode)
      )




