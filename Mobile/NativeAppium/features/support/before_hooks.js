"use strict";

var capabilities = require('./caps.js')
  , rek = require('rekuire')
  , Qloud = rek('qloud')
  , Q = rek('q');

module.exports = function () {

  this.Before(function(done) {
    Q.all([
      Qloud.reset()
    ]).nodeify(done);
  });

  this.Before("@android", function(scenario, done){
    console.log(scenario.getName());
    var desiredCapabilities = capabilities[process.env.PLATFORM][process.env.VERSION];
    this.driver.init(desiredCapabilities).nodeify(done);
  });

};
