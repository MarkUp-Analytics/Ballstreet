const express = require('express');
const router = express.Router();

const authController = require('../controllers/authController');

router.post('/', (req, res, next) => { //Method to login
    var username = req.body.username;
    var password = req.body.password;
    authController.userExist(req.body.username, function(err, userExist){
        if(userExist){
            authController.comparePassword(req.body, function(err, userDetails){
                if(err && err.hasOwnProperty('message')){ //Error object has custom message created in the controller
                    res.status(400).json({
                        message: err.message
                    })
                }
                else if(err && !err.hasOwnProperty('message')){
                    res.status(400).json({
                        message: "Issue checking password"
                    })
                }
                if(userDetails){
                    res.status(200).json({
                        message: "Logged in succesfully",
                        userDetails: userDetails
                    })
                }
            })
        }
        else{
            res.status(400).json({
                message: "User does not exist."
            })
        }
    })
});
router.post('/signup', (req, res, next) => { // Method to create new user
    authController.userExist(req.body.username, function (err, userExist) {

        if (userExist) {
            res.status(400).json({
                message: "User already exist"
            })
        }
        else {
            authController.createUser(req.body, function (err, createdUser) {
                if (err) {
                    res.status(400).json({
                        message: "Error creating user",
                        errorDetail: err
                    })
                }
                else {
                    res.status(200).json({
                        message: "User successfully created.",
                        userDetails: createdUser
                    })
                }
            })
        }
    });
});

module.exports = router;
