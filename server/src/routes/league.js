const express = require('express');
const router = express.Router();

const leagueController = require('../controllers/leagueController');
const leagueMemberController = require('../controllers/leagueMemberController');

router.post('/createLeague', (req, res, next) => { //Method to create new league
    leagueController.checkDuplicateLeagueName(req.body.newLeague.league_name, function(err, leagueNameExist){
        if(leagueNameExist){
            res.status(400).json({
                message: "League name already exist."
            })
        }
        else if(err){
            res.status(400).json({
                message: "Failed to check duplicate league name."
            })
        }
        else{
            leagueController.createLeague(req.body.userid, req.body.newLeague, function(err, league){
                if(err){
                    res.status(400).json({
                        message: "Unable to create new league"
                    })
                }
                else{
                    var leagueMember = {
                        userid: req.body.userid,
                        leagueid: league.league_id
                    }
                    leagueMemberController.createLeagueMember(leagueMember, function(err, leagueMember){
                        if(err){
                            res.status(400).json({
                                message: "Unable to create new league member"
                            })
                        }
                        else{
                            res.status(200).json({
                                message: "Successfully created league",
                                league: league
                            })
                        }

                    })
                    
                }
               
            })
        }
    })
    
});

module.exports = router;
