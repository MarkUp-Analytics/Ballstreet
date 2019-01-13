const pool = require('../db');
const shortid = require('shortid');

var leagueController = {};

leagueController.createLeague = function(userid, leagueDetails, callback){
    
    var queryText = 'INSERT INTO league (league_name, league_shortid, league_tournament_id, league_created_by, league_created_on, league_minimum_bet, league_active, league_deleted) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *;';
    
    var queryParams = [leagueDetails.league_name, shortid.generate(), leagueDetails.tournament_id, userid, new Date(), leagueDetails.minimum_bet, true, false];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows[0]);
    });
};

leagueController.checkDuplicateLeagueName = function(league_name, callback){
    var queryText = 'SELECT * from league where league_name = $1 AND league_active = true';
    
    var queryParams = [league_name];
    pool.query(queryText, queryParams, (err, result) => {
        
        var leagueExist = false;
        if(result.rowCount == 1){
            leagueExist = true;
        }
        callback(err, leagueExist);
    });
};

leagueController.getLeagueByShortId = function(leagueShortId, callback){
    var queryText = 'select *  from league where league_shortid = $1 AND league_active = true';
    var queryParams = [leagueShortId];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null)
        }
        else{
            callback(err, result.rows);
        }
        
    });
};

module.exports = leagueController;