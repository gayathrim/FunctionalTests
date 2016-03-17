'use strict';

module.exports = function() {

this.When(/^I navigate to Profile tab/,function(callback){
  this.pages.slidingMenu.goToProfileTab().then(function(){
    callback();
  }, function(err){
    console.log(err);
    callback();
  });
});

};
