const pool = require('../db');

var profileController = {};

profileController.getAssociatedLeagues = function(userid, callback){
    
    var queryText = 'select l.*, t.tournament_name from league l inner join league_member lm on l.league_id = lm.lm_league_id and lm.league_member_user_id = $1 AND lm.league_member_active = true inner join tournament t on t.tournament_id = l.league_tournament_id';
    var queryParams = [userid];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
};

module.exports = profileController;