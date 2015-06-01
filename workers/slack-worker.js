// 'use strict';

// var _ = require('lodash'),
//     env = process.env.NODE_ENV || 'development',
//     config = require('../config/config')[env],
//     CronJob = require('cron').CronJob,
//     needle = require('needle');

// var getSlackUserList = function(rootRef) {
//   var url = config.slack.userList + '?token=' + config.slack.token;
//   needle.get(url, function(err, res) {
//     var users = res.body.members;
//     _.each(users, function(user) {
//         var email = user.profile.email;
//         var username = user.name;
//         rootRef.child('people').orderByChild('email').startAt(email).endAt(email).on('child_added', function(snap) {
//           if(snap.val()) {
//             var uid = snap.ref().key();
//             rootRef.child('index/slack/mapping').child(uid).set(username);
//           }
//         });
//     });
//   });
// };

// module.exports = function(rootRef) {
//   // Weekly schedule (4pm every sunday)
//   new CronJob('0 0 16 * * 0', function() {
//     getSlackUserList(rootRef);
//   }, null, true, 'America/New_York');
// };