'use strict';

var rek = require('rekuire')
  , config = rek('config')
  , basePage = require('./basePage.js');

var CreateProfilePage = (function() {

  function CreateProfilePage(driver) {
    this.driver = driver;
    return this;
  }

  CreateProfilePage.prototype.getPageTitle = function() {
    return this.driver.elementById('home').text();
  };

  CreateProfilePage.prototype.getTextOnPage = function(){
    var ids = ['create_profile_title', 'email', 'show_password', 'accept_terms_and_conditions', config.packageId + 'create_profile'];
    return basePage.getAllTextByListOfIds(this.driver, ids);
  };

  CreateProfilePage.prototype.enterEmail = function(email){
    return this.driver.waitForElementById(config.packageId + 'email_id', 5000, 1000).type(email);
  };

  CreateProfilePage.prototype.enterPassword = function(password){
    return this.driver.elementById(config.packageId + 'password').type(password);
  };

  CreateProfilePage.prototype.acceptTnC = function(isTrue){
    if(isTrue){
      return this.driver.elementById(config.packageId + 'tc').tap();
    }
  };

  CreateProfilePage.prototype.showPassword = function(){
    return this.driver.elementById(config.packageId + 'revealPassword').tap();
  };

  CreateProfilePage.prototype.submit = function(){
    return this.driver.elementById(config.packageId + 'create_profile').tap();
  };

  CreateProfilePage.prototype.getConfirmationText = function(){
    return this.driver.waitForElementById(config.packageId + 'message', 5000, 1000).text();
  };

  CreateProfilePage.prototype.dismissConfirmationPopup = function(){
    return this.driver.elementById('android:id/button1').tap();
  };

  return CreateProfilePage;
  })();

module.exports = CreateProfilePage;
