'use strict';
var _ = require('lodash')
  , Q = require('q');

module.exports = function() {
  //Given steps
  this.Given(/^I open the app and land on home screen$/, function (done) {
    this.pages.createProfilePage.getPageTitle().should.eventually.eql('Home').notify(done);
  });

  //When steps
  this.When(/^I go to create Profile section$/, function (done) {
    var that = this;
    var expectedTextList = ['Create new profile', 'E-Mail', 'Show password', 'Accept Terms and Conditions', 'C R E A T E   P R O F I L E'];
    this.pages.profileHomePage.gotoCreateProfile().then(function(){
      that.pages.createProfilePage.getTextOnPage().should.eventually.eql(expectedTextList).notify(done);
    });
  });

  this.When(/^I create my profile with$/, function (table, done) {
    var that = this;
    var accountDetails = table.hashes()[0];
    Q.all([
      this.pages.createProfilePage.enterEmail(accountDetails.Email),
      this.pages.createProfilePage.enterPassword(accountDetails.Password),
      this.pages.createProfilePage.acceptTnC(accountDetails.Accept_terms_conditions),
    ]).then(function(){
      that.pages.createProfilePage.submit().should.notify(done);
    });
  });

  //Then steps
  this.Then(/^I should see the profile home screen$/, function (done) {
    this.pages.profileHomePage.getPageTitle().should.eventually.eql('Profile').notify(done);
  });

  this.Then(/^I should see below text in create profile section$/, function (table,done) {
    var expectedText = _.flatten(table.rows());
    this.pages.profileHomePage.getCreateProfileText().should.eventually.eql(expectedText).notify(done);
  });

  this.Then(/^I should see below text in login profile section$/, function (table,done) {
    var expectedText = _.flatten(table.rows());
    this.pages.profileHomePage.getLoginProfileText().should.eventually.eql(expectedText).notify(done);
  });

  this.Then(/^I should get a confirmation pop up saying "([^"]*)"$/, function (text, done) {
    var that = this;
    Q.all([
      this.pages.createProfilePage.getConfirmationText().should.eventually.eql(text)
    ]).then(function(){
      that.pages.createProfilePage.dismissConfirmationPopup().nodeify(done);
    });
  });

};
