'use strict';

var HomePage;

HomePage = (function() {

  function HomePage(driver) {
    this.driver = driver;
    return this;
  }

  HomePage.prototype.getTitle = function() {
    return this.driver.elementByClassName('UIAStaticText').text();  
  };

  return HomePage;
})();

module.exports = HomePage;
