'use strict';

var Q = require('q')
  , async = require('async')
  , wd = require('wd')
  , Asserter = wd.Asserter
  , chai = require("chai");
  var rek = require('rekuire')
    , config = rek('config');

var tagChaiAssertionError = function(err) {
  err.retriable = err instanceof chai.AssertionError;
  throw err;
};

exports.getListOfElementsTextById = function(driver, id){
  return Q.Promise(function(resolve){
    driver.elementsById(id).then(function(elements) {
      async.map(elements, function(element, callback){
        driver.text(element).then(function(text){
            callback(null, text);
          });
        }, function(err, results){
              resolve(results);
      });
    },function(err){
      resolve(err);
    });
  });
};

exports.getAllTextByListOfIds = function(driver, idArray){
  return Q.Promise(function(resolve){
    async.map(idArray, function(id, callback){
      driver.elementById(id).text().then(function(text){
        callback(null, text.replace("\n", " "));
      });
    }, function(err, results){
        resolve(results);
    });
  });
};

exports.swipe = function (driver, opts) {
  var action = new wd.TouchAction();
  action
    .press({x: opts.startX, y: opts.startY})
    .wait(opts.duration)
    .moveTo({x: opts.endX, y: opts.endY})
    .release();
    return driver.performTouchAction(action);
};

exports.scrollDown = function (driver){
  var opts = {endX: '0.5', endY: '1'};
  return this.swipe(driver, opts);
};

exports.pullToRefresh = function(driver){
  var opts = {startX: 0.5, startY: 0.75, endX: 0.5, endY: 0.3, duration: 1};
  return this.swipe(driver, opts);
};

exports.getTextById = function(driver, id){
  var deferred = Q.defer();
  driver.elementById(id).text().then(function(text){
    deferred.resolve(text.replace("\n", " ").replace('. Editing.',''));
  }, function(err){
    deferred.resolve(err);
  });
  return deferred.promise;
};

exports.pressHardwareBack = function(driver){
  return driver.back();
};

exports.pressBackButtonOnPage = function(driver){
  return driver.elementByClassName('android.widget.ImageButton').tap();
};

function promiseWhile(condition, body) {
  var deferred = Q.defer();

  function loop() {
      if (!condition()) return deferred.resolve();
      Q.when(body(), loop, deferred.reject);
  }

  Q.nextTick(loop);

  return deferred.promise;
}

exports.waitForTextToAppear = function (driver, id, text){
  var deferred = Q.defer();
  var currentMessage = "";
  promiseWhile(function() { return currentMessage !== text; },
    function(){
      var done = Q.defer();
      driver.waitForElementById(id, 2000, 1000).text().then(function(text){
        currentMessage = text;
        done.resolve();
      });
      return done.promise;
    }).then(function(){
      deferred.resolve();
    }, function(err){
      console.log(err);
      deferred.resolve(err);
    });
  return deferred.promise;
};

exports.pressOKBtn = function (driver){
  return driver.elementById('android:id/button1').tap();
};

exports.pressCancelBtn = function (driver) {
  return driver.elementById('android:id/button2').tap();
};

exports.longPress = function (driver,els) {
 var action = new wd.TouchAction(driver);
 action
  .longPress({el: els })
  .release();
  return action.perform();
};

exports.waitForElementToBeEnabled = new Asserter(
  function(el) {
    return el.isEnabled().should.eventually.be.true
    .catch(tagChaiAssertionError);
});

exports.waitForListToBePopulated = new Asserter (
  function(driver){
    return driver.elementsById(config.packageId+'row_text_view').then(function(els){
      els.should.have.length.of.at.least(2);
    }).catch(tagChaiAssertionError);
  }
);
