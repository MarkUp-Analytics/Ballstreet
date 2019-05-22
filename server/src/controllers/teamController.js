const pool = require('../db');

var teamController = {};

teamController.getTeamsList = function(callback){
    var queryText = 'SELECT * from team WHERE team_active = true and team_deleted = false;';

    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        
        callback(err, result.rows);
    });
};

teamController.createTeam = function(teamDetails, callback){
    
    var queryText = 'INSERT INTO team (team_name, team_abbreviation, team_image, team_created_by, team_created_on, team_active, team_deleted) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *;';

    var queryParams = [teamDetails.team_name, teamDetails.team_abbreviation, teamDetails.team_image, teamDetails.userid, new Date(), true, false];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        callback(err, result.rows[0]);
    });
};

teamController.updateTeamWithImage = function(teamDetails, callback){
    
    var queryText = 'UPDATE team set team_name = $2, team_abbreviation = $3, team_image = $4 where team_id = $1 RETURNING *;';

    var queryParams = [teamDetails.team_id, teamDetails.team_name, teamDetails.team_abbreviation, teamDetails.team_image];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        callback(err, result.rows[0]);
    });
};

teamController.updateTeamWithoutImage = function(teamDetails, callback){
    
    var queryText = 'UPDATE team set team_name = $2, team_abbreviation = $3 where team_id = $1 RETURNING *;';

    var queryParams = [teamDetails.team_id, teamDetails.team_name, teamDetails.team_abbreviation];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else{
            callback(err, result.rows[0]);
        }
        
    });
};

teamController.checkDuplicateTeamName = function(team_name, callback){
    var queryText = 'SELECT * from team where team_name = $1 AND team_active = true AND team_deleted = false';
    
    var queryParams = [team_name];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        var teamExist = false;
        if(result && result.rowCount == 1){
            teamExist = true;
        }
        callback(err, teamExist);
    });
};

module.exports = teamController;