const pool = require('../db');

var stadiumController = {};

stadiumController.getStadiumList = function(callback){
    var queryText = 'SELECT * from stadium WHERE stadium_active = true and stadium_deleted = false;';

    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        
        callback(err, result.rows);
    });
};

stadiumController.createStadium = function(stadiumDetails, callback){
    
    var queryText = 'INSERT INTO team (stadium_name, stadium_city, stadium_state, stadium_country, stadium_timezone, stadium_created_by, stadium_created_on, stadium_active, stadium_deleted) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *;';

    var queryParams = [stadiumDetails.stadiumName, stadiumDetails.stadiumCity, stadiumDetails.stadiumState,  stadiumDetails.stadiumCountry, stadiumDetails.stadiumTimezone, stadiumDetails.userid, new Date(), true, false];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        callback(err, result.rows[0]);
    });
};

stadiumController.checkDuplicateStadiumName = function(stadium_name, callback){
    var queryText = 'SELECT * from stadium where stadium_name = $1 AND stadium_active = true AND stadium_deleted = false';
    
    var queryParams = [stadium_name];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        var stadiumExist = false;
        if(result && result.rowCount == 1){
            stadiumExist = true;
        }
        callback(err, stadiumExist);
    });
};

stadiumController.getStadiumTimezone = function(stadium_id, callback){
    var queryText = 'SELECT stadium_timezone from stadium where stadium_id = $1 AND stadium_active = true AND stadium_deleted = false';
    
    var queryParams = [stadium_id];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else{
            callback(err, result.rows[0]);
        }
    });
}

module.exports = stadiumController;