<template>
<div>
        <member-menu :league="$route.query.league" :memberInLeague="userIsLeagueMember"></member-menu>
        <div class="mx-auto text-center bg-light" id="update-preferences">
            <div class="container">
                <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100" role="alert">
                            <span v-for="error in errors">
                                <strong>Error!</strong> {{error}}
                            </span>
                            <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    <loading-spinner v-if="showLoadingIcon"></loading-spinner>
            </div>
        </div>
        <div class="p-5 mx-auto text-center bg-light">
            <div v-if="userIsLeagueMember" class="container">
                <h1 class="text-violet mt-3">Team Preference</h1>
                <h6 class="text-secondary">Drag the teams to the order of your preferences - All upcoming game selections will be basis your preference list</h6>
                <a href="" v-scroll-to="'#upcoming-games'" class="text-violet mb-3"><h6 class="mt-1 mb-5">To override the preferences list, for the upcoming games, click here</h6></a>
                <div class="row my-4">
                    <div class="col-lg my-4">
                    </div>
                    <div class="col-lg my-4">
                        <draggable v-model="teamPreferenceList" :options="{animation:150}" @start="drag=true" @end="drag=false" @change="updatePreference()">
                             <transition-group type="transition" name="flip-list">
                            <div v-for="team in teamPreferenceList" :key="team.team_id">
                                <table class='table bg-white rounded-lg border table-borderless' style="height:50px; cursor:pointer"> 
                                    <tbody> 
                                        <tr> 
                                            <td class="align-middle text-center" width="33.33%" scope="col"> 
                                                <img style=" " :src="team.team_image" width="30px" height="30px"/>
                                            </td> 
                                            <td class="align-middle text-center" width="33.33%" scope="col"> 
                                                <h5>{{team.team_abbreviation}}</h5>
                                            </td> 
                                            <td class="align-middle text-center" width="33.33%" scope="col"> 
                                                <h6>#{{team.preference_rank}}</h6>
                                            </td>
                                        </tr> 
                                    </tbody> 
                                </table>
                            </div>
                            </transition-group>
                        </draggable>
                    </div>
                    <div class="col-lg my-4">
                        
                    </div>
                    
                </div>              
            </div>
        </div>
        <div class="p-5 mx-auto text-center bg-white" id="upcoming-games">
            <div class="container pb-5">
                <h3 class="text-violet mt-3 mb-1">Upcoming Games</h3>
                <h6 class="mt-1 mb-5">
                    <a href="" @click.prevent="limitGames=3" v-if="totalGames >= 3" class="text-violet mx-2">3 Games</a> <a href="" @click.prevent="limitGames = 5" v-if="totalGames >= 5" class="text-violet mx-2">5 Games</a> <a href="" @click.prevent="limitGames = 7" v-if="totalGames >= 7" class="text-violet mx-2">7 Games</a> <a href="" @click.prevent="limitGames = 14" v-if="totalGames >= 14" class="text-violet mx-2">14 Games</a>
                </h6>
                
                <div class="card-columns">
					<div v-for="game in games.slice(0, limitGames)" class="card bg-white">                        
                        <div class="card-header bg-none">
                            {{getTeamFromGlobalList(game.team_1_id).team_abbreviation}} vs {{getTeamFromGlobalList(game.team_2_id).team_abbreviation}}
                        </div>
						<div class="card-body">                       
							<div class="text-left p-1">
                                <div class="form-group">
                                    <div v-if="game.errors.length" class="alert alert-danger alert-dismissible fade show w-100" role="alert">
                                        <span v-for="error in game.errors">
                                            <strong>Error!</strong> {{error}}
                                        </span>
                                        <button type="button" class="close" data-dismiss="alert" @click="game.errors = [];" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div v-if="game.success.length" class="alert alert-success alert-dismissible fade show w-100" role="alert">
                                        <span v-for="success in game.success">
                                            <strong>Success!</strong> {{success}}
                                        </span>
                                        <button type="button" class="close" data-dismiss="alert" @click="game.success = [];" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>                                     
                                </div>                                
                                <div class="form-group mt-2">
                                    <label>
                                        <span class="text-secondary">Date:<br/></span>{{getDate(game.match_fixture_start_date, game.stadium_timezone) | formatDate}} {{" " + game.match_fixture_toss_time}} 
                                    </label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>
                                        <span class="text-secondary">Time left:<br/></span>{{getRemainingTime(game.match_fixture_start_date, game.match_fixture_toss_time, game.stadium_timezone)}}
                                    </label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>
                                        <span class="text-secondary">Venue:<br/></span>{{game.stadium_name}}
                                    </label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>
                                        <span class="text-secondary">Preference:</span></label>
                                    <v-select v-model="game.selected_team_model" :options="game.teamList" 
                                        item-value="team_id"
                                        item-text="team_abbreviation"
                                        label="team_abbreviation">
                                    </v-select>
                                </div>
                                <div class="form-group mt-2">
                                    <small>
                                        <span class="text-secondary">Note:<br/></span>Override is applicable only for this game.<br/>
                                        <a href="" v-scroll-to="'#update-preferences'" class="text-violet">To update the master list of preferences for all upcoming games, click here.</a>
                                    </small>
                                </div>
                                <div class="row">
                                    <div class="col-lg mt-4">
                                        <a href="" @click.prevent="updateSinglePreference(game)" class="btn btn-dark bg-violet border-0 w-100">Save</a><br/>
                                    </div>
                                </div>
                                <div class="row text-center">
                                    <div class="col-lg mt-2">
                                        <a href="" class="text-violet mt-5">Cancel</a>
                                    </div>
                                </div>
							</div>
						</div>
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
import moment from 'moment-timezone';
export default {
    name: 'LeaguePreferences',
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
                    self.getPlayingTeams(self.league.league_tournament_id);
                    self.memberBelongsToLeague();
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
            showLoadingIcon: false,
            userIsLeagueMember: false,
            league: null,
            games: [],
            totalGames: 0,
            limitGames: 0,
            teamPreferenceList: null,
            teamsInTournamentList: [],
            errors: []
        }
    },
    methods:{
        getDate: function(date, timeZone){
            var dateObj = new Date(new Date(date).toLocaleString("en-US", {timeZone: timeZone}));
            return dateObj;
            },
        getSeconds: function(date, hr, timeZone){
            var now = moment().tz(timeZone).format('YYYY/MM/DD HH:mm:ss'); //todays date
            var end = moment.tz(moment(date), timeZone).format('YYYY/MM/DD') + " " + hr; // match start date
            
            var duration = moment.duration(moment(end).diff(moment(now)));
            
            var seconds = (Math.floor(duration.asSeconds()));

            return seconds;
            

        },
        
        getRemainingTime: function(date, hr, timeZone){

            var seconds = this.getSeconds(date, hr, timeZone);
            
            var days        = Math.floor(seconds/24/60/60);
            var hoursLeft   = Math.floor((seconds) - (days*86400));
            var hours       = Math.floor(hoursLeft/3600);
            var minutesLeft = Math.floor((hoursLeft) - (hours*3600));
            var minutes     = Math.floor(minutesLeft/60);
            var remainingSeconds = seconds % 60;

            function pad(n) {
                return (n < 10 ? "0" + n : n);
            }

            if (seconds <= 0) {
                return "Completed";
            }else {
                return (pad(days) + "Days:" + pad(hours) + "Hr:" + pad(minutes) + "Min:" + pad(remainingSeconds) + "Sec");
            }
        },

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

        getPlayingTeams: function(tournamentId){
                this.errors = [];
                this.teamsInTournamentList = [];
                var self = this;
                api().get('/tournament/playingTeams', {
                        params: {
                            tournamentId: tournamentId
                        }
                }).then(result => {
                        self.teamsInTournamentList = result.data.teams;
                    },
                    err => {
                        this.errors = [];
                        this.errors.push(err.response.data.message);
                    })
                
        },
        getTeamFromGlobalList: function(teamId){
            return this.teamsInTournamentList.find(team=>{
                return team.team_id === teamId;
            });
        },
        getAllAvailableGames: function(){ //Method to get all games which are not yet started/finished.
            var self = this;
            this.showLoadingIcon = true;
                api().get('/league/getAllAvailableGames', {
                    params: {
                            leagueMemberId: this.league.league_member_id,
                            leagueId: this.league.league_id,
                            userId: this.userDetails.userid
                        }
                }).then(result => {
                        self.showLoadingIcon = false;
                        if(result.data.games.length > 0){
                            result.data.games.filter(game=>{
                                game.teamList = [];
                                game.errors = [];
                                game.success = [];
                                game.teamList.push(self.getTeamFromGlobalList(game.team_1_id));
                                game.teamList.push(self.getTeamFromGlobalList(game.team_2_id));
                                game.selected_team_model = self.getTeamFromGlobalList(game.selected_team_id);
                            });
                        }
                        self.games = result.data.games.sort(function(a,b){
                                return new Date(a.match_fixture_start_date) - new Date(b.match_fixture_start_date);
                        });
                        self.totalGames = result.data.games.length;
                        if(self.totalGames >= 3){
                            self.limitGames = 3; //by default we show 3 games
                        }
                        else{
                            self.limitGames = self.totalGames;
                        }
                    },
                    err => {
                        self.showLoadingIcon = false;
                        if(err.response.data.message){
                            self.errors.push(err.response.data.message);
                        }
                        else{
                            self.errors.push("Error getting available games for the tournament");
                        }
                    })
        },

        memberBelongsToLeague: function(){ //Method to check if the user is part of the league.
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
                        else{
                            //send to dashboard
                            self.$router.push({
                                name: 'LeagueDashboard',
                                query:{
                                    league: self.league.league_shortid
                                }
				            });
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
                    if(self.userIsLeagueMember){
                        self.getTeamPreference();
                        
                        self.getAllAvailableGames();
                    }
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
        canUpdatePreference: function(game){
            var date = game.match_fixture_start_date;
            var hr = game.match_fixture_toss_time;
            var timeZone = game.stadium_timezone;

            var seconds = this.getSeconds(date, hr, timeZone);
            
            if(seconds <= 0){
                return false;
            }
            else{
                return true;
            }
        },
        updateSinglePreference: function(game){
            if(!game.selected_team_model){
                game.errors = [];
                game.errors.push("Select a team to update your preference");
                return;
            }
            if(!this.canUpdatePreference(game)){
                game.errors = [];
                game.errors.push("Game has already started. Your preference is locked.");
                return;
            }
            this.showLoadingIcon = true;
            var formData = {};
            formData.userId = this.userDetails.userid;
            formData.leagueId = this.league.league_id;
            formData.leagueMemberId = this.league.league_member_id;
            formData.matchFixtureId = game.match_fixture_id;
            formData.selectedTeamId = game.selected_team_model.team_id;

            api().post('/league/updateSingleTeamPreference/', formData).then(result => {
                    this.showLoadingIcon = false;
                    game.selected_team_id = game.selected_team_model.team_id;
                    game.success = [];
                    game.success.push("Successfully saved team preference");
                },
                err => {
					this.errors = [];
					this.showLoadingIcon = false;
                    this.errors.push(err.response.data.message);
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
            formData.tournamentId = this.league.league_tournament_id;

            api().post('/league/updateTeamPreference/', formData).then(result => {
                    this.showLoadingIcon = false;
                    this.teamPreferenceList = result.data.teamPreference;
                    this.teamPreferenceList.sort((a, b) => (b.preference_rank < a.preference_rank) ? 1 : -1);
                    this.getAllAvailableGames();
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