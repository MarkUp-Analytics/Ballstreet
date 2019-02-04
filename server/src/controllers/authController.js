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
        if(result.rowCount == 1){
            userExist = true;
        }
        callback(err, userExist);
    });
};

authController.getUser = function(email, callback){
    var queryText = 'SELECT * FROM users WHERE email = $1 AND active = true';
    var queryParams = [email];
    pool.query(queryText, queryParams, (err, result) => {
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
        
        var queryText = 'INSERT INTO users (firstname, lastname, age, sex, email, password, accountcreationdate, shortid, active, deleted) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)';
    
        var queryParams = [firstname, lastname, age, sex, email, hash, accountcreationdate, newShortid, active, deleted];

        pool.query(queryText, queryParams, (err, result) => {
            callback(err, result);
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
                        userid: user.userID,
                        email: user.email,
                        age: user.age,
                        sex: user.sex,
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
module.exports = authController;