const pool = require('../db');

var profileController = {};

profileController.getAssociatedLeagues = function(userid, callback){

    // var queryText = 'select l.league_id, l.league_name, l.league_tournament_id, lm.league_member_id, l.league_created_on, l.league_minimum_bet, l.league_shortid, l.league_pin, concat(u.firstname, \' \', u.lastname) as league_created_by, lt.league_total_members, t.tournament_name from league l inner join league_member lm on l.league_id = lm.lm_league_id AND lm.league_member_user_id = $1 AND lm.league_member_active = true inner join tournament t on t.tournament_id = l.league_tournament_id inner join users u on u.userid = l.league_created_by inner join (select lm_league_id, count(*) as league_total_members from league_member where league_member_active = true group by lm_league_id) lt on lt.lm_league_id = l.league_id ';

    var queryText = 'select subquery.league_id, MAX(subquery.league_name) as league_name, su(subquery.member_money_won) as profit_loss, MAX(subquery.league_tournament_id) as league_tournament_id, MAX(subquery.league_created_on) as league_created_on, MAX(subquery.league_minimum_bet) as league_minimum_bet, MAX(subquery.league_shortid) as league_shortid, MAX(subquery.league_created_by) as league_created_by, MAX(subquery.league_total_members)as league_total_members from (select l.league_id, l.league_name, l.league_tournament_id, lm.league_member_id,l.league_created_on, l.league_minimum_bet, l.league_shortid, lm.league_member_id, ms.member_statistics_id, ms.member_money_won, mf.match_fixture_id, concat(u.firstname, \' \', u.lastname) as league_created_by, lt.league_total_members from league l inner join league_member lm on l.league_id = lm.lm_league_id AND lm.league_member_user_id = $1 AND lm.league_member_active = true left join member_statistics ms on ms.league_member_id = lm.league_member_id left join match_fixtures mf on mf.match_fixture_id = ms.match_fixture_id left join users u on u.userid = l.league_created_by left join (select lm_league_id, count(*) as league_total_members from league_member lm1 where league_member_active = true group by lm_league_id) lt on lt.lm_league_id = l.league_id) subquery group by subquery.league_id';

    var queryParams = [userid];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else{
            callback(null, result.rows);
        }
        
    });
};

module.exports = profileController;