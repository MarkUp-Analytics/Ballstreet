const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController');
const fixturesController = require('../controllers/fixturesController');

/*
new Date("2018-11-19 20:00:00").toLocaleString("en-US", {timeZone: "Asia/Kolkata"})
The above string works in modern browser. So we have to save time zome in match_fixtures table to get the correct local time of where the match is held.
To get time zone values select * from pg_timezone_names; Use only name column as that is the primary key for this table and DONOT USE abbrev column.

select * from match_fixtures where match_fixture_tournament_id = 12 AND 
to_timestamp(concat(match_fixture_start_date, ' ', match_fixture_toss_time), 'YYYY-MM-DD HH24:MI:SS') < 
(SELECT now() AT TIME ZONE (select stadium_timezone from stadium where stadium_id = 1))

*/

router.post('/createSchedule', (req, res, next) => { //Method to create a new match schedule
    userController.checkUserIsAdmin(req.body.userid, function(err, userIsAdmin){
        if(err){
            res.status(400).json({
                message: "Unable to check user has permission"
            })
        }
        else if(!userIsAdmin){
            res.status(400).json({
                message: "User does not have permission to create schedule"
            })
        }
        else if(userIsAdmin){
            fixturesController.checkDuplicateMatchFixture(req.body, function(err, matchFixtureExist){
                if(err){
                    res.status(400).json({
                        message: "Unable to check Match schedule exist"
                    })
                }
                else if(matchFixtureExist){
                    res.status(400).json({
                        message: "Match schedule already exist"
                    })
                }
                else{
                    fixturesController.createSchedule(req.body, function(err, newMatchFixture){
                        if(err){
                            res.status(400).json({
                                message: "Unable to create schedule"
                            })
                        }
                        else{
                            fixturesController.getScheduleByMatchFixtureId(newMatchFixture.match_fixture_id, function(err, schedule){
                                if(err){
                                    res.status(400).json({
                                        message: "Unable to create schedule"
                                    })
                                }
                                else{
                                    res.status(200).json({
                                        schedule: schedule
                                    })
                                }
                            });
                            
                        }
                    });
                }
            });
            
            
        }
    })
    
});

router.get('/getAllMatchFixtures', (req, res, next) => {
    userController.checkUserIsAdmin(req.query.userid, function(err, userIsAdmin){
        if(err){
            res.status(400).json({
                message: "Unable to check user has permission"
            })
        }
        else if(!userIsAdmin){
            res.status(400).json({
                message: "User does not have permission to get all schedules"
            })
        }
        else if(userIsAdmin){
            fixturesController.getAllMatchFixtures(function(err, scheduleList){
                if(err){
                    res.status(400).json({
                        message: "Unable to get all schedules"
                    })
                }
                else{
                    res.status(200).json({
                        scheduleList: scheduleList
                    })
                }
            })
        }
    });
});

router.get('/getScheduleByTournamentId', (req, res, next) =>{
    fixturesController.getScheduleByTournamentId(req.query.tournamentId, function(err, scheduleList){
        if(err){
            res.status(400).json({
                message: "Unable to get schedules based on tournament ID"
            })
        }
        else{
            res.status(200).json({
                scheduleList: scheduleList
            })
        }
    })
});

router.post('/updateMatchResult', (req, res, next) => {
    userController.checkUserIsAdmin(req.body.userid, function(err, userIsAdmin){
        if(err){
            res.status(400).json({
                message: "Unable to check user has permission"
            })
        }
        else if(!userIsAdmin){
            res.status(400).json({
                message: "User does not have permission to update match result"
            })
        }
        else if(userIsAdmin){
            fixturesController.updateMatchResult(req.body, function(err, matchResult){
                if(err){
                    res.status(400).json({
                        message: "Unable to update match result"
                    })
                }
                else{
                    res.status(200).json({
                        matchResult: matchResult
                    })
                }
            })
        }
    });
});

module.exports = router;
