const pool = require('../db');
const format = require('pg-format');

var teamSelectionController = {};

teamSelectionController.getMemberPredictionForAllGames = function(tournamentId, leagueMemberId, callback){ //This method will return the prediction for games in a tournament which are not yet completed for one league member whose preferences are set. 
    var queryText = 'select mf.match_fixture_id, lmp1.league_member_id, mf.match_fixture_tournament_id, mf.match_fixture_team_1 as team_1_id, ' +
   'mf.match_fixture_team_2 as team_2_id, ' +
    'lmp1.league_member_preference_rank as team_1_rank, lmp2.league_member_preference_rank as team_2_rank, ' +
    'case when lmp1.league_member_preference_rank < lmp2.league_member_preference_rank then mf.match_fixture_team_1 else mf.match_fixture_team_2 END as user_preference_team ' +
      'from (select match_fixture_id, match_fixture_tournament_id, match_fixture_team_1, match_fixture_team_2 ' +
              'from match_fixtures' +
              ' where ' +
                'match_fixture_locked is NULL ' +
                'AND match_fixture_result_won is NULL ' +
                'AND match_fixture_result_draw is NULL ' +
                'AND match_fixture_no_result is NULL ' +
                'AND match_fixture_team_1 is NOT NULL ' +
				'AND match_fixture_team_2 is NOT NULL ' +
              'group by match_fixture_id) mf ' +
    'inner join (select league_member_preference_team_id, league_member_id, league_member_preference_rank ' +
                  'from league_member_preference' +
                  ') lmp1 ' +
      'on (lmp1.league_member_preference_team_id = mf.match_fixture_team_1) ' +
    'inner join (select league_member_preference_team_id, league_member_id, league_member_preference_rank ' +
                  'from league_member_preference' +
                  ') lmp2 ' +
      'on (lmp2.league_member_preference_team_id = mf.match_fixture_team_2) ' +
      'where mf.match_fixture_tournament_id=$1 AND lmp1.league_member_id = $2 AND lmp2.league_member_id = $2';
        
        var queryParams = [tournamentId, leagueMemberId];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err);
            }
            else if(result){
                callback(null, result.rows);
            }
        });
};

teamSelectionController.createTeamSelection = function(predictions, leagueId, leagueMemberId, callback){// This method is used to set each match prediction for a member when they join/create a league. Manually updated flag will be set only if the player overrides the match winner individually for a match
    var predictionList = [];
    for(var i=0; i< predictions.length; i++){
        predictionList.push([
            leagueId,
            leagueMemberId,
            predictions[i].match_fixture_id,
            predictions[i].user_preference_team,
            new Date(),
            false,
            false,
            true,
            false
        ]);
    }
    //New method to insert multiple rows
    
        var queryText = format('INSERT INTO member_team_selection (league_id, league_member_id, match_fixture_id, selected_team, last_update_on, manuallY_updated, member_team_selection_locked, member_team_selection_active, member_team_selection_deleted) VALUES %L returning *;', predictionList);
        var queryParams = [];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err, null);
            }
            else if(result){
                callback(null, result.rows);
            }
        });
};

teamSelectionController.updateSingleTeamSelection = function(leagueId, leagueMemberId, matchFixtureId, selectedTeam, callback){// This method is used to override single match prediction for a member when they override their preference manually.
    
        var queryText = 'UPDATE member_team_selection set selected_team = CAST($4 AS BIGINT), last_update_on = CAST($5 AS TIMESTAMP), manually_updated = true where league_id = $1 AND league_member_id = $2 AND match_fixture_id = $3 RETURNING *;';

        var queryParams = [leagueId, leagueMemberId, matchFixtureId, selectedTeam, new Date()];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err, null);
            }
            else if(result){
                callback(null, result.rows);
            }
        });
};

teamSelectionController.updateTeamSelection = function(predictions, leagueId, leagueMemberId, callback){// This method is used to update each match prediction for a member when they modify their preference.
    var predictionList = [];
    for(var i=0; i< predictions.length; i++){
        predictionList.push([
            leagueId,
            leagueMemberId,
            predictions[i].user_preference_team,
            predictions[i].match_fixture_id,
            new Date()
        ]);
    }
    //New method to update multiple rows
    
        var queryText = format('UPDATE member_team_selection mts set selected_team = CAST(result.selected_team AS BIGINT), last_update_on = CAST(result.last_update_on AS TIMESTAMP), manually_updated = false from ( VALUES %L ) as result(league_id, league_member_id, selected_team, match_fixture_id, last_update_on)  where CAST(result.league_id AS BIGINT) = mts.league_id AND CAST(result.league_member_id AS BIGINT) = mts.league_member_id AND CAST(result.match_fixture_id AS BIGINT) = mts.match_fixture_id RETURNING *;', predictionList);
        var queryParams = [];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err, null);
            }
            else if(result){
                callback(null, result);
            }
        });
};

teamSelectionController.getTeamSelection = function(leagueId, leagueMemberId){// This method is used to get all match predictions for a member in a league.
    
        var queryText = 'SELECT * FROM member_team_selection where league_id = $1 AND league_member_id = $2 AND member_team_selection_active = true AND member_team_selection_deleted = false';
        var queryParams = [leagueId, leagueMemberId];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err, null);
            }
            else if(result){
                callback(null, result);
            }
        });
};

teamSelectionController.updateResult = function(matchFixtureId, callback){
    
    var queryText = 'WITH subquery AS (select result.member_team_selection_id, result.league_member_id,result.match_fixture_id, true as member_team_selection_locked, CASE WHEN result.match_fixture_result_won IS NOT NULL THEN CASE WHEN result.selected_team = result.match_fixture_result_won THEN \'W\' ELSE \'L\' END WHEN result.match_fixture_result_draw = true THEN \'D\' WHEN result.match_fixture_no_result = true THEN \'N\' END as match_result FROM (select mts.member_team_selection_id,mts.league_member_id, mts.match_fixture_id, mts.selected_team,mf.match_fixture_result_won, mf.match_fixture_result_draw, mf.match_fixture_no_result from member_team_selection mts inner join match_fixtures mf on mf.match_fixture_id = mts.match_fixture_id where mf.match_fixture_id = $1) as result) UPDATE member_team_selection SET member_team_selection_locked = subquery.member_team_selection_locked, match_result = subquery.match_result FROM subquery WHERE member_team_selection.member_team_selection_id = subquery.member_team_selection_id';
        var queryParams = [matchFixtureId];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err, null);
            }
            else if(result){
                callback(null, result);
            }
        });
};


teamSelectionController.updateStatistics = function(matchFixtureId, callback){

    // This method inserts stats about each member in each league playing a particular tournament, when a game result is updated. This has to be done only once when the match is done.

    var queryText = 'INSERT INTO member_statistics (league_member_id, league_id, match_fixture_id, member_result, member_money_won, member_risk_taking_score,members_with_same_team, member_statistics_active, member_statistics_deleted)		select mts.league_member_id, mts.league_id, mts.match_fixture_id, CASE WHEN mf.match_fixture_result_won IS NOT NULL THEN CASE WHEN  mts.selected_team = mf.match_fixture_result_won THEN \'W\' ELSE \'L\' END WHEN mf.match_fixture_result_draw = true THEN \'D\' WHEN mf.match_fixture_no_result = true THEN \'N\' END  as member_result, CASE WHEN mf.match_fixture_result_won IS NOT NULL THEN CASE WHEN  mts.selected_team = mf.match_fixture_result_won THEN CAST((CAST(league_group.total_members * l.league_minimum_bet AS numeric)/CAST(team_selection.total_member_selected AS numeric)) - CAST(l.league_minimum_bet AS numeric) AS numeric(20,2)) WHEN mts.selected_team != mf.match_fixture_result_won AND league_group.total_members = team_selection.total_member_selected THEN 0.0 ELSE CAST(CAST(-1 AS numeric) * CAST(l.league_minimum_bet AS numeric) AS numeric(20,2)) END WHEN mf.match_fixture_result_draw = true THEN 0 WHEN mf.match_fixture_no_result = true THEN 0 END  as member_money_won, CAST(CAST(1 AS numeric(3,2))/(team_selection.total_member_selected) AS numeric(5,2)) as risk_taking_score,team_selection.total_member_selected, true, false from member_team_selection mts inner join (select league_id, selected_team, count(*) as total_member_selected from member_team_selection where match_fixture_id = $1 group by league_id, selected_team) as team_selection on mts.league_id = team_selection.league_id AND mts.selected_team = team_selection.selected_team inner join match_fixtures mf on mf.match_fixture_id = mts.match_fixture_id inner join league l on l.league_id = mts.league_id inner join (select lm_league_id, count(*) as total_members from league_member group by lm_league_id) as league_group on league_group.lm_league_id = mts.league_id where mts.match_fixture_id = $1 RETURNING *;';

    var queryParams = [matchFixtureId];

    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else if(result){
            callback(null, result.rows);
        }
    });

};


module.exports = teamSelectionController;