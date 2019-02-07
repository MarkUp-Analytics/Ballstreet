<template>
<div>
        <div class="p-5 mx-auto text-center bg-light">
            <div class="container">
                <h1 class="text-violet mt-1 mb-5">Dashboard</h1>
                <div v-if="showDetails" class="row text-left">
                    <div class="col-lg-9">
                        <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px"/>
                        <h4 class="mb-2"><span class="text-violet">{{details ? details.tournament_name : ''}}</span> | <span class="text-violet">Cricket</span></h4>
                        <h5 class="mb-4">{{teamString}}</h5>
                        <div class="row">
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-calendar-day text-violet"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-violet">Dates</span><br/>
                                        <span>{{details ? details.tournament_start_date : '' | formatDate}} to {{details ? details.tournament_end_date : '' | formatDate}}</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-id-badge text-violet"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-violet">Admin</span><br/>
                                        <span>{{league.league_created_by}}</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-glass-cheers text-violet"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-violet"># Players</span><br/>
                                        <span>{{league.league_total_members}}</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-credit-card text-violet"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-violet">Value</span><br/>
                                        <span>{{league.league_minimum_bet}}</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-sitemap text-violet"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-violet"># Games</span><br/>
                                        <span>{{totalGames}}</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr class="d-md-none mt-5 mb-5"/>
                    </div>

                    <div class="col-lg-3 text-center">
                        <form class="py-5">
                            <label for="FormControlGamePin" class="mb-2 text-violet font-weight-bold">GAME ID: {{league.league_shortid}}</label>
                            <label v-if="showLeaguePin" for="FormControlGamePin" class="mb-2 text-violet font-weight-bold">PIN: {{league.league_pin}}</label>
                            <input v-if="!showLeaguePin" type="Text" class="form-control form-control-md rounded-1 w-100 mb-3" id="GamePin" aria-describedby="emailHelp" placeholder="Game Pin">
                            <button v-if="!showLeaguePin" type="submit" class="btn btn-dark bg-violet rounded-1 w-100">Enter</button>
                        </form>
                    </div>
                </div>    
            </div>
        </div>
        <!-- <div class="p-5 mx-auto text-center bg-white">
            <div class="container">
                <h1 class="text-violet mt-1 mb-3">Overview</h1>
                <div class="row my-4">
                    <div class="col-lg my-3">
                        <i class="fas fa-dice-d6 text-yellow fa-4x"></i>
                    </div>
                    <div class="col-lg my-3">
                        <span class="text-secondary">Contribution, INR</span><br/>
                        <h3>450.00</h3>
                    </div>
                    <div class="col-lg my-3">
                        <span class="text-secondary">Curr. Value, INR</span><br/>
                        <h3>652.69</h3>
                    </div>
                    <div class="col-lg my-3">
                        <span class="text-secondary">P&L</span><br/>
                        <h3 class="text-success">45.04%</h3>
                    </div>
                </div>              
            </div>
        </div> -->
    </div>
</template>

<script>
import api from '@/services/api';
import LoadingSpinner from '@/components/LoadingSpinner';
export default {
    name: 'LeagueDashboard',
    created() {
        if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
                
            }
        if(this.$route.params != null){
                this.league = this.$route.params.league;
                this.displayLeaguePin();
                this.getTournamentDetails(this.league.league_tournament_id);
                this.getPlayingTeams(this.league.league_tournament_id);
                this.getTotalGames(this.league.league_tournament_id);
                this.showDetails = true;
            }
    },
    data(){
        return {
            userDetails: null,
            teamString: null,
            showLoadingIcon: false,
            showLeaguePin: false,
            showDetails: false,
            league: null,
            details: null,
            teams: null,
            totalGames: null,
            errors: []
        }
    },
    methods:{
        displayLeaguePin: function(){ //Method to display league pin if the user is part of the league.
            this.showLoadingIcon = true;
                api().get('/league/memberInLeague', {
                    params: {
                            userId: this.userDetails.userid,
                            leagueId: this.league.league_id
                        }
                }).then(result => {
                    this.showLoadingIcon = false;
                        this.showLeaguePin = result.data.memberBelongsToLeague;
                    },
                    err => {
                        this.showLoadingIcon = false;
                        if(err.response.data.message){
                            this.errors.push(err.response.data.message);
                        }
                        else{
                            this.errors.push("Error getting league details");
                        }
                    })
        },
        getTournamentDetails: function(tournamentID){
            this.showLoadingIcon = true;
                api().get('/tournament/tournamentDetails',{
                    params: {
                        tournamentId: tournamentID
                    }
                }).then(result => {
                        this.showLoadingIcon = false;
                        this.details = result.data.tournament;
                    },
                    err => {
                        this.showLoadingIcon = false;
                        if (err.response.data.message) {
                            this.errors.push(err.response.data.message);
                        } else {
                            this.errors.push("Error getting tournament details");
                        }
                    })
            },
        getPlayingTeams: function(tournament_id) {
                this.showLoadingIcon = true;
                api().get('/tournament/playingTeams', {
                    params: {
                        tournamentId: tournament_id
                    }
                }).then(result => {
                        this.showLoadingIcon = false;
                        this.teams = result.data.teams;
                        this.teamString = result.data.teams.map(function(elem) {
                            return elem.team_abbreviation;
                        }).join(", ");
                    },
                    err => {
                        this.showLoadingIcon = false;
                        if (err.response.data.message) {
                            this.errors.push(err.response.data.message);
                        } else {
                            this.errors.push("Error searching");
                        }
                    })
            },

            getTotalGames: function(tournamentID){
                api().get('/tournament/totalGames',{
                    params: {
                        tournamentID: tournamentID
                    }
                }).then(result => {
                        this.totalGames = result.data.totalGames;
                    },
                    err => {
                        console.log(err)
                    })
            },
    }
}
</script>

<style>

</style>