const pool = require('../db');
const teamSelectionController = require('./teamSelectionController');

var fixturesController = {};

fixturesController.getAllMatchFixtures = function(callback){ //Method to get all active match fixtures 
    var queryText = 'select mf.match_fixture_id, t.tournament_name, t1.team_id as team_a_id, t1.team_name as team_a, t1.team_abbreviation as team_a_abbreviation, t2.team_id as team_b_id, t2.team_name as team_b, t2.team_abbreviation as team_b_abbreviation, mf.match_fixture_start_date, mf.match_fixture_end_date, mf.match_fixture_toss_time, t3.team_name as winning_team, t3.team_abbreviation as winning_team_abbreviation, mf.match_fixture_result_draw as result_draw, mf.match_fixture_no_result as no_result,s.stadium_name, s.stadium_city, s.stadium_state, s.stadium_country, s.stadium_timezone from match_fixtures mf inner join team t1 on mf.match_fixture_team_1 = t1.team_id inner join team t2 on mf.match_fixture_team_2 = t2.team_id left join team t3 on mf.match_fixture_result_won = t3.team_id inner join tournament t on mf.match_fixture_tournament_id = t.tournament_id inner join stadium s on mf.match_fixture_venue_stadium_id = s.stadium_id where mf.match_fixture_active = true AND mf.match_fixture_deleted = false AND t1.team_active = true AND t1.team_deleted = false AND t2.team_active = true AND t2.team_deleted = false AND s.stadium_active = true AND s.stadium_deleted = false';

    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        
        callback(err, result.rows);
    });
};

fixturesController.createSchedule = function(matchFixtureDetails, callback){
    
    var queryText = 'INSERT INTO match_fixtures (match_fixture_team_1, match_fixture_team_2, match_fixture_tournament_id, match_fixture_venue_stadium_id, match_fixture_start_date, match_fixture_end_date, match_fixture_toss_time, match_fixture_created_by, match_fixture_created_on, match_fixture_active, match_fixture_deleted) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING *;';

    var queryParams = [matchFixtureDetails.team1, matchFixtureDetails.team2, matchFixtureDetails.tournamentId, matchFixtureDetails.venue, matchFixtureDetails.startDate, matchFixtureDetails.endDate, matchFixtureDetails.tossTime, matchFixtureDetails.userid, new Date(), true, false];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        callback(err, result.rows[0]);
    });
};

fixturesController.checkDuplicateMatchFixture = function(matchFixtureDetails, callback){
    var queryText = 'SELECT * from match_fixtures where match_fixture_team_1 = $1 AND match_fixture_team_2 = $2 AND match_fixture_tournament_id = $3 AND match_fixture_venue_stadium_id = $4 AND match_fixture_start_date = $5 AND match_fixture_end_date = $6 AND match_fixture_toss_time = $7 AND match_fixture_active = true AND match_fixture_deleted = false';
    
    var queryParams = [matchFixtureDetails.team1, matchFixtureDetails.team2, matchFixtureDetails.tournamentId, matchFixtureDetails.venue, matchFixtureDetails.startDate, matchFixtureDetails.endDate, matchFixtureDetails.tossTime];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        var matchFixtureExist = false;
        if(result && result.rowCount == 1){
            matchFixtureExist = true;
        }
        callback(err, matchFixtureExist);
    });
};

fixturesController.getScheduleByTournamentId = function(tournamentId, callback){
    var queryText = 'select mf.match_fixture_id, t.tournament_name, t1.team_id as team_a_id, t1.team_name as team_a, t1.team_abbreviation as team_a_abbreviation, t2.team_id as team_b_id, t2.team_name as team_b, t2.team_abbreviation as team_b_abbreviation, mf.match_fixture_start_date, mf.match_fixture_end_date, mf.match_fixture_toss_time, t3.team_name as winning_team, t3.team_abbreviation as winning_team_abbreviation, mf.match_fixture_result_draw as result_draw, mf.match_fixture_no_result as no_result,s.stadium_name, s.stadium_city, s.stadium_state, s.stadium_country, s.stadium_timezone from match_fixtures mf inner join team t1 on mf.match_fixture_team_1 = t1.team_id inner join team t2 on mf.match_fixture_team_2 = t2.team_id left join team t3 on mf.match_fixture_result_won = t3.team_id inner join tournament t on mf.match_fixture_tournament_id = t.tournament_id inner join stadium s on mf.match_fixture_venue_stadium_id = s.stadium_id where mf.match_fixture_tournament_id = $1 AND mf.match_fixture_active = true AND mf.match_fixture_deleted = false AND t1.team_active = true AND t1.team_deleted = false AND t2.team_active = true AND t2.team_deleted = false AND s.stadium_active = true AND s.stadium_deleted = false';
    
    var queryParams = [tournamentId];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else{
            callback(err, result.rows);
        }
        
    });
};

fixturesController.getScheduleByMatchFixtureId = function(matchFixtureId, callback){
    var queryText = 'select mf.match_fixture_id, t.tournament_name, t1.team_id as team_a_id, t1.team_name as team_a, t1.team_abbreviation as team_a_abbreviation, t2.team_id as team_b_id, t2.team_name as team_b, t2.team_abbreviation as team_b_abbreviation, mf.match_fixture_start_date, mf.match_fixture_end_date, mf.match_fixture_toss_time, t3.team_name as winning_team, t3.team_abbreviation as winning_team_abbreviation, mf.match_fixture_result_draw as result_draw, mf.match_fixture_no_result as no_result,s.stadium_name, s.stadium_city, s.stadium_state, s.stadium_country, s.stadium_timezone from match_fixtures mf inner join team t1 on mf.match_fixture_team_1 = t1.team_id inner join team t2 on mf.match_fixture_team_2 = t2.team_id left join team t3 on mf.match_fixture_result_won = t3.team_id inner join tournament t on mf.match_fixture_tournament_id = t.tournament_id inner join stadium s on mf.match_fixture_venue_stadium_id = s.stadium_id where mf.match_fixture_id = $1 AND mf.match_fixture_active = true AND mf.match_fixture_deleted = false AND t1.team_active = true AND t1.team_deleted = false AND t2.team_active = true AND t2.team_deleted = false AND s.stadium_active = true AND s.stadium_deleted = false';
    
    var queryParams = [matchFixtureId];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else{
            callback(err, result.rows[0]);
        }
        
    });
};

fixturesController.updateMatchResult = function(matchFixtureDetails, callback){
    var queryText = 'UPDATE match_fixtures SET match_fixture_result_won = $1, match_fixture_result_draw = $2, match_fixture_no_result = $3 WHERE match_fixture_id = $4 AND match_fixture_active = true AND match_fixture_deleted = false RETURNING *';

    var queryParams = [matchFixtureDetails.winningTeam, matchFixtureDetails.resultDraw, matchFixtureDetails.noResult, matchFixtureDetails.matchFixtureId];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else{
            teamSelectionController.updateResult(result.rows[0].match_fixture_id, function(err, memberResult){
                if(err){
                    callback(err, null);
                }
                else{
                    teamSelectionController.updateStatistics(result.rows[0].match_fixture_id, function(err, statsResult){
                        if(err){
                            callback(err, null);
                        }
                        else{
                            callback(err, result.rows[0]);
                        }
                    });
                    
                }
            });
        }
        
    });
};

module.exports = fixturesController;