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

module.exports = router;
