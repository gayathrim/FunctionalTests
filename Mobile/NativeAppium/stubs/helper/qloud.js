'use strict';
var rek = require('rekuire')
  , _ = rek('lodash')
  , util = rek('util')
  , generate = rek('generateQloudTemplate')
  , config = rek('config')
  , format = rek('string-template');

var IMPOSTERS = {};

exports.setAccountRegisterResponse = function(response){
  IMPOSTERS.accountRegister = {
    path: '/accounts/register',
    method: 'post',
    response: response,
    wait: 1000
  };
  return this;
};

exports.setOathTokenResponse = function(response){
  IMPOSTERS.oathToken = {
    path: '/oauth/token',
    method: 'post',
    response: response,
    wait: 1000
  };
  return this;
};

exports.setTimelineResponse = function(response){
  IMPOSTERS.timelineEvents = {
    path: '/accounts/timeline',
    method: 'get',
    response: response,
    wait: 1000
  };
  return this;
};

exports.reset = function() {
  console.log('Resetting Qloud');
  return util.httpDelete(format('{0}/imposters/8080', [config.imposterUri]));
};

exports.build = function() {
  var stubs = _.map(IMPOSTERS, function(value) { return value; });
  var imposters = generate.imposterJson(stubs);
  console.log(imposters);
  console.log(config.imposterUri);
  return util.httpPost(format('{0}/imposters', [config.imposterUri]), JSON.parse(imposters));
};
