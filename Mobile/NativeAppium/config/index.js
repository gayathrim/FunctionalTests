'use strict';

var yaml = require('js-yaml')
  , fs = require('fs')
  , path = require('path')
  , format = require('string-template')
  , CONFIG;

module.exports = (function() {
  var fileName = format('./{0}.yml', [process.env.NODE_ENV || 'dev']);
  var configFile = path.join(__dirname,fileName);
  if (!CONFIG) {
    CONFIG = yaml.safeLoad(fs.readFileSync(configFile, 'utf8'));
  }
  return CONFIG;
})();
