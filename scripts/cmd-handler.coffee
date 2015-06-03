firebase =  require('firebase')
moment = require('moment')
_ = require('lodash')
authenticate = require('./authentication')

rootRef = authenticate.root

module.exports = 
  
  getAdmin: (cb) ->
    rootRef.child('admin').once 'value', (snap) ->
      cb(Object.keys snap.val())
