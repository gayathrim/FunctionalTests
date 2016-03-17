'use strict';

var Mustache = require('mustache')
  , fs = require('fs');

var TEMPLATE_PATH = __dirname + '/mountebank_stub.hbs';

exports.imposterJson = function(imposters) {
  var stubTemplate = fs.readFileSync(TEMPLATE_PATH, 'utf8');
  return Mustache.render(stubTemplate, {
      imposters: imposters,
      port: '8080',
      name: 'Qloud',
      protocol: 'http',
  });
};
