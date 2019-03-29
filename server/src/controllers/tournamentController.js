const pool = require('../db');
const format = require('pg-format');

var tournamentController = {};

tournamentController.getUpcomingTours = function(callback){
    var queryText = 'SELECT sp.sport_name, sp.sport_description, t.tournament_id, t.tournament_name, t.tournament_start_date, t.tournament_end_date from sport sp INNER JOIN tournament t on t.tournament_sport_id = sp.sport_id AND t.tournament_start_date > now() AND t.tournament_active = true AND sp.sport_active = true';
    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
};

tournamentController.getOngoingTours = function(callback){
    var queryText = 'SELECT sp.sport_name, sp.sport_id, sp.sport_description, t.tournament_id, t.tournament_name, t.tournament_start_date, t.tournament_end_date from sport sp INNER JOIN tournament t on t.tournament_sport_id = sp.sport_id AND t.tournament_end_date > now() AND t.tournament_active = true AND sp.sport_active = true';
    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
};

tournamentController.getAllTours = function(callback){
    var queryText = 'SELECT * from tournament WHERE tournament_active = true AND tournament_deleted = false';
    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        
        callback(err, result.rows);
    });
};


tournamentController.getTotalGames = function(tournamentId, callback){
    // var queryText = 'select count(*) as total_games from match_fixtures where match_fixture_tournament_id = $1 AND match_fixture_active = true';
    var queryText = 'select tournament_total_games as total_games from tournament WHERE tournament_id = $1 AND tournament_active = true AND tournament_deleted = false';
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
    // var queryText = 'SELECT t1.team_name, t1.team_abbreviation FROM match_fixtures mf inner join team t1 on mf.match_fixture_team_1 = t1.team_id inner join team t2 on mf.match_fixture_team_2 = t2.team_id WHERE mf.match_fixture_tournament_id = $1 AND mf.match_fixture_active = true AND t1.team_active = true group by t1.team_name, t1.team_abbreviation union SELECT t2.team_name, t2.team_abbreviation FROM match_fixtures mf inner join team t2 on mf.match_fixture_team_2 = t2.team_id WHERE mf.match_fixture_tournament_id = $1 AND mf.match_fixture_active = true AND t2.team_active = true group by t2.team_name, t2.team_abbreviation';

    var queryText = 'SELECT t1.team_id, t1.team_name, t1.team_abbreviation, t1.team_image FROM team t1 INNER JOIN tournament_team tt ON t1.team_id = tt.tournament_name_team_id WHERE tt.tournament_name_tour_id = $1 AND t1.team_active = true AND t1.team_deleted = false'

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

tournamentController.checkDuplicateTournamentName = function(tournamentName, callback){
    var queryText = 'select * from tournament WHERE tournament_name = $1 AND tournament_active = true AND tournament_deleted = false';
    var queryParams = [tournamentName];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null)
        }
        var tourExist = false;
        if(result && result.rowCount == 1){
            tourExist = true;
        }
        callback(err, tourExist);
        
    });
};

tournamentController.createTournament = function(tourDetails, callback){
    
    var queryText = 'INSERT INTO tournament (tournament_name, tournament_sport_id, tournament_start_date, tournament_end_date, tournament_venue, tournament_created_by, tournament_created_on, tournament_total_games, tournament_image, tournament_active, tournament_deleted) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING *;';

    var queryParams = [tourDetails.tournamentName, tourDetails.sportId, tourDetails.startDate, tourDetails.endDate, tourDetails.venue, tourDetails.userid, new Date(), tourDetails.totalGames, tourDetails.tourImage,  true, false];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else{
            callback(err, result.rows[0]);
        }
        
    });
};

tournamentController.createTourTeamRelation = function(teams, tour_id, callback){
    var teamList = [];
    for(var i=0; i< teams.length; i++){
        teamList.push([
            tour_id, teams[i], true, false
        ]);
    }
    //New method to insert multiple rows
    
        var queryText = format('INSERT INTO tournament_team (tournament_name_tour_id, tournament_name_team_id, tournament_name_active, tournament_name_deleted) VALUES %L returning *', teamList);
        
        var queryParams = [];
        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err);
            }
            else{
                callback(null);
            }
        });
    
};


module.exports = tournamentController;