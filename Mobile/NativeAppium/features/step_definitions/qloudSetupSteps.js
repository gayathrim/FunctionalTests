'use strict';

var rek = require('rekuire')
  , Qloud = rek('qloud')
  , accountRegisterModel = rek('accountRegisterModel')
  , oathTokenModel = rek('oathTokenModel')
  , timelineModel = rek('timelineModel');

module.exports = function() {
//Given steps
  this.Given(/^Qloud gives success response for creating account "([^"]*)"$/, function (email, callback) {
    var successfullyCreated = accountRegisterModel.successfullyCreated(email)
      , token = oathTokenModel.newToken()
      , timelineEvents = timelineModel.registerProfileEvent();

    Qloud.setAccountRegisterResponse(successfullyCreated)
         .setOathTokenResponse(token)
         .setTimelineResponse(timelineEvents)
         .build()
         .then(function(){
           callback();
         }, function(err){
           console.log("Error connecting to Cloud" + err);
           callback();
         });
  });

  this.Given(/^Qloud gives success response for login and returns following timeline events$/, function (table, callback) {
    var token = oathTokenModel.newToken()
      , timelineEvents = timelineModel.newTimelineEvents();

    Qloud.setOathTokenResponse(token)
         .setTimelineResponse(timelineEvents)
         .build()
         .then(function(){
           callback();
         }, function(err){
           console.log("Error connecting to Cloud" + err);
           callback();
         });
  });

};
