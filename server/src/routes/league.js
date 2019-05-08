const express = require('express');
const router = express.Router();

const leagueController = require('../controllers/leagueController');
const leagueMemberController = require('../controllers/leagueMemberController');
const tournamentController = require('../controllers/tournamentController');
const teamSelectionController = require('../controllers/teamSelectionController');

router.post('/createLeague', (req, res, next) => { //Method to create new league
    leagueController.checkDuplicateLeagueName(req.body.newLeague.league_name, function (err, leagueNameExist) {
        if (leagueNameExist) {
            res.status(400).json({
                message: "League name already exist."
            })
        }
        else if (err) {
            res.status(400).json({
                message: "Failed to check duplicate league name."
            })
        }
        else {
            leagueController.createLeague(req.body.userid, req.body.newLeague, function (err, league) {
                if (err) {
                    res.status(400).json({
                        message: "Unable to create new league"
                    })
                }
                else {
                    var leagueMember = {
                        userid: req.body.userid,
                        leagueid: league.league_id
                    }
                    leagueMemberController.createLeagueMember(leagueMember, function (err, leagueMember) {// Once a user creates a league, he/she must be a part of the league. This creates them as a member of the league
                        if (err) {
                            res.status(400).json({
                                message: "Unable to add you as a league member"
                            })
                        }
                        else {
                            tournamentController.getPlayingTeamsByTournamentId(league.league_tournament_id, function (err, teamList) {
                                if (err) {
                                    res.status(400).json({
                                        message: "Unable to get teams to create preference"
                                    })
                                }
                                else if (teamList.length == 0) {
                                    res.status(400).json({
                                        message: "No teams available for the tournament. Contact admin"
                                    })
                                }
                                else {
                                    var preferences = [];
                                    for (var i = 0; i < teamList.length; i++) {
                                        preferences.push(
                                            {
                                                teamId: teamList[i].team_id,
                                                rank: teamList[i].team_rank
                                            }
                                        );
                                    }

                                    leagueMemberController.createTeamPreference(preferences, league.league_id, leagueMember.league_member_id, function (err, preference) {
                                        if (err) {
                                            res.status(400).json({
                                                message: "Unable to create team preference for the league admin"
                                            })
                                        }
                                        else {
                                            teamSelectionController.getMemberPredictionForAllGames(league.league_tournament_id, leagueMember.league_member_id, function(err, predictions){
                                                if (err) {
                                                    res.status(400).json({
                                                        message: "Unable to get predictions for all games"
                                                    })
                                                }
                                                else{
                                                    teamSelectionController.createTeamSelection(predictions, league.league_id, leagueMember.league_member_id, function(err, teamSelection){
                                                        if(err){
                                                            res.status(400).json({
                                                                message: "Unable to update team selection for all games"
                                                            });
                                                        }
                                                        else{
                                                            res.status(200).json({
                                                                message: "Successfully created league",
                                                                league: league
                                                            })
                                                        }
                                                    });
                                                }
                                            })
                                            
                                        }
                                    });

                                }
                            });


                        }

                    })

                }

            })
        }
    })

});
/*
    params list: [userId, leagueId, tournamentId, leaguePin]
*/
router.post('/joinLeague', (req, res, next) => { //Method to join league as a league member if you have the pin
    leagueMemberController.memberInLeague(req.body.userid, req.body.leagueId, function (err, memberBelongsToLeague) {
        if (err) {
            res.status(400).json({
                message: "Unable to check whether member belongs to league"
            })
        }
        else if (memberBelongsToLeague) { //add member to league only if they are not a member already.
            res.status(400).json({
                message: "Member already belongs to league"
            })
        }
        else if (!memberBelongsToLeague) {
            leagueController.compareLeagueKey(req.body.leagueId, req.body.leaguePin, function (err, leaguePinMatches) {
                if (err) {
                    res.status(400).json({
                        message: "Unable to compare league pin"
                    })
                }
                else if (!leaguePinMatches) {
                    res.status(400).json({
                        message: "League pin did not match"
                    })
                }
                else if (leaguePinMatches) {
                    var leagueMemberDetails = {
                        userid: req.body.userid,
                        leagueid: req.body.leagueId
                    }
                    leagueMemberController.createLeagueMember(leagueMemberDetails, function (err, leagueMember) {
                        if (err) {
                            res.status(400).json({
                                message: "Unable to add you as a league member"
                            })
                        }
                        else {
                            tournamentController.getPlayingTeamsByTournamentId(req.body.tournamentId, function (err, teamList) {
                                if (err) {
                                    res.status(400).json({
                                        message: "Unable to get teams to create preference"
                                    })
                                }
                                else if (teamList.length == 0) {
                                    res.status(400).json({
                                        message: "No teams available for the tournament. Contact admin"
                                    })
                                }
                                else {
                                    var preferences = [];
                                    for (var i = 0; i < teamList.length; i++) {
                                        preferences.push(
                                            {
                                                teamId: teamList[i].team_id,
                                                rank: teamList[i].team_rank
                                            }
                                        );
                                    }

                                    leagueMemberController.createTeamPreference(preferences, req.body.leagueId, leagueMember.league_member_id, function (err, preference) {
                                        if (err) {
                                            res.status(400).json({
                                                message: "Unable to create team preference"
                                            })
                                        }
                                        else {
                                            teamSelectionController.getMemberPredictionForAllGames(req.body.tournamentId, leagueMember.league_member_id, function(err, predictions){
                                                if (err) {
                                                    res.status(400).json({
                                                        message: "Unable to get predictions for all games"
                                                    })
                                                }
                                                else{
                                                    teamSelectionController.createTeamSelection(predictions, req.body.leagueId, leagueMember.league_member_id, function(err, teamSelection){
                                                        if(err){
                                                            res.status(400).json({
                                                                message: "Unable to update team selection for all games"
                                                            });
                                                        }
                                                        else{
                                                            res.status(200).json({
                                                                message: "Successfully joined the league",
                                                                teamPreference: preference
                                                            })
                                                        }
                                                    });
                                                }
                                            })
                                        }
                                    });

                                }
                            });
                        }
                    });
                }
            });

        }
    });

});

router.get('/findLeagueById', (req, res, next) => { //Method to search league based on short id
    leagueController.searchLeaguesByShortId(req.query.leagueShortId, req.query.tournamentId, function (err, leagues) {
        if (err) {
            res.status(400).json({
                message: "Unable to search league"
            })
        }
        else if (leagues.length === 0) {
            res.status(400).json({
                message: "No leagues found"
            })
        }
        else {
            res.status(200).json({
                message: "League found",
                leagues: leagues
            })
        }
    })
});

router.get('/getLeague', (req, res, next) => { //Method to get one league based on short id exact match
    leagueController.findLeagueByShortId(req.query.leagueShortId, function (err, league) {
        if (err || !league) {
            res.status(400).json({
                message: "Unable to find league"
            })
        }
        
        else {
            res.status(200).json({
                message: "League found",
                league: league
            })
        }
    })
});

router.get('/memberInLeague', (req, res, next) => { //Method to search league based on short id
    leagueMemberController.memberInLeague(req.query.userId, req.query.leagueId, function (err, memberBelongsToLeague) {
        if (err) {
            res.status(400).json({
                message: "Unable to check whether member belongs to league"
            })
        }
        else {
            res.status(200).json({
                memberBelongsToLeague: memberBelongsToLeague
            })
        }
    })
});

router.post('/createTeamPreference', (req, res, next) => { //Method to create team preference for a league
    leagueMemberController.memberInLeague(req.query.userId, req.query.leagueId, function (err, memberBelongsToLeague) {
        if (err) {
            res.status(400).json({
                message: "Unable to check whether member belongs to league"
            })
        }
        else if (!memberBelongsToLeague) {
            res.status(400).json({
                message: "Member does not belongs to the league"
            })
        }
        else if (memberBelongsToLeague) {
            leagueMemberController.createTeamPreference(req.query.preferences, req.query.leagueId, req.query.leagueMemberId, function (err, teamList) {
                if (err) {
                    res.status(400).json({
                        message: "Unable to create team preference list"
                    })
                }
                else {
                    res.status(200).json({
                        teamPreference: teamList
                    })
                }
            });
        }
    })
});

router.get('/getTeamPreference', (req, res, next) => {
    leagueMemberController.memberInLeague(req.query.userId, req.query.leagueId, function (err, memberBelongsToLeague) {
        if (err) {
            res.status(400).json({
                message: "Unable to check whether member belongs to league"
            })
        }
        else if (!memberBelongsToLeague) {
            res.status(400).json({
                message: "Member does not belongs to the league"
            })
        }
        else if (memberBelongsToLeague){
            leagueMemberController.getTeamPreference(req.query.leagueMemberId, function (err, teamList) {
                if (err || !teamList) {
                    res.status(400).json({
                        message: "Unable to get team preference list"
                    })
                }
                else if(teamList){
                    res.status(200).json({
                        teamPreference: teamList
                    })
                }
            });
        }
    })
});

router.get('/getLeagueMemberId', (req, res, next) => {
    leagueMemberController.memberInLeague(req.query.userId, req.query.leagueId, function (err, memberBelongsToLeague) {
        if (err) {
            res.status(400).json({
                message: "Unable to check whether member belongs to league"
            })
        }
        else if (!memberBelongsToLeague) {
            res.status(400).json({
                message: "Member does not belongs to the league"
            })
        }
        else if (memberBelongsToLeague){
            leagueMemberController.getLeagueMemberId(req.query.userId, req.query.leagueId, function (err, leagueMemberId) {
                if (err) {
                    res.status(400).json({
                        message: "Unable to get league member Id"
                    })
                }
                else if(leagueMemberId){
                    res.status(200).json({
                        leagueMemberId: leagueMemberId
                    })
                }
            });
        }
    })
});

router.post('/updateTeamPreference', (req, res, next) => { //Method to update team preference for a league
    leagueMemberController.memberInLeague(req.body.userId, req.body.leagueId, function (err, memberBelongsToLeague) {
        if (err) {
            res.status(400).json({
                message: "Unable to check whether member belongs to league"
            })
        }
        else if (!memberBelongsToLeague) {
            res.status(400).json({
                message: "Member does not belongs to the league"
            })
        }
        else if (memberBelongsToLeague){
            leagueMemberController.updateTeamPreference(req.body.preferences, req.body.leagueId, req.body.leagueMemberId, function (err, teamList) {
                if (err) {
                    res.status(400).json({
                        message: "Unable to update team preference list"
                    })
                }
                else {

                    teamSelectionController.getMemberPredictionForAllGames(req.body.tournamentId, req.body.leagueMemberId, function(err, predictions){
                        if (err) {
                            res.status(400).json({
                                message: "Unable to get predictions for all games"
                            })
                        }
                        else if(predictions && predictions.length > 0){
                            teamSelectionController.updateTeamSelection(predictions, req.body.leagueId, req.body.leagueMemberId, function(err, teamSelection){
                                if(err){
                                    res.status(400).json({
                                        message: "Unable to update team selection for all games"
                                    });
                                }
                                else{
                                    res.status(200).json({
                                        teamPreference: teamList
                                    })
                                }
                            });
                        }
                        else{
                            res.status(200).json({
                                teamPreference: teamList
                            })
                        }
                    })

                }
            });
        }
    })
});

module.exports = router;
