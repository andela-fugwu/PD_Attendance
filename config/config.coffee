development = 
  firebase:
    rootRefUrl: 'https://pdbot-attendance-dev.firebaseio.com/'
    secretKey: '7whzI11RZI76AABkQbDAW2g0EVVJcaBH65FVH4x2'

  skilltree: 
    users: 'http://skilltree.andela.co/api/v1/users'
    headers: 
      'X-AUTH-TOKEN': 'txPFk-ppyzzI0f6iAoF3jC3amGUosLsabznp26gUxn0'

  slack:
    userList: 'https://slack.com/api/users.list'
    token: 'xoxp-2853699384-2972142149-4450365564-69395f'

production = 
  firebase:
    rootRefUrl: 'https://pd-attendance-prod.firebaseio.com/'
    secretKey: 'qAfuC4xpnJZAmG0DkkXkhzwcp0J6HdnNYfaC2Biv'

   skilltree: 
    users: 'http://skilltree.andela.co/api/v1/users'
    headers: 
      'X-AUTH-TOKEN': 'txPFk-ppyzzI0f6iAoF3jC3amGUosLsabznp26gUxn0'

  slack:
    userList: 'https://slack.com/api/users.list'
    token: 'xoxp-2853699384-2972142149-4450365564-69395f'

config = 
  development: development
  production: production

module.exports = config

