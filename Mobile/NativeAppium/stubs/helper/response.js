'use strict';

var headers = {
  'Content-Type': 'application/json'
};

exports.json = function(data) {
  return JSON.stringify({
    statusCode: 200,
    headers: headers,
    body: JSON.stringify(data)
  });
};

exports.created = function(data) {
  return JSON.stringify({
    statusCode: 201,
    headers: headers,
    body: JSON.stringify(data)
  });
};

exports.successWithBody = function(data) {
  return JSON.stringify({
    statusCode: 200,
    headers: headers,
    body: JSON.stringify(data)
  });
};

exports.success = function() {
  return JSON.stringify({
    statusCode: 200,
    headers: headers
  });
};

exports.accepted = function(data) {
  return {
    statusCode: 202,
    headers: headers,
    body: JSON.stringify(data)
  };
};

exports.serviceUnavailable = function() {
  return {
    statusCode: 503,
    headers: headers
  };
};

exports.invalid = function(err) {
  return {
    statusCode: 400,
    headers: headers,
    body: JSON.stringify(err)
  };
};

exports.unAuthorized = function() {
  return JSON.stringify({
    statusCode: 403,
    headers: headers
  });
};

exports.invalidJSON = function() {
  return this.invalid({
    "error": "invalid JSON"
  });
};
