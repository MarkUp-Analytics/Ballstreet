const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController');

/*
new Date("2018-11-19 20:00:00").toLocaleString("en-US", {timeZone: "Asia/Kolkata"})
The above string works in modern browser. So we have to save time zome in match_fixtures table to get the correct local time of where the match is held.
To get time zone values select * from pg_timezone_names; Use only name column as that is the primary key for this table and DONOT USE abbrev column.

*/

router.get('/getTeamsList', (req, res, next) => { //Method to get available team list
    teamController.getTeamsList(function(err, teamsList){
       if(err){
            res.status(400).json({
                message: "Failed to get team list"
            })
        }
        else{
            
            res.status(200).json({
                teamList: teamsList
            })
        }
    })
    
});

module.exports = router;
