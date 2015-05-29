
Firebase = require("firebase")
FirebaseTokenGenerator = require("firebase-token-generator")
env = 'development'
config = require('../config/config')[env]
rootRef = new Firebase(config.firebase.rootRefUrl)

module.exports = 
  root : rootRef

  firebase : (cb) ->
    tokenGenerator = new FirebaseTokenGenerator(config.firebase.secretKey)
    token = tokenGenerator.createToken(
      uid: 'pd-attendance-bot'
      name: 'pd-attendance-bot')
    rootRef.authWithCustomToken token, (error, authData) ->
      if error
        cb error
      else
        cb null, rootRef
      return
    return