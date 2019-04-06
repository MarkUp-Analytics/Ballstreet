const bcrypt = require('bcryptjs');
const saltRounds = 8;
const shortid = require('shortid');
const pool = require('../db');

var authController = {};

authController.userExist = function(email, callback){
    var queryText = 'SELECT 1 FROM users WHERE email = $1 AND active = true';
    var queryParams = [email];
    pool.query(queryText, queryParams, (err, result) => {
        var userExist = false;
        if(err){
            callback(err, userExist);
        }
        if(result && result.rowCount == 1){
            userExist = true;
        }
        callback(err, userExist);
    });
};

authController.getUser = function(email, callback){
    var queryText = 'SELECT * FROM users WHERE email = $1 AND active = true';
    var queryParams = [email];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        var userDetails = {};
        if(result.rowCount == 1){
            userDetails = result.rows[0];
        }
        callback(err, userDetails);
    });
}

authController.createUser = function(newUserDetails, callback){
    var firstname = newUserDetails.firstname;
    var lastname = newUserDetails.lastname;
    var age = newUserDetails.age;
    var sex = newUserDetails.sex;
    var email = newUserDetails.email;
    var password = newUserDetails.password;
    var accountcreationdate = new Date();
    var newShortid = shortid.generate();
    var active = true;
    var deleted = false;
    
    bcrypt.hash(password, saltRounds, function(err, hash) {
        
        var queryText = 'INSERT INTO users (firstname, lastname, age, sex, email, password, accountcreationdate, shortid, active, deleted) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING *;';
    
        var queryParams = [firstname, lastname, age, sex, email, hash, accountcreationdate, newShortid, active, deleted];

        pool.query(queryText, queryParams, (err, result) => {
            if(err){
                callback(err, null);
            }
            else if(result){
                callback(null, result.rows[0]);
            }
            
        });
    });
};

authController.comparePassword = function(userDetails, callback){
    authController.getUser(userDetails.username, function(err, user){
        if(user && user.userid){
            bcrypt.compare(userDetails.password, user.password, function(err, res){
                if(err){ //Issue checking the password.
                    callback(err, null);
                }
                if(res){ //hash and user entered password matches.
                    var userInfo = {
                        firstname: user.firstname,
                        lastname: user.lastname,
                        userid: user.userid,
                        email: user.email,
                        accountcreationdate: user.accountcreationdate,
                        shortid: user.shortid
                    }
                    callback(err, userInfo);
                }
                else if(!res){ //hash and user enterd password did not match.
                    var error = {
                        message: "Password did not match"
                    }
                    callback(error, null);
                }
            })
        }
        else{
            var error = {
                message: "Unable to get user"
            }
            callback(error, null);
        }
    })
};

authController.getUserRole = function(userid, callback){
    var queryText = 'select ur.user_id, r.role_id, r.role_name from user_roles ur inner join roles r on r.role_id = ur.role_id where ur.user_id = $1 AND ur.active = true and ur.deleted = false';
    var queryParams = [userid];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        callback(err, result.rows[0]);
    });
};

authController.createUserRole = function(userid, callback){
    var queryText = 'INSERT INTO user_roles (user_id, role_id, active, deleted) VALUES ($1, 1, true, false)  RETURNING *;';
    var queryParams = [userid];
    pool.query(queryText, queryParams, (err, result) => {
        if(err){
            callback(err, null);
        }
        else if(result){
            authController.getUserRole(result.rows[0].user_id, function(err, userRole){
                if(err){
                    callback(err, null);
                }
                else if(userRole){
                    callback(null, userRole.role_name);
                }
                
            });
        }
        
        
    });
};
module.exports = authController;