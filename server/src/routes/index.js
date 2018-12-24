/*
    This file has all the api routes.
*/
module.exports = function(app){
    var authRoutes = require('./auth');
    var profileRoutes = require('./profile');

    app.use('/auth', authRoutes);
    app.use('/profile', profileRoutes);
};



