const express = require('express');
const router = express.Router();

const sportController = require('../controllers/sportController');

router.get('/getSportsList', (req, res, next) => { //Method to available sports list
    sportController.getSportsList(function(err, sportsList){
       if(err){
            res.status(400).json({
                message: "Failed to get sports list"
            })
        }
        else{
            res.status(200).json({
                sports: sportsList
            })
        }
    })
    
});

module.exports = router;
