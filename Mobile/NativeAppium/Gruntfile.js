'use strict';

var forever = require('forever-monitor')
  , path = require('path')
  , ps = require('ps-node')
  , format = require('string-template')
  , _ = require('lodash');

module.exports = function(grunt) {

  grunt.initConfig({

    mkdir: {
      all: {
        options: {
          create: ['log', 'reports', 'reports/screenshot']
        }
      },
    },

    cucumberjs: {
      ios: {
        options: {
          format: 'html',
          output: './reports/ios-report.html',
          theme: 'bootstrap',
          tags: ['@ios'],
          debug: true
        },
        features : []
      },
      android : {
        options: {
          format: 'html',
          output: './reports/regression-report.html',
          theme: 'bootstrap',
          tags: ['@android', '~@wip'],
          debug: true
        },
        features : []
      },
      smoke : {
       options: {
         format: 'html',
         output: './reports/smoke-report.html',
         theme: 'bootstrap',
         tags: ['@smoke'],
         debug: true
       },
       features : []
      },
      now : {
       options: {
         format: 'html',
         output: './reports/smoke-report.html',
         theme: 'bootstrap',
         tags: ['@now'],
         debug: true
       },
       features : []
      }
    },

    clean: {
      reports: ['reports', 'log']
    }
  });

  grunt.loadNpmTasks('grunt-cucumberjs');
  grunt.loadNpmTasks('grunt-mkdir');
  grunt.loadNpmTasks('grunt-contrib-clean');

  grunt.registerTask('appium:start', 'Start appium server', function() {
    var done = this.async();
    var appium = forever.start(['./node_modules/.bin/appium'], {
      max: 1,
      silent: true,
      pidFile: path.join(__dirname, 'appium.pid'),
      logFile: path.join(__dirname, 'log', 'appium.log'),
      outFile: path.join(__dirname,'log','appium.log'),
      errFile: path.join(__dirname, 'log', 'appium_error.log')
    });

    appium.once('stdout', function() {
      grunt.log.ok('Appium server opened for business');
      appium.removeAllListeners('stderr');
      done();
    });

    appium.once('stderr', function(err) {
      grunt.log.error(format('Unable to start appium, {0}', [err]));
      appium.removeAllListeners('stdout');
      done(false);
    });
  });

  grunt.registerTask('appium:stop', 'Stop appium server', function() {
    var done = this.async();
    ps.lookup({
      command: 'node',
      arguments: './node_modules/.bin/appium',
      psargs: 'ux'
    }, function(err, results) {
      var process = results[0];
      if(process) {
        ps.kill(process.pid, function() {
          grunt.log.ok('Stopped running appium server');
          done();
        });
      } else {
        grunt.log.ok('No running appium server found');
        done();
      }
    });
  });


  grunt.registerTask('setJellyBeanPlatform1', 'Set Environment Variable', function() {
    process.env = _.merge(process.env, {
        PLATFORM: 'android',
        VERSION: '4.1'
      });
  });

  grunt.registerTask('setJellyBeanPlatform2', 'Set Environment Variable', function() {
    process.env = _.merge(process.env, {
        PLATFORM: 'android',
        VERSION: '4.2'
      });
  });

  grunt.registerTask('setKitkatPlatform', 'Set Environment Variable', function() {
    process.env = _.merge(process.env, {
        PLATFORM: 'android',
        VERSION: '4.4'
      });
  });

  grunt.registerTask('setIosPlatform', 'Set Environment Variable', function() {
    process.env = _.merge(process.env, {
        PLATFORM: 'ios',
        VERSION: '8.3'
      });
  });

  grunt.registerTask('bootstrap', ['appium:stop', 'clean:reports', 'mkdir', 'appium:start']);
  grunt.registerTask('android:4.1', ['bootstrap', 'setJellyBeanPlatform1', 'cucumberjs:android']);
  grunt.registerTask('android:4.2', ['bootstrap', 'setJellyBeanPlatform2', 'cucumberjs:android']);
  grunt.registerTask('android:4.4', ['bootstrap', 'setKitkatPlatform', 'cucumberjs:android']);
  grunt.registerTask('smoke', ['bootstrap', 'setKitkatPlatform', 'cucumberjs:smoke']);
  grunt.registerTask('android:now', ['bootstrap', 'setKitkatPlatform', 'cucumberjs:now']);
  grunt.registerTask('ios:8.3', ['appium:stop', 'mkdir', 'appium:start','setIosPlatform', 'cucumberjs:ios']);
};
