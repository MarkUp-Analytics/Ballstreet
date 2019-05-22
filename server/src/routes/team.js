const express = require('express');
const router = express.Router();
const multer = require('multer');
var storage = multer.diskStorage({
    destination: function (req, file, callback) {
        callback(null, './uploads')
    },
    filename: function (req, file, callback) {
        callback(null, Date.now() + file.originalname)
    }
  })
  
var upload = multer({ storage: storage });

const teamController = require('../controllers/teamController');
const userController = require('../controllers/userController');

router.get('/getTeamsList', (req, res, next) => { //Method to get available team list
    teamController.getTeamsList(function(err, teamsList){
       if(err){
            res.status(400).json({
                message: "Failed to get team list"
            })
        }
        else{
            for(var i=0; i<teamsList.length; i++){
                if(teamsList[i].team_image){
                    teamsList[i].team_image = req.protocol + "://" + req.headers.host + '/' + teamsList[i].team_image;
                }
            }
            res.status(200).json({
                teamList: teamsList
            })
        }
    })
    
});

router.post('/createTeam', upload.single('file'), (req, res, next) => { //Method to create new team
    var teamDetails = JSON.parse(req.body.teamDetails);
    userController.checkUserIsAdmin(teamDetails.userid, function(err, userIsAdmin){
        if(err){
            res.status(400).json({
                message: "Unable to check user has permission"
            })
        }
        else if(!userIsAdmin){
            res.status(400).json({
                message: "User does not have permission to create team"
            })
        }
        else if(userIsAdmin){
            teamController.checkDuplicateTeamName(teamDetails.team_name, function(err, teamNameExist){
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
                    teamDetails.team_image = req.file.path;
                    teamController.createTeam(teamDetails, function(err, team){
                        if(err){
                            res.status(400).json({
                                message: "Unable to create new team"
                            })
                        }
                        else{
                            team.team_image = req.protocol + "://" + req.headers.host + '/' + team.team_image;
                            res.status(200).json({
                                message: "Successfully created team",
                                team: team
                            })
                        }
                       
                    })
        
                }
            });
        }
    });
    
    
});

router.post('/updateTeamWithImage', upload.single('file'), (req, res, next) => { //Method to create new team
    var teamDetails = JSON.parse(req.body.teamDetails);
    userController.checkUserIsAdmin(teamDetails.userid, function(err, userIsAdmin){
        if(err){
            res.status(400).json({
                message: "Unable to check user has permission"
            })
        }
        else if(!userIsAdmin){
            res.status(400).json({
                message: "User does not have permission to update team"
            })
        }
        else if(userIsAdmin){
            teamDetails.team_image = req.file.path;
            teamController.updateTeamWithImage(teamDetails, function(err, team){
            if(err){
                res.status(400).json({
                    message: "Unable to update team"
                })
            }
            else{
                team.team_image = req.protocol + "://" + req.headers.host + '/' + team.team_image;
                res.status(200).json({
                    message: "Successfully updated team",
                    team: team
                    })
                }
                       
            })
        }
    });
    
    
});

router.post('/updateTeamWithoutImage', (req, res, next) => { //Method to create new team
    var teamDetails = {};
    teamDetails.userid = req.body.userid;
    teamDetails.team_id = req.body.team_id;
    teamDetails.team_name = req.body.team_name;
    teamDetails.team_abbreviation = req.body.team_abbreviation;

    userController.checkUserIsAdmin(teamDetails.userid, function(err, userIsAdmin){
        if(err){
            res.status(400).json({
                message: "Unable to check user has permission"
            })
        }
        else if(!userIsAdmin){
            res.status(400).json({
                message: "User does not have permission to update team"
            })
        }
        else if(userIsAdmin){
            teamController.updateTeamWithoutImage(teamDetails, function(err, team){
            if(err){
                res.status(400).json({
                    message: "Unable to update team"
                })
            }
            else{
                team.team_image = req.protocol + "://" + req.headers.host + '/' + team.team_image;
                res.status(200).json({
                    message: "Successfully updated team",
                    team: team
                    })
                }
                       
            })
        }
    });
    
    
});

module.exports = router;
