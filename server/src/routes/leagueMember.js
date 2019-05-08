const express = require('express');
const router = express.Router();

const leagueMemberController = require('../controllers/leagueMemberController');

router.get('/getAllMembers', (req, res, next) => { //Method to get all league members that are playing
    leagueMemberController.getAllMembers(req.query.leagueId, function (err, leagueMembers) {
        if (err) {
            res.status(400).json({
                message: "Unable to get league members"
            })
        }
        else if (leagueMembers.length === 0) {
            res.status(400).json({
                message: "No league members found"
            })
        }
        else {
            res.status(200).json({
                leagueMembers: leagueMembers
            })
        }
    })
});

router.get('/getResults', (req, res, next) => { //Method to get results for league
    leagueMemberController.getResults(req.query.leagueMemberId, req.query.tournamentId, function (err, matchResults) {
        if (err) {
            res.status(400).json({
                message: "Unable to get results for the tournament"
            })
        }
        else if (matchResults.length === 0) {
            res.status(400).json({
                message: "No match result found"
            })
        }
        else {
            res.status(200).json({
                result: matchResults
            })
        }
    })
});

router.get('/getLeagueStatistics', (req, res, next) => { //Method to get league stats
    leagueMemberController.getLeagueStatistics(req.query.leagueId, function (err, leagueStatistics) {
        if (err) {
            res.status(400).json({
                message: "Unable to get statistics for the league"
            })
        }
        else {
            res.status(200).json({
                leagueStatistics: leagueStatistics
            })
        }
    })
});

module.exports = router;