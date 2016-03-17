'use strict';

var rek = require('rekuire')
 , config = rek('config')
 , SlidingMenu;

SlidingMenu = (function() {

  function SlidingMenu(driver) {
    this.driver = driver;
    return this;
  }

  SlidingMenu.prototype.goToSlidingMenu = function(){
    return this.driver.elementById(config.packageId + 'toolbar').elementByClassName('android.widget.ImageButton').tap();
  };

  SlidingMenu.prototype.goToProfileTab = function(){
    var that = this;
    return this.goToSlidingMenu().then(function(){
      return that.driver.elementById('title_activity_profile').tap();
    });
  };

  return SlidingMenu;
})();

module.exports = SlidingMenu;
