development =
  firebase:
    rootRefUrl: 'https://pdbot-attendance-dev.firebaseio.com/'
    secretKey: '7whzI11RZI76AABkQbDAW2g0EVVJcaBH65FVH4x2'

  skilltree:
    users: 'http://skilltree.andela.co/api/v1/users'
    headers:
      'X-AUTH-TOKEN': process.env.SKILL_TREE_TOKEN

  slack:
    userList: 'https://slack.com/api/users.list'
    token: process.env.SLACK_TOKEN

production =
  firebase:
    rootRefUrl: process.env.FB_SERVER_UID
    secretKey: process.env.FB_SECRET_KEY

  skilltree:
    users: 'http://skilltree.andela.co/api/v1/users'
    headers:
      'X-AUTH-TOKEN': process.env.SKILL_TREE_TOKEN

  slack:
    userList: 'https://slack.com/api/users.list'
    token: process.env.SLACK_TOKEN

staging =
  firebase:
    rootRefUrl: process.env.FB_SERVER_UID
    secretKey: process.env.FB_SECRET_KEY

  skilltree:
    users: 'http://skilltree.andela.co/api/v1/users'
    headers:
      'X-AUTH-TOKEN': process.env.SKILL_TREE_TOKEN

  slack:
    userList: 'https://slack.com/api/users.list'
    token: process.env.SKILL_TREE_TOKEN


config =
  development: development
  production: production
  staging: staging

module.exports = config

