"use strict";
var Q = require('q')
  , _ = require('lodash');

module.exports =  function () {

    var takeScreenshotIfNeeded = function(driver, scenario) {
      return Q.promise(function(resolve) {
        if(!scenario.isFailed())   return resolve(driver);
        driver.takeScreenshot()
        .then(function (buffer) {
            scenario.attach(new Buffer(buffer, 'base64').toString('binary'), 'image/png');
            resolve(driver);
        });
      });
    };

    var captureTagNamesIfFailed = function(scenario) {
      return Q.promise(function(resolve){
        if(!scenario.isFailed()) return resolve();
        console.log(scenario.getTags()[0].getName());
        resolve();
      });
    };

    var quitDriver = function(driver) {
      return driver.quit();
    };

    this.After(function (scenario, callback) {
      // Q.all([ captureTagNamesIfFailed(scenario),
      //         takeScreenshotIfNeeded(this.driver, scenario)])
      // .then(quitDriver(this.driver))
      // .finally(callback);
        takeScreenshotIfNeeded(this.driver, scenario)
        .then(quitDriver)
        .finally(callback);
    });
};
