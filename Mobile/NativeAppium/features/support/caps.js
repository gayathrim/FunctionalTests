'use strict';

module.exports = {
  ios: {
    '8.3': {
      platformName: 'ios',
      platformVersion: '8.3',
      deviceName: 'iPhone 6',
      app: __dirname + "/../../apps/appName.zip"
    },
  },

  android: {
    '4.1': {
      platformName: 'Android',
      platformVersion: '4.1',
      deviceName: 'Android Phone',
      app: __dirname + "/../../apps/appName.apk"
    },
    '4.2': {
      platformName: 'Android',
      platformVersion: '4.2',
      deviceName: 'Android Phone',
      app: __dirname + "/../../apps/appName.apk"
    },
    '4.4': {
      platformName: 'Android',
      platformVersion: '4.4',
      deviceName: 'Android Phone',
      app: __dirname + "/../../apps/appName.apk"
    }
  },
};
