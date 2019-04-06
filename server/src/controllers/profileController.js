const pool = require('../db');

var profileController = {};

profileController.getAssociatedLeagues = function(userid, callback){
    
    // var queryText = 'select l.*, t.tournament_name from league l inner join league_member lm on l.league_id = lm.lm_league_id and lm.league_member_user_id = $1 AND lm.league_member_active = true inner join tournament t on t.tournament_id = l.league_tournament_id';

    var queryText = 'select l.league_id, l.league_name, l.league_tournament_id, lm.league_member_id, l.league_created_on, l.league_minimum_bet, l.league_shortid, l.league_pin, concat(u.firstname, \' \', u.lastname) as league_created_by, lt.league_total_members, t.tournament_name from league l inner join league_member lm on l.league_id = lm.lm_league_id AND lm.league_member_user_id = $1 AND lm.league_member_active = true inner join tournament t on t.tournament_id = l.league_tournament_id inner join users u on u.userid = l.league_created_by inner join (select lm_league_id, count(*) as league_total_members from league_member where league_member_active = true group by lm_league_id) lt on lt.lm_league_id = l.league_id ';

    var queryParams = [userid];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
};

module.exports = profileController;