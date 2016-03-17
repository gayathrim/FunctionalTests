'use strict';
var basePage = require('./basePage');

var ProfileHomePage = (function() {

  function ProfileHomePage(driver) {
    this.driver = driver;
    return this;
  }

  ProfileHomePage.prototype.getPageTitle = function(){
    return this.driver.waitForElementById('title_activity_profile', 5000, 1000).text();
  };

  ProfileHomePage.prototype.getCreateProfileText = function(){
    var ids = ['create_call_to_action','create_message_call_to_action'];
    return basePage.getAllTextByListOfIds(this.driver, ids);
  };

  ProfileHomePage.prototype.getLoginProfileText = function(){
    var ids = ['login_call_to_action','login_message_call_to_action'];
    return basePage.getAllTextByListOfIds(this.driver, ids);
  };

  ProfileHomePage.prototype.gotoCreateProfile = function(){
    return this.driver.elementById('create_call_to_action').tap();
  };

  return ProfileHomePage;
  })();

module.exports = ProfileHomePage;
