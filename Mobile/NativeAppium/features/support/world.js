"use strict";

var util = require('util')
  , path = require('path')
  , pagesPath = util.format('../pages/%sPages', process.env.PLATFORM)
  , SlidingMenu = require(path.join(pagesPath, 'slidingMenu.js'))
  , ProfileHomePage = require(path.join(pagesPath,'profileHomePage.js'))
  , CreateProfilePage = require(path.join(pagesPath,'createProfilePage.js'))
  , TimelinePage = require(path.join(pagesPath,'timelinePage.js'));

module.exports = function() {
  var wd = require('wd');
  var chai = require("chai");
  chai.should();
  chai.config.truncateThreshold = 0;
  var chaiAsPromised = require("chai-as-promised");
  chai.use(chaiAsPromised);
  chaiAsPromised.transferPromiseness = wd.transferPromiseness;

  this.World = function World (callback) {
    this.driver = wd.promiseChainRemote({ host: 'localhost', port: 4723 });
    this.pages = {
      slidingMenu: new SlidingMenu(this.driver),
      profileHomePage: new ProfileHomePage(this.driver),
      createProfilePage: new CreateProfilePage(this.driver),
      timelinePage: new TimelinePage(this.driver)
    };
    callback();
  };
};
