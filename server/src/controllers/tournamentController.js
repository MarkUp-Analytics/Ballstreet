const pool = require('../db');

var tournamentController = {};

tournamentController.getUpcomingTours = function(callback){
    var queryText = 'SELECT sp.sport_name, sp.sport_description, t.tournament_id, t.tournament_name, t.tournament_start_date, t.tournament_end_date from sport sp INNER JOIN tournament t on t.tournament_sport_id = sp.sport_id AND t.tournament_start_date > now() AND t.tournament_active = true AND sp.sport_active = true';
    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
};

module.exports = tournamentController;