var development = {
  firebase: {
    rootRefUrl: "https://pd-attendance-dev.firebaseio.com/",
    serverUID: "pdAttendance",
    secretKey: "zrGY4ipiJKGHzMN6refd5wvT3NfkHKJfPsSp1tTa"
  }
};

var test = {
  firebase: {
    rootRefUrl: "https://pd-attendance-test.firebaseio.com/",
    serverUID: "pdAttendance",
    secretKey: "rsh2759tMQi0uIaeF3CKZ214venn1O5SwR5qyUjg"
  }
};

var production = {
  firebase: {
    rootRefUrl: process.env.FB_URL,
    serverUID: process.env.FB_SERVER_UID, 
    secretKey: process.env.FB_SECRET_KEY
  }
};

var config = {
  development: development,
  test: test,
  production: production,
};
module.exports = config;