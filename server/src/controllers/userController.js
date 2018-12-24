const pool = require('../db');

var userController = {};

userController.getUserIDFromShortID = function(shortid, callback){
    var queryText = 'SELECT userid FROM users WHERE shortid = $1 AND active = true';
    var queryParams = [shortid];
    pool.query(queryText, queryParams, (err, result) => {
        var userid = null;
        if(result.rowCount == 1){
            userid = result.rows[0];
        }
        callback(err, userid);
    });
}

module.exports = userController;