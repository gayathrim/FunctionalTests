'use strict';
var _= require('lodash')
  , request = require('request')
  , Q = require('q');

exports.arrayToHash = function(array) {
  var index = 0;
  return _.reduce(array, function(result, item) {
    result["index_" + index++] = item;
    return result;
  }, {});
};

exports.httpPut = function(url, body){
  return Q.Promise(function(resolve, reject) {
    request.put(url, {
      body: body,
      json: true
    }, function(err, res, body) {
      if (err) {
        reject(err);
        return;
      }
    resolve({ res: res, body: body });
    });
  });
};

exports.httpPost = function(url, body){
  return Q.Promise(function(resolve, reject) {
    var opts = { body: body, json: true };
    request.post(url, body ? opts : null, function(err, res, body) {
      if (err) {
        reject(err);
        return;
      }
    resolve({ res: res, body: body });
    });
  });
};

exports.httpDelete = function(url) {
  return Q.Promise(function(resolve, reject) {
    request.del(url, function(err, res, body) {
      if (err) {
        reject(err);
        return;
      }
      resolve({ res: res, body: body });
    });
  });
};
