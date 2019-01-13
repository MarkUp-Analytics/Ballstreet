const pool = require('../db');

var tournamentController = {};

tournamentController.getUpcomingTours = function(callback){
    var queryText = 'SELECT sp.sport_name, sp.sport_description, t.tournament_id, t.tournament_name, t.tournament_start_date, t.tournament_end_date from sport sp INNER JOIN tournament t on t.tournament_sport_id = sp.sport_id AND t.tournament_start_date > now() AND t.tournament_active = true AND sp.sport_active = true';
    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
};

tournamentController.getTotalGames = function(tournamentId, callback){
    var queryText = 'select count(*) as total_games from match_fixtures where match_fixture_tournament_id = $1 AND tournament_active = true';
    var queryParams = [tournamentId];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows[0]);
    });
}

module.exports = tournamentController;