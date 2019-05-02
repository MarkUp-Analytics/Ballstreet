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
              ' where match_fixture_result_won is NULL AND match_fixture_result_draw is NULL AND match_fixture_no_result is NULL ' +
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
    
    var queryText = 'UPDATE member_team_selection SET member_team_selection_locked = true, match_result = CASE ' +
    'WHEN result.match_fixture_result_won IS NOT NULL THEN ' +
        'CASE ' +
          'WHEN  result.selected_team = result.match_fixture_result_won THEN \'W\' ELSE \'L\' ' +
      'END ' +
    'WHEN result.match_fixture_result_draw = true THEN \'D\' ' +
    'WHEN result.match_fixture_no_result = true THEN \'N\' ' +
   'END ' +
  'FROM (select mts.league_member_id, mts.match_fixture_id, mts.selected_team, mf.match_fixture_result_won, ' +
  'mf.match_fixture_result_draw, mf.match_fixture_no_result ' +
  'from member_team_selection mts inner join match_fixtures mf on mf.match_fixture_id = mts.match_fixture_id ' +
  'where mf.match_fixture_id = $1) as result';
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


module.exports = teamSelectionController;