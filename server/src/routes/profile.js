const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController');
const profileController = require('../controllers/profileController');

router.get('/associatedLeagues', (req, res, next) => { //Method to get all leagues associated with the logged in user
    
    userController.getUserIDFromShortID(req.query.shortid, function(err, userid){
        if(userid){
            profileController.getAssociatedLeagues(userid, function(err, associatedLeagues){
                if(err){
                    res.status(400).json({
                        message: "Unable to get associated leagues"
                    })
                }
                if(associatedLeagues.length === 0){
                    res.status(200).json({
                        message: "User is not associated with any league",
                        leagues: []
                        
                    })
                }
                else if(associatedLeagues.length > 0){
                    res.status(200).json({
                        message: "User is associated with " + associatedLeagues.length + " league(s)",
                        leagues: associatedLeagues
                        
                    })
                }
            })
        }
        else{
            res.status(400).json({
                message: "Unable to find user details."
            })
        }
    })
});

router.get('/isUserAdmin', (req, res, next) => { //Method to check if a user has admin access
    
    userController.checkUserIsAdmin(req.query.userId, function(err, userIsAdmin){
        if(err){
            res.status(400).json({
                message: "Unable to check user has permission"
            })
        }
        else{
            res.status(200).json({
                userIsAdmin: userIsAdmin
            })
        }
    });
});

module.exports = router;
