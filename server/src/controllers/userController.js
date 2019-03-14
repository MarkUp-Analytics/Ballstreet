const pool = require('../db');

var userController = {};

userController.getUserIDFromShortID = function(shortid, callback){
    var queryText = 'SELECT userid FROM users WHERE shortid = $1 AND active = true';
    var queryParams = [shortid];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        var userid = null;
        if(result && result.rowCount == 1){
            userid = result.rows[0].userid;
        }
        callback(err, userid);
    });
};

userController.checkUserIsAdmin = function(userid, callback){
    var queryText = 'SELECT * FROM user_roles WHERE user_id = $1 AND role_id in (3, 4) AND active = true';
    var queryParams = [userid];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        
        if(result && result.rowCount > 0){
            callback(err, true);
        }
        else{
            callback(err, false);
        }
    });
};

module.exports = userController;