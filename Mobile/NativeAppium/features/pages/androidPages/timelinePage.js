'use strict';
var rek = require('rekuire')
  , config = rek('config')
  , basePage = require('./basePage.js');

var TimelinePage = (function() {

  function TimelinePage(driver) {
    this.driver = driver;
    return this;
  }

  TimelinePage.prototype.getTextOnPage = function(){
    var that = this;
    return this.driver.waitForElementById('my_timeline', 5000, 1000).then(function(){
      var ids = ['my_timeline', 'what_s_your_name'];
      return basePage.getAllTextByListOfIds(that.driver, ids);
    });
  };

  TimelinePage.prototype.getTimelineEvents = function(){
    var that = this;
    return this.driver.waitForElementById(config.packageId + 'timeline_event_description', 8000, 1000)
      .then(function(){
        return basePage.getListOfElementsTextById(that.driver, config.packageId + 'timeline_event_description');
      });
    };

  return TimelinePage;
  })();

module.exports = TimelinePage;
