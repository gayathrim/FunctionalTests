'use strict';

var Q = require('q')
  , async = require('async');

exports.getListOfElementsNamesByClassName = function(driver, className){
  return Q.Promise(function(resolve){
    driver.elementsByClassName(className).then(function(elements) {
      async.map(elements, function(element, callback){
        element.getAttribute('name').then(function(name){
            callback(null, name);
          });
        }, function(err, results){
              resolve(results);
           }
      );
    });
  });
};
