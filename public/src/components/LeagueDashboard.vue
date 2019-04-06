<template>
<div>
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
                            <br>
                            <label v-if="userIsLeagueMember" for="FormControlGamePin" class="mb-2 text-violet font-weight-bold">PIN: {{league.league_pin}}</label>
                            <input v-if="!userIsLeagueMember" type="password" class="form-control form-control-md rounded-1 w-100 mb-3" id="GamePin" v-model="leaguePin" aria-describedby="emailHelp" placeholder="Game Pin">
                            <button v-if="!userIsLeagueMember" @click.prevent="joinLeague()" class="btn btn-dark bg-violet rounded-1 w-100">Join League</button>
                        </form>
                    </div>
                </div>    
            </div>
        </div>
        <div class="p-5 mx-auto text-center bg-white">
            <div v-if="!userIsLeagueMember" class="container">
                <h1 class="text-violet mt-1 mb-3">Team List</h1>
                <div class="row my-4">
                    <div class="col-lg my-4">
                        
                    </div>
                    <div class="col-lg my-4">
                            <div v-for="(team, $index) in teams" :key="team.team_id">
                                <div class="card bg-white" style="cursor:pointer">
						            <div class="card-body">
                                        <div>
                                            <span>
                                                <img style="float:left" :src="team.team_image" width="30px" height="30px"/>
                                            </span>
                                            <span>
                                                {{team.team_abbreviation}}
                                            </span>
                                            <span class="badge">{{$index+1}}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="col-lg my-4">
                        
                    </div>
                    
                </div>              
            </div>
            <div v-if="userIsLeagueMember" class="container">
                <h1  class="text-violet mt-1 mb-3">Team Preference</h1>
                <div class="row my-4">
                    <div class="col-lg my-4">
                        
                    </div>
                    <div class="col-lg my-4">
                        <draggable v-model="teamPreferenceList" :options="{animation:150}" @start="drag=true" @end="drag=false" @change="updatePreference()">
                             <transition-group type="transition" name="flip-list">
                            <div v-for="team in teamPreferenceList" :key="team.team_id">
                                <div class="card bg-white" style="cursor:pointer">
						            <div class="card-body">
                                        <div>
                                            <span>
                                                <img style="float:left" :src="team.team_image" width="30px" height="30px"/>
                                            </span>
                                            <span>
                                                {{team.team_abbreviation}}
                                            </span>
                                            <span class="badge">{{team.preference_rank}}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </transition-group>
                        </draggable>
                    </div>
                    <div class="col-lg my-4">
                        
                    </div>
                    
                </div>              
            </div>
        </div>
    </div>
</template>

<script>
import api from '@/services/api';
import LoadingSpinner from '@/components/LoadingSpinner';
import draggable from 'vuedraggable';
export default {
    name: 'LeagueDashboard',
    components:{
        draggable,
        LoadingSpinner
    },
    created() {
        if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
                
            }
        if(this.$route.params.league){
                this.league = this.$route.params.league;
                this.displayLeaguePin();
                this.getTournamentDetails(this.league.league_tournament_id);
                this.getPlayingTeams(this.league.league_tournament_id);
                this.getTotalGames(this.league.league_tournament_id);
                this.showDetails = true;
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
        getTeamPreference: function(){ //Method to get team preference if the user is a league member
            var self = this;
            this.showLoadingIcon = true;
                api().get('/league/getTeamPreference', {
                    params: {
                            leagueMemberId: this.league.league_member_id,
                            leagueId: this.league.league_id,
                            userId: this.userDetails.userid
                        }
                }).then(result => {
                        self.showLoadingIcon = false;
                        self.teamPreferenceList = result.data.teamPreference;
                        self.teamPreferenceList.sort((a, b) => (b.preference_rank < a.preference_rank) ? 1 : -1);
                    },
                    err => {
                        self.showLoadingIcon = false;
                        if(err.response.data.message){
                            self.errors.push(err.response.data.message);
                        }
                        else{
                            self.errors.push("Error getting team preference");
                        }
                    })
        },

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
                            self.getTeamPreference();
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
            updatePreference: function(){
                for(var i=0; i<this.teamPreferenceList.length; i++){
                    this.teamPreferenceList[i].preference_rank = i+1;
                }

                this.showLoadingIcon = true;
                var formData = {};
                formData.preferences = this.teamPreferenceList;
                formData.userId = this.userDetails.userid;
                formData.leagueId = this.league.league_id;
                formData.leagueMemberId = this.league.league_member_id;

                api().post('/league/updateTeamPreference/', formData).then(result => {
                        this.showLoadingIcon = false;
                        this.teamPreferenceList = result.data.teamPreference;
                        this.teamPreferenceList.sort((a, b) => (b.preference_rank < a.preference_rank) ? 1 : -1); 
                    },
                    err => {
						this.errors = [];
						this.showLoadingIcon = false;
                        this.errors.push(err.response.data.message);
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