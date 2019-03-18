const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController');
const stadiumController = require('../controllers/stadiumController');

router.post('/createStadium', (req, res, next) => { //Method to create a new stadium
    userController.checkUserIsAdmin(req.body.userid, function(err, userIsAdmin){
        if(err){
            res.status(400).json({
                message: "Unable to check user has permission"
            })
        }
        else if(!userIsAdmin){
            res.status(400).json({
                message: "User does not have permission to create stadium"
            })
        }
        else if(userIsAdmin){
            stadiumController.checkDuplicateStadiumName(req.body.stadiumName, function(err, stadiumNameExist){
                if(err){
                    res.status(400).json({
                        message: "Unable to check stadium name exist"
                    })
                }
                else if(stadiumNameExist){
                    res.status(400).json({
                        message: "Stadium name already exist"
                    })
                }
                else{
                    stadiumController.createStadium(req.body, function(err, stadium){
                        if(err){
                            res.status(400).json({
                                message: "Unable to create a stadium"
                            })
                        }
                        else{
                            res.status(200).json({
                                message: "Stadium created successfully",
                                stadium: stadium
                            })
                        }
                    });
                    
                }
            })
        }
    });
    
    });

router.get('/getStadiumList', (req, res, next) => { //Method to get available stadium list
    stadiumController.getStadiumList(function(err, stadiumList){
           if(err){
                res.status(400).json({
                    message: "Failed to get stadium list"
                })
            }
            else{
                res.status(200).json({
                    stadiumList: stadiumList
                })
            }
        })
        
    });

router.get('/getStadiumTimezone', (req, res, next) => { //Method to get stadium timezone from stadium id
    stadiumController.getStadiumTimezone(req.stadiumid, function(err, stadiumTimezone){
           if(err){
                res.status(400).json({
                    message: "Failed to get stadium timezone"
                })
            }
            else{
                res.status(200).json({
                    stadiumTimezone: stadiumTimezone
                })
            }
        })
        
    });

module.exports = router;
