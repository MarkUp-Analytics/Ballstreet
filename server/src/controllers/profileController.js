const pool = require('../db');

var profileController = {};

profileController.getAssociatedLeagues = function(userid, callback){
    
    var queryText = 'select l.* from league l inner join league_member lm on l.league_id = lm.lm_league_id and lm.league_member_user_id = $1 AND lm.league_member_active = true';
    var queryParams = [userid];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
}

module.exports = profileController;