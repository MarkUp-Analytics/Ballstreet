const pool = require('../db');
const format = require('pg-format');


var leagueMemberController = {};

leagueMemberController.createLeagueMember = function(leagueMemberDetails, callback){
    
    var queryText = 'INSERT INTO league_member (lm_league_id, league_member_user_id, league_member_joined_on, league_member_active, league_member_deleted) VALUES ($1, $2, $3, $4, $5) RETURNING *;';
    
    var queryParams = [leagueMemberDetails.leagueid, leagueMemberDetails.userid, new Date(), true, false];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else if(result){
            callback(null, result.rows[0]);
        }
        
    });
};

leagueMemberController.getAllMembers = function(leagueId, callback){ //Method to get all active league members
    var queryText = 'select lm.league_member_id, concat(u.firstname,\' \', u.lastname) as league_member_name, lm.league_member_joined_on, u.email as league_member_email from league_member lm inner join users u on u.userid = lm.league_member_user_id where lm.lm_league_id = $1 AND lm.league_member_active = true AND lm.league_member_deleted = false';
    
    var queryParams = [leagueId];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else if(result){
            callback(null, result.rows);
        }
        
    });
};

leagueMemberController.memberInLeague = function(userId, leagueId, callback){
    
    var queryText = 'SELECT * from league_member WHERE league_member_user_id = $1 AND lm_league_id = $2 AND league_member_active = true AND league_member_deleted = false';
    
    var queryParams = [userId, leagueId];
    pool.query(queryText, queryParams, (err, result) => {
        
        var memberBelongsToLeague = false;
        if(err){
            callback(err, memberBelongsToLeague);
        }
        if(result.rowCount == 1){
            memberBelongsToLeague = true;
        }
        callback(err, memberBelongsToLeague);
    });
};

leagueMemberController.createTeamPreference = function(preferences, leagueId, leagueMemberId, callback){
    var preferenceList = [];
    for(var i=0; i< preferences.length; i++){
        preferenceList.push([
            leagueId,
            preferences[i].teamId,
            preferences[i].rank,
            leagueMemberId,
            new Date(),
            true,
            false
        ]);
    }
    //New method to insert multiple rows
    
        var queryText = format('INSERT INTO league_member_preference (league_member_preference_league_id, league_member_preference_team_id, league_member_preference_rank, league_member_id, league_member_preference_updated_on, league_member_preference_active, league_member_preference_deleted) VALUES %L returning *', preferenceList);
        
        var queryParams = [];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err, null);
            }
            else if(result){
                leagueMemberController.getTeamPreference(leagueMemberId, callback);
            }
        });
    
};

leagueMemberController.getTeamPreference = function(leagueMemberId, callback){
    
        var queryText = 'SELECT t.team_id, t.team_name, t.team_abbreviation, t.team_image, lmp.league_member_preference_rank as preference_rank from team t inner join league_member_preference lmp on lmp.league_member_preference_team_id = t.team_id where lmp.league_member_id = $1 AND t.team_active = true AND t.team_deleted = false AND lmp.league_member_preference_active = true AND lmp.league_member_preference_deleted = false';
        
        var queryParams = [leagueMemberId];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err);
            }
            else if(result.rowCount > 0){
                callback(null, result.rows);
            }
            else{
                callback(null, null);
            }
        });
    
};

leagueMemberController.updateTeamPreference = function(preferences, leagueId, leagueMemberId, callback){
    var preferenceList = [];
    for(var i=0; i< preferences.length; i++){
        preferenceList.push([
            leagueId,
            preferences[i].team_id,
            preferences[i].preference_rank,
            leagueMemberId,
            new Date(),
            true,
            false
        ]);
    }
    //New method to insert multiple rows
    
        var queryText = format('UPDATE league_member_preference AS lmp SET league_member_preference_rank = CAST(c.league_member_preference_rank AS INTEGER),league_member_preference_updated_on = CAST(c.league_member_preference_updated_on AS TIME) FROM (VALUES %L) as c(league_member_preference_league_id, league_member_preference_team_id, league_member_preference_rank, league_member_id, league_member_preference_updated_on, league_member_preference_active, league_member_preference_deleted) where CAST(c.league_member_id AS INTEGER) = lmp.league_member_id AND CAST(c.league_member_preference_league_id AS INTEGER) = lmp.league_member_preference_league_id AND CAST(c.league_member_preference_team_id AS INTEGER) = lmp.league_member_preference_team_id RETURNING *;', preferenceList);
        var queryParams = [];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err);
            }
            else if(result){
                leagueMemberController.getTeamPreference(leagueMemberId, callback);
            }
        });
    
};

leagueMemberController.getLeagueMemberId = function(userId, leagueId, callback){
    var queryText = 'SELECT league_member_id from league_member WHERE league_member_user_id = $1 AND lm_league_id = $2 AND league_member_active = true AND league_member_deleted = false';
        
        var queryParams = [userId, leagueId];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err);
            }
            else if(result){
                callback(null, result.rows[0].league_member_id);
            }
        });
};

module.exports = leagueMemberController;