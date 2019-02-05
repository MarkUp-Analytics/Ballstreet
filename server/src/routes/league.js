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

router.get('/findLeagueById', (req, res, next) => { //Method to search league based on short id
    leagueController.getLeagueByShortId(req.query.leagueShortId, req.query.tournamentId, function(err, leagues){
        if(err){
            res.status(400).json({
                message: "Unable to search league"
            })
        }
        else if(leagues.length === 0){
            res.status(400).json({
                message: "No leagues found"
            })
        }
        else{
            res.status(200).json({
                message: "League found",
                leagues: leagues
            })
        }
    })
    });

    router.get('/memberInLeague', (req, res, next) => { //Method to search league based on short id
        leagueMemberController.memberInLeague(req.query.userId, req.query.leagueId, function(err, memberBelongsToLeague){
            if(err){
                res.status(400).json({
                    message: "Unable to check whether member belongs to league"
                })
            }
            else{
                res.status(200).json({
                    memberBelongsToLeague: memberBelongsToLeague
                })
            }
        })
        });    

module.exports = router;
