const pool = require('../db');

var leagueController = {};

leagueController.createLeague = function(userid, leagueDetails, callback){
    
    var queryText = 'INSERT INTO league (league_name, league_tournament_id, league_created_by, league_created_on, league_minimum_bet, league_active, league_deleted) VALUES ($1, $2, $3, $4, $5, $6, $7)';
    
    var queryParams = [leagueDetails.league_name, leagueDetails.tournament_id, userid, new Date(), leagueDetails.minimum_bet, true, false];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
}

module.exports = leagueController;