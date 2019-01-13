const pool = require('../db');

var leagueMemberController = {};

leagueMemberController.createLeagueMember = function(leagueMemberDetails, callback){
    
    var queryText = 'INSERT INTO league_member (lm_league_id, league_member_user_id, league_member_active, league_member_deleted) VALUES ($1, $2, $3, $4)';
    
    var queryParams = [leagueMemberDetails.leagueid, leagueMemberDetails.userid, true, false];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result);
    });
};

module.exports = leagueMemberController;