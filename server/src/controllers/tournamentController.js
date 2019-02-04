const pool = require('../db');

var tournamentController = {};

tournamentController.getUpcomingTours = function(callback){
    var queryText = 'SELECT sp.sport_name, sp.sport_description, t.tournament_id, t.tournament_name, t.tournament_start_date, t.tournament_end_date from sport sp INNER JOIN tournament t on t.tournament_sport_id = sp.sport_id AND t.tournament_start_date > now() AND t.tournament_active = true AND sp.sport_active = true';
    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
};

tournamentController.getTotalGames = function(tournamentId, callback){
    var queryText = 'select count(*) as total_games from match_fixtures where match_fixture_tournament_id = $1 AND match_fixture_active = true';
    var queryParams = [tournamentId];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null)
        }
        else{
            callback(err, result.rows[0]);
        }
        
    });
};

tournamentController.getTournamentByID = function(tournamentId, callback){
    var queryText = 'select *  from tournament where tournament_id = $1 AND tournament_active = true';
    var queryParams = [tournamentId];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null)
        }
        else{
            callback(err, result.rows);
        }
        
    });
};

tournamentController.getTournamentByNameAndSportId = function(tournamentName, sportId, callback){
    var queryText = 'select t.*, s.sport_name from tournament t inner join sport s on t.tournament_sport_id = s.sport_id where tournament_sport_id = $1 AND LOWER(tournament_name) like LOWER($2) AND tournament_active = true';
    var queryParams = [sportId, '%' + tournamentName + '%'];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null)
        }
        else{
            callback(err, result.rows);
        }
        
    });
};

tournamentController.getPlayingTeamsByTournamentId = function(tournamentId, callback){
    var queryText = 'SELECT t1.team_name, t1.team_abbreviation FROM match_fixtures mf inner join team t1 on mf.match_fixture_team_1 = t1.team_id inner join team t2 on mf.match_fixture_team_2 = t2.team_id WHERE mf.match_fixture_tournament_id = $1 AND mf.match_fixture_active = true AND t1.team_active = true group by t1.team_name, t1.team_abbreviation union SELECT t2.team_name, t2.team_abbreviation FROM match_fixtures mf inner join team t2 on mf.match_fixture_team_2 = t2.team_id WHERE mf.match_fixture_tournament_id = $1 AND mf.match_fixture_active = true AND t2.team_active = true group by t2.team_name, t2.team_abbreviation';

    var queryParams = [tournamentId];

    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null)
        }
        else{
            callback(err, result.rows);
        }
        
    });
};

module.exports = tournamentController;