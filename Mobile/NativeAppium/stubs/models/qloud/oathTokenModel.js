'use strict';

var rek = require('rekuire')
  , response = rek('response');

var OathTokenModel = function() {
  return {
      "access_token":"baff83a4-2603-440c-83be-b0f9e721425d",
      "token_type":"bearer",
      "refresh_token":"511de7f7-2a7b-4e6f-a5fe-c964fc2369b2",
      "expires_in":4924964,
      "scope":"read write"
    };
};

exports.newToken = function(){
  return response.successWithBody(new OathTokenModel());
};
