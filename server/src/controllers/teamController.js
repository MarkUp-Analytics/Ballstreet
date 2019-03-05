const pool = require('../db');

var teamController = {};

teamController.getTeamsList = function(callback){
    var queryText = 'SELECT * from team WHERE team_active = true and team_deleted = false;';

    var queryParams = [];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        callback(err, result);
    });
};

teamController.createTeam = function(userid, teamDetails, callback){
    
    var queryText = 'INSERT INTO team (team_name, team_abbreviation, team_image,  team_active, team_deleted) VALUES ($1, $2, $3, $4, $5) RETURNING *;';

    var queryParams = [teamDetails.team_name, teamDetails.team_abbreviation, teamDetails.team_image, true, false];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        callback(err, result.rows[0]);
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