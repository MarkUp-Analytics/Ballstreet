var schedule = require('node-schedule');
var matchFixtureController = require('../controllers/fixturesController');
 
var cronScheduler = {};

cronScheduler.scheduleJob = schedule.scheduleJob('*/2 * * * *', function(){ //This function runs every 2 minutes and checks whether any games has started. If it has started, then it will mark that match as locked.
    matchFixtureController.lockMatchFixture();
});

module.exports = cronScheduler;