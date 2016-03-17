'use strict';

var rek = require('rekuire')
  , response = rek('response');

var AccountRegisterModel = function(email) {
  return {
    "email": email,
    "uid": "f91aa7fa-2327-4b33-802e-708bc0bfb738",
    "confirmationState": "CONFIRMED",
    "timestamp": Math.round((new Date()).getTime() / 1000),
    "level":1,
    "levelName": {"EN":"Cloud-Starter", "DE":"Cloud-Starter"}
  };
};

exports.successfullyCreated = function(email){
  return response.created(new AccountRegisterModel(email));
};
