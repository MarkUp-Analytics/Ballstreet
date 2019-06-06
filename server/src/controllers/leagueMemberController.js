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
    
        var queryText = format('INSERT INTO league_member_preference (league_member_preference_league_id, league_member_preference_team_id, league_member_preference_rank, league_member_id, last_updated_on, league_member_preference_active, league_member_preference_deleted) VALUES %L returning *', preferenceList);
        
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
            new Date().toLocaleString(),
            true,
            false
        ]);
    }
    //New method to insert multiple rows
    
        var queryText = format('UPDATE league_member_preference AS lmp SET league_member_preference_rank = CAST(c.league_member_preference_rank AS INTEGER),last_updated_on = CAST(c.last_updated_on AS TIMESTAMP) FROM (VALUES %L) as c(league_member_preference_league_id, league_member_preference_team_id, league_member_preference_rank, league_member_id, last_updated_on, league_member_preference_active, league_member_preference_deleted) where CAST(c.league_member_id AS INTEGER) = lmp.league_member_id AND CAST(c.league_member_preference_league_id AS INTEGER) = lmp.league_member_preference_league_id AND CAST(c.league_member_preference_team_id AS INTEGER) = lmp.league_member_preference_team_id RETURNING *;', preferenceList);
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

leagueMemberController.getResults = function(leagueMemberId, tournamentId, callback){ // Method used to get details for Result page in league dashboard

    var queryText = 'SELECT mf.match_fixture_id, mf.match_fixture_start_date, mf.match_fixture_toss_time, ' +
    'tm1.team_name as team_a, tm1.team_abbreviation as team_a_abbreviation, ' +
    'tm2.team_name as team_b, tm2.team_abbreviation as team_b_abbreviation, ' +
    'CASE ' +
        'WHEN mf.match_fixture_result_won IS Not NULL THEN tm3.team_name ' +
        'WHEN mf.match_fixture_result_draw = true THEN \'Drawn\' ' +
        'WHEN mf.match_fixture_no_result = true THEN \'No Result\' ' +
        'END as match_result, ' +
    'CASE ' +
        'WHEN mf.match_fixture_result_won IS Not NULL THEN tm3.team_abbreviation ' +
        'WHEN mf.match_fixture_result_draw = true THEN \'Drawn\' ' +
        'WHEN mf.match_fixture_no_result = true THEN \'No Result\' ' +
        'END as match_result_abbreviation, ' +
    'ms.member_money_won as profit_loss, ' +
    '(SELECT count(*) FROM member_team_selection mts WHERE mts.selected_team = mf.match_fixture_team_1 AND mts.match_fixture_id = mf.match_fixture_id) as team_a_supporters, ' +
    '(SELECT count(*) FROM member_team_selection mts WHERE mts.selected_team = mf.match_fixture_team_2 AND mts.match_fixture_id = mf.match_fixture_id) as team_b_supporters, ' +
    '(SELECT tm4.team_abbreviation from team tm4 left join member_team_selection mts on mts.selected_team = tm4.team_id ' +
     'WHERE mts.league_member_id = $1 AND mts.match_fixture_id = mf.match_fixture_id ) ' +
    'as user_selection, ' +
    'concat(sd.stadium_name, \', \', sd.stadium_city) as stadium, sd.stadium_timezone ' +
    'from match_fixtures mf ' +
    'INNER JOIN stadium sd on sd.stadium_id = mf.match_fixture_venue_stadium_id ' +
    'INNER JOIN team tm1 on tm1.team_id = mf.match_fixture_team_1 ' +
    'INNER JOIN team tm2 on tm2.team_id = mf.match_fixture_team_2 ' +
    'INNER JOIN member_statistics ms on ms.match_fixture_id = mf.match_fixture_id ' +
    'LEFT JOIN team tm3 on tm3.team_id = mf.match_fixture_result_won ' +
    'WHERE mf.match_fixture_tournament_id = $2 AND ms.league_member_id = $1 AND ' +
    'mf.match_fixture_result_won IS NOT NULL ' +
    'OR mf.match_fixture_result_draw IS NOT NULL OR mf.match_fixture_no_result IS NOT NULL';

    var queryParams = [leagueMemberId, tournamentId];

    pool.query(queryText, queryParams, (err, result) => {
        
        if(err){
            callback(err, null)
        }
        else if(result){
            callback(err, result.rows);
        }
        
    });
};

leagueMemberController.getLeagueStatistics = function(leagueId, callback){
    var queryText = 'select concat(users.firstname, \' \', users.lastname) as member_name, users.email, CAST(sum(member_money_won) as numeric(10,2)) as profit_loss, CAST((avg(member_risk_taking_score) * 100.0) as numeric(5,2)) as risk_taking_score, string_agg(member_result, \', \' ORDER BY match_fixture_id) as current_streak from member_statistics ms inner join league_member lm on ms.league_member_id = lm.league_member_id inner join users on users.userid = lm.league_member_user_id where league_id = $1 group by lm.league_member_id, users.userid';

    var queryParams = [leagueId];

    pool.query(queryText, queryParams, (err, result) => {
        
        if(err){
            callback(err, null)
        }
        else if(result){
            callback(err, result.rows);
        }
        
    });
};

leagueMemberController.getLeaguePicks = function(leagueId, callback){
    var queryText = 'select mts.league_member_id, concat(users.firstname, \' \', users.lastname) as name, mf.match_fixture_id, mf.match_fixture_start_date, mf.match_fixture_team_1, mf.match_fixture_team_2, mts.selected_team, mf.match_fixture_result_won, mf.match_fixture_result_draw, mf.match_fixture_no_result, mf.match_fixture_locked from member_team_selection mts inner join match_fixtures mf on mts.match_fixture_id = mf.match_fixture_id inner join league_member lm on lm.league_member_id = mts.league_member_id inner join users on users.userid = lm.league_member_user_id where mts.league_id = $1 AND mf.match_fixture_locked = true order by mf.match_fixture_id, mts.league_member_id;';

    var queryParams = [leagueId];

    pool.query(queryText, queryParams, (err, result) => {
        
        if(err){
            callback(err, null)
        }
        else if(result){
            callback(err, result.rows);
        }
        
    });
};

leagueMemberController.getAllAvailableGames = function(leagueMemberId, leagueId, callback){
    var queryText = 'select mf.match_fixture_id, mf.match_fixture_start_date, mf.match_fixture_toss_time, t1.team_id as team_1_id, t2.team_id as team_2_id, t3.team_id as selected_team_id, concat(std.stadium_name, \', \', std.stadium_city) as stadium_name, std.stadium_timezone from member_team_selection mts inner join match_fixtures mf on mf.match_fixture_id = mts.match_fixture_id inner join stadium std on std.stadium_id = mf.match_fixture_venue_stadium_id inner join team t1 on t1.team_id = mf.match_fixture_team_1 inner join team t2 on t2.team_id = mf.match_fixture_team_2 inner join team t3 on t3.team_id = mts.selected_team where mts.league_member_id = $1 AND mts.league_id = $2 AND mts.member_team_selection_locked is not true';

    var queryParams = [leagueMemberId, leagueId];

    pool.query(queryText, queryParams, (err, result) => {
        
        if(err){
            callback(err, null)
        }
        else if(result){
            callback(err, result.rows);
        }
        
    });
};


module.exports = leagueMemberController;