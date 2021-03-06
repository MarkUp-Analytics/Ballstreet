const pool = require('../db');
const shortid = require('shortid');

var leagueController = {};

leagueController.createLeague = function(userid, leagueDetails, callback){
    
    var queryText = 'INSERT INTO league (league_name, league_shortid, league_pin, league_tournament_id, league_created_by, league_created_on, league_minimum_bet, league_active, league_deleted) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *;';

    var queryParams = [leagueDetails.league_name, shortid.generate(), shortid.generate(), leagueDetails.tournament_id, userid, new Date(), leagueDetails.minimum_bet, true, false];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        callback(err, result.rows[0]);
    });
};

leagueController.checkDuplicateLeagueName = function(league_name, callback){
    var queryText = 'SELECT * from league where league_name = $1 AND league_active = true';
    
    var queryParams = [league_name];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        var leagueExist = false;
        if(result.rowCount == 1){
            leagueExist = true;
        }
        callback(err, leagueExist);
    });
};

leagueController.searchLeaguesByShortId = function(leagueShortId, tournamentId, callback){
    var queryText = 'select l.league_id, l.league_shortid, l.league_pin, l.league_tournament_id, l.league_name, l.league_created_on, l.league_minimum_bet, concat(u.firstname,\' \', u.lastname) as league_created_by, u.userid, lm.league_total_members from league l inner join users u on u.userid = l.league_created_by inner join (select lm_league_id, count(*) as league_total_members from league_member where league_member_active = true group by lm_league_id) lm on lm.lm_league_id = l.league_id where l.league_shortid like $1 AND l.league_tournament_id = $2 AND l.league_active = true';
    var queryParams = ['%' + leagueShortId + '%', tournamentId];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null)
        }
        else{
            callback(err, result.rows);
        }
        
    });
};

leagueController.findLeagueByShortId = function(leagueShortId, callback){
    var queryText = 'select l.league_id, l.league_shortid, l.league_pin, l.league_tournament_id, l.league_name, l.league_created_on, l.league_minimum_bet, concat(u.firstname,\' \', u.lastname) as league_created_by, u.userid, lm.league_total_members from league l inner join users u on u.userid = l.league_created_by inner join (select lm_league_id, count(*) as league_total_members from league_member where league_member_active = true group by lm_league_id) lm on lm.lm_league_id = l.league_id where l.league_shortid = $1 AND l.league_active = true';
    var queryParams = [leagueShortId];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else if(result.rowCount > 1 || result.rowCount == 0){
            callback(err, null);
            
        }
        else if(result.rowCount == 1){
            callback(err, result.rows[0]);
        }
        
    });
};

leagueController.compareLeagueKey = function(leagueId, leagueKey, callback){
    var queryText = 'select * from league where league_id = $1 AND league_pin = $2 AND league_active = true AND league_deleted = false';
    var queryParams = [leagueId, leagueKey];
    pool.query(queryText, queryParams, (err, result) => {
        var leagueMatches = false;
        if(err){
            callback(err, null)
        }
        else if(result && (result.rowCount == 0 || result.rowCount > 1)){
            callback(err, leagueMatches);
        }
        else if(result && result.rowCount == 1){
            leagueMatches = true;
            callback(err, leagueMatches);
        }
        
    });
};

module.exports = leagueController;