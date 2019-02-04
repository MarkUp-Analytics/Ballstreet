const express = require('express');
const router = express.Router();

const tournamentController = require('../controllers/tournamentController');

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

module.exports = router;
