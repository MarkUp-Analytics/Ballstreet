/*
    This file has all the api routes.
*/
module.exports = function(app){
    var authRoutes = require('./auth');
    var profileRoutes = require('./profile');
    var tournamentRoutes = require('./tournament');
    var leagueRoutes = require('./league');
    var sportRoutes = require('./sport');
    var teamRoutes = require('./team');

    app.use('/auth', authRoutes);
    app.use('/profile', profileRoutes);
    app.use('/tournament', tournamentRoutes);
    app.use('/league', leagueRoutes);
    app.use('/team', teamRoutes);
    app.use('/sport', sportRoutes);
};



