<template>
<div>
        <member-menu :league="$route.query.league" :memberInLeague="userIsLeagueMember"></member-menu>
        <div class="p-5 mx-auto text-center bg-light">
            <div class="container">
                <h1 class="text-violet mt-1 mb-5">Dashboard</h1>
                <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100" role="alert">
                            <span v-for="error in errors">
                                <strong>Error!</strong> {{error}}
                            </span>
                            <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    <loading-spinner v-if="showLoadingIcon"></loading-spinner>
                <div v-if="showDetails" class="row text-left">
                    <div class="col-lg-9">
                        <img :src="details.tournament_image" class="rounded border mb-2" width="50px" height="50px"/>
                        <h4 class="mb-2"><span class="text-violet">{{details ? details.tournament_name : ''}}</span> | <span class="text-violet">Cricket</span></h4>
                        <h5 class="mb-4">{{teamString}}</h5>
                        <div class="row">
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-calendar-day text-secondary"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-secondary">Dates</span><br/>
                                        <span>{{details ? details.tournament_start_date : '' | formatDate}} to {{details ? details.tournament_end_date : '' | formatDate}}</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-id-badge text-secondary"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-secondary">Admin</span><br/>
                                        <span>{{league.league_created_by}}</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-glass-cheers text-secondary"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-secondary"># Players</span><br/>
                                        <span>{{league.league_total_members}}</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-credit-card text-secondary"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-secondary">Value</span><br/>
                                        <span>{{league.league_minimum_bet}}</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-sitemap text-secondary"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-secondary"># Games</span><br/>
                                        <span>{{totalGames}}</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr class="d-md-none mt-5 mb-5"/>
                    </div>

                    <div class="col-lg-3 text-center">
                        <form class="py-5">
                            <h5 for="FormControlGamePin" class="mb-2 text-secondary">Game ID: <span class="mb-2 text-violet">{{league.league_shortid}}</span></h5>
                            <h5 v-if="userIsLeagueMember" for="FormControlGamePin" class="mb-2 text-secondary">PIN: <span class="mb-2 text-violet">{{league.league_pin}}</span></h5>
                            <div v-if="userIsLeagueMember" >
                                <span class="text-secondary" style="font-size:smaller">Share Game ID and Pin to your friends to join the league</span>
                            </div>
                            <input v-if="!userIsLeagueMember" type="password" class="form-control form-control-md rounded-1 w-100 mb-3" id="GamePin" v-model="leaguePin" aria-describedby="emailHelp" placeholder="Game Pin">
                            <button v-if="!userIsLeagueMember" @click.prevent="joinLeague()" class="btn btn-dark bg-violet rounded-1 w-100">Join League</button>
                            <div v-if="!userIsLeagueMember" >
                                <span class="text-secondary" style="font-size:smaller">Enter Game Pin to join the league</span>
                            </div>
                        </form>
                    </div>
                </div>    
            </div>
        </div>
    </div>
</template>

<script>
import api from '@/services/api';
import LoadingSpinner from '@/components/LoadingSpinner';
import MemberMenu from '@/components/MemberMenu';
import draggable from 'vuedraggable';
export default {
    name: 'LeagueDashboard',
    components:{
        draggable,
        LoadingSpinner,
        MemberMenu
    },
    created() {
        var self = this;
        if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
                
            }
        if(this.$route.query.league){
                self.showLoadingIcon = true;
                api().get('/league/getLeague', {
                    params:{
                        leagueShortId: this.$route.query.league
                    }
                }).then(result =>{
                    self.showLoadingIcon = false;
                    self.league = result.data.league;
                    self.displayLeaguePin();
                    self.getTournamentDetails(self.league.league_tournament_id);
                    self.getPlayingTeams(self.league.league_tournament_id);
                    self.getTotalGames(self.league.league_tournament_id);
                    self.showDetails = true;
                },
                err =>{
                    self.errors = [];
                    self.showLoadingIcon = false;
                    if(err.response.data.message){
                        self.errors.push(err.response.data.message);
                    }
                    else{
                        self.errors.push("Error getting league details");
                    }
                })
                
                
            }
            else{
                this.$router.push({
                    name: 'Home',
				});
            }
    },
    data(){
        return {
            userDetails: null,
            teamString: null,
            showLoadingIcon: false,
            userIsLeagueMember: false,
            showDetails: false,
            league: null,
            leaguePin: null,
            details: null,
            teams: null,
            teamPreferenceList: null,
            totalGames: null,
            errors: []
        }
    },
    methods:{
        displayLeaguePin: function(){ //Method to display league pin if the user is part of the league.
            var self = this;
            this.showLoadingIcon = true;
                api().get('/league/memberInLeague', {
                    params: {
                            userId: this.userDetails.userid,
                            leagueId: this.league.league_id
                        }
                }).then(result => {
                        self.showLoadingIcon = false;
                        self.userIsLeagueMember = result.data.memberBelongsToLeague;
                        if(self.userIsLeagueMember){
                            self.getLeagueMemberId(self.userDetails.userid, self.league.league_id);
                        }
                        
                    },
                    err => {
                        self.showLoadingIcon = false;
                        if(err.response.data.message){
                            self.errors.push(err.response.data.message);
                        }
                        else{
                            self.errors.push("Error getting league details");
                        }
                    })
        },
        getLeagueMemberId: function(userId, leagueId){
            var self = this;
            this.showLoadingIcon = true;
            api().get('/league/getLeagueMemberId',{
                params: {
                    userId: userId,
                    leagueId: leagueId
                }
            }).then(result => {
                    self.showLoadingIcon = false;
                    self.league.league_member_id = result.data.leagueMemberId;
                },
                err => {
                    self.showLoadingIcon = false;
                    if (err.response.data.message) {
                        self.errors.push(err.response.data.message);
                    } else {
                        self.errors.push("Error getting league member ID");
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
            joinLeague: function(){
                this.errors = [];
                if(!this.leaguePin){
                    this.errors.push("Required field(s) are missing");
                    return;
                }
                this.showLoadingIcon = true;
                
                var formData = {};
                formData.userid = this.userDetails.userid;
                formData.leagueId = this.league.league_id;
                formData.tournamentId = this.league.league_tournament_id;
                formData.leaguePin = this.leaguePin;

                api().post('/league/joinLeague', formData).then(result => {
                        this.showLoadingIcon = false;
                        this.userIsLeagueMember = true;
                        this.teamPreferenceList = result.data.teamPreference;
                        this.teamPreferenceList.sort((a, b) => (b.preference_rank < a.preference_rank) ? 1 : -1); 
                    },
                    err => {
						this.errors = [];
						this.showLoadingIcon = false;
                        this.errors.push(err.response.data.message);
                    })


            },
    }
}
</script>

<style>
.badge{
    display: inline-block;
    min-width: 10px;
    padding: 3px 7px;
    font-size: 12px;
    font-weight: bold;
    line-height: 1;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    background-color: #777;
    border-radius: 10px;
    float: right;
}

.flip-list-move {
  transition: transform 0.5s;
}
.no-move {
  transition: transform 0s;
}

</style>