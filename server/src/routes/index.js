/*
    This file has all the api routes.
*/
module.exports = function(app){
    var authRoutes = require('./auth');

    app.use('/auth', authRoutes);
};



