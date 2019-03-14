const express = require('express');
const router = express.Router();

const tournamentController = require('../controllers/tournamentController');
const userController = require('../controllers/userController');

router.get('/upcomingTournaments', (req, res, next) => { //Method to get upcoming tournaments based on today's date
    
tournamentController.getUpcomingTours(function(err, upcomingTours){
                if(err){
                    res.status(400).json({
                        message: "Unable to get upcoming tournaments"
                    })
                }
                if(upcomingTours.length === 0){
                    res.status(200).json({
                        message: "No upcoming tours",
                        tours: []
                    })
                }
                else if(upcomingTours.length > 0){
                    res.status(200).json({
                        message: "There are " + upcomingTours.length + " tour(s)",
                        tours: upcomingTours
                    })
                }
            })
});

router.get('/ongoingTournaments', (req, res, next) => { //Method to get ongoing tournaments based on today's date
    
tournamentController.getOngoingTours(function(err, ongoingTours){
                if(err){
                    res.status(400).json({
                        message: "Unable to get ongoing tournaments"
                    })
                }
                if(ongoingTours.length === 0){
                    res.status(200).json({
                        message: "No ongoing tours",
                        tours: []
                    })
                }
                else if(ongoingTours.length > 0){
                    res.status(200).json({
                        message: "There are " + ongoingTours.length + " tour(s)",
                        tours: ongoingTours
                    })
                }
            })
});

router.get('/totalGames', (req, res, next) => { //Method to get total games for a tournament
tournamentController.getTotalGames(req.query.tournamentID, function(err, totalGames){
    if(err){
        res.status(400).json({
            message: "Unable to get total games"
        })
    }
    else{
        res.status(200).json({
            message: "Total games: " + totalGames,
            totalGames: totalGames.total_games
        })
    }
})
});

router.get('/searchTournament', (req, res, next) => { //Method to search tournaments based on name and sport id
    tournamentController.getTournamentByNameAndSportId(req.query.tournamentName, req.query.sportId, function(err, tournaments){
        if(err){
            res.status(400).json({
                message: "Unable to search tournaments"
            })
        }
        else if(tournaments.length === 0){
            res.status(400).json({
                message: "No tournaments found"
            })
        }
        else{
            res.status(200).json({
                message: "Tours found",
                tournaments: tournaments
            })
        }
    })
    });

    router.get('/tournamentDetails', (req, res, next) => { //Method to get tournaments based on tournament id
        tournamentController.getTournamentByID(req.query.tournamentId, function(err, tournaments){
            if(err){
                res.status(400).json({
                    message: "Unable to get tournament"
                })
            }
            else if(tournaments.length === 0){
                res.status(400).json({
                    message: "No tournament found"
                })
            }
            else{
                res.status(200).json({
                    message: "Tours found",
                    tournament: tournaments[0]
                })
            }
        })
        });

    router.get('/playingTeams', (req, res, next) => { //Method to get playing teams based on tournament id
        tournamentController.getPlayingTeamsByTournamentId(req.query.tournamentId, function(err, teams){
            if(err){
                res.status(400).json({
                    message: "Unable to find playing teams"
                })
            }
            else if(teams.length === 0){
                res.status(400).json({
                    message: "No teams found"
                })
            }
            else{
                res.status(200).json({
                    message: "Teams found",
                    teams: teams
                })
            }
        })
        });

        router.post('/createTournament', (req, res, next) => { //Method to create a new tournament
            userController.checkUserIsAdmin(req.body.userid, function(err, userIsAdmin){
                if(err){
                    res.status(400).json({
                        message: "Unable to check user has permission"
                    })
                }
                else if(!userIsAdmin){
                    res.status(400).json({
                        message: "User does not have permission to create tournament"
                    })
                }
                else if(userIsAdmin){
                    tournamentController.checkDuplicateTournamentName(req.body.tournamentName, function(err, tournamentNameExist){
                        if(err){
                            res.status(400).json({
                                message: "Unable to check tournament name exist"
                            })
                        }
                        else if(tournamentNameExist){
                            res.status(400).json({
                                message: "Tournament name already exist"
                            })
                        }
                        else{
                            tournamentController.createTournament(req.body, function(err, tour){
                                if(err){
                                    res.status(400).json({
                                        message: "Unable to create tournament"
                                    })
                                }
                                else{
                                        tournamentController.createTourTeamRelation(req.body.teams, tour.tournament_id, function(err){
                                            if(err){
                                                res.status(400).json({
                                                    message: "Unable to create tournament-team relation"
                                                })
                                            }
                                        })
                                    
                                    res.status(200).json({
                                        message: "Tournament created successfully",
                                        tour: tour
                                    })
                                }
                            })
                        }
                    })
                }
            });
            
            });

module.exports = router;
