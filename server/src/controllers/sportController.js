const pool = require('../db');

var sportController = {};

sportController.getSportsList = function(callback){
    
    var queryText = 'SELECT sport_id, sport_name, sport_description from sport where sport_active = true AND sport_deleted = false';
    
    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
};

module.exports = sportController;