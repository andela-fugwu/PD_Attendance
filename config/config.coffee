development = 
  firebase:
    rootRefUrl: 'https://pd-attendance-dev.firebaseio.com/'
    secretKey: 'zrGY4ipiJKGHzMN6refd5wvT3NfkHKJfPsSp1tTa'

production = 
  firebase:
    rootRefUrl: 'https://pd-attendance-prod.firebaseio.com/'
    secretKey: 'qAfuC4xpnJZAmG0DkkXkhzwcp0J6HdnNYfaC2Biv'

config = 
  development: development
  production: production

module.exports = config
