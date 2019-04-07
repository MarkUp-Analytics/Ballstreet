const express = require('express');
const router = express.Router();

const leagueMemberController = require('../controllers/leagueMemberController');

router.get('/getAllMembers', (req, res, next) => { //Method to search league based on short id
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

module.exports = router;