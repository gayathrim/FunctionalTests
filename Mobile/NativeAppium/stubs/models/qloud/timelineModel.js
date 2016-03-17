'use strict';

var rek = require('rekuire')
  , response = rek('response');

var TimelineModel = function() {
  return {
        "id":"55e03f6ae4b07011650c2a9b",
        "timestamp":1440759657,
        "eventType":"REGISTER_PROFILE",
        "userId":"bffe01d0-ecaf-4247-9736-822d9dec8fd6",
        "eventSpecificInfo":{}
      };
};

exports.registerProfileEvent = function(){
  return response.successWithBody([new TimelineModel()]);
};

exports.newTimelineEvents = function(){
  return response.successWithBody();
};
