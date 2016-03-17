'use strict';

var _ = require('lodash');

module.exports = function() {

  //When steps
  this.When(/^I am on my personal profile page$/, function (done) {
    var expectedTextList = ['My Timeline', 'What\'s your name?'];
    this.pages.timelinePage.getTextOnPage().should.eventually.eql(expectedTextList).notify(done);
  });

  //Then steps
  this.Then(/^my timeline events are shown as below:$/, function (table, done) {
    this.pages.timelinePage.getTimelineEvents().should.eventually.eql(_.pluck(table.hashes(), 'Timeline_Events')).notify(done);
  });

};
