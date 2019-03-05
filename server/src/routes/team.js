const express = require('express');
const router = express.Router();

const sportController = require('../controllers/teamController');

router.get('/getTeamsList', (req, res, next) => { //Method to get available team list
    teamController.getTeamsList(function(err, teamsList){
       if(err){
            res.status(400).json({
                message: "Failed to get team list"
            })
        }
        else{
            res.status(200).json({
                teams: teamsList
            })
        }
    })
    
});

router.post('/createTeam', (req, res, next) => { //Method to create new team
    teamController.checkDuplicateTeamName(req.body.newTeam.team_name, function(err, teamNameExist){
        if(teamNameExist){
            res.status(400).json({
                message: "Team name already exist."
            })
        }
        else if(err){
            res.status(400).json({
                message: "Failed to check duplicate team name."
            })
        }
        else{
            teamController.createTeam(req.body.newTeam, function(err, team){
                if(err){
                    res.status(400).json({
                        message: "Unable to create new team"
                    })
                }
                else{
                    res.status(200).json({
                        message: "Successfully created team",
                        team: team
                    })
                }
               
            })
        }
    })
    
});

module.exports = router;
