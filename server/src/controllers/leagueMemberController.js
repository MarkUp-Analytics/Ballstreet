const pool = require('../db');

var leagueMemberController = {};

leagueMemberController.createLeagueMember = function(leagueMemberDetails, callback){
    
    var queryText = 'INSERT INTO league_member (lm_league_id, league_member_user_id, league_member_active, league_member_deleted) VALUES ($1, $2, $3, $4)';
    
    var queryParams = [leagueMemberDetails.leagueid, leagueMemberDetails.userid, true, false];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result);
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

module.exports = leagueMemberController;