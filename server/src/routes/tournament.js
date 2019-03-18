const express = require('express');
const router = express.Router();
const multer = require('multer');
var fs = require('fs');
var storage = multer.diskStorage({
    destination: function (req, file, callback) {
        var dirPath = './uploads/tour/';
        if (!fs.existsSync(dirPath)){
            fs.mkdirSync(dirPath);
        }
        callback(null, dirPath);
    },
    filename: function (req, file, callback) {
        callback(null, Date.now() + file.originalname)
    }
  })
  
var upload = multer({ storage: storage });

const tournamentController = require('../controllers/tournamentController');
const userController = require('../controllers/userController');
const commonController = require('../controllers/commonController');

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
                    for(var i=0; i<upcomingTours.length; i++){
                        if(upcomingTours[i].tournament_image){
                            upcomingTours[i].tourImage = commonController.buildImageURL(req, upcomingTours[i].tournament_image);
                        }
                    }
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
                    for(var i=0; i<ongoingTours.length; i++){
                        if(ongoingTours[i].tournament_image){
                            ongoingTours[i].tourImage = commonController.buildImageURL(req, ongoingTours[i].tournament_image);
                        }
                    }
                    res.status(200).json({
                        message: "There are " + ongoingTours.length + " tour(s)",
                        tours: ongoingTours
                    })
                }
            })
});

router.get('/allTournaments', (req, res, next) => { //Method to get all tournaments which are active
    
tournamentController.getAllTours(function(err, tours){
                if(err){
                    res.status(400).json({
                        message: "Unable to get tournaments"
                    })
                }
                else{
                    if(tours.length > 0){
                        for(var i=0; i<tours.length; i++){
                            if(tours[i].tournament_image){
                                tours[i].tourImage = commonController.buildImageURL(req, tours[i].tournament_image);
                            }
                        }
                        res.status(200).json({
                            message: "There are " + tours.length + " tour(s)",
                            tours: tours
                        })
                    }
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
            for(var i=0; i<tournaments.length; i++){
                if(tournaments[i].tournament_image){
                    tournaments[i].tourImage = commonController.buildImageURL(req, tournaments[i].tournament_image);
                }
            }
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
                if(tournaments[0].tournament_image){
                    tournaments[0].tourImage = commonController.buildImageURL(req, tournaments[0].tournament_image);
                }
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

        router.post('/createTournament', upload.single('file'), (req, res, next) => { //Method to create a new tournament
            var tourDetails = JSON.parse(req.body.tourDetails);
            userController.checkUserIsAdmin(tourDetails.userid, function(err, userIsAdmin){
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
                    tournamentController.checkDuplicateTournamentName(tourDetails.tournamentName, function(err, tournamentNameExist){
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
                            tourDetails.tourImage = req.file.path;
                            tournamentController.createTournament(tourDetails, function(err, tour){
                                if(err){
                                    res.status(400).json({
                                        message: "Unable to create tournament"
                                    })
                                }
                                else{
                                        tournamentController.createTourTeamRelation(tourDetails.teams, tour.tournament_id, function(err){
                                            if(err){
                                                res.status(400).json({
                                                    message: "Unable to create tournament-team relation"
                                                })
                                            }
                                        })
                                    tour.tourImage = commonController.buildImageURL(req, tour.tournament_image);
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
