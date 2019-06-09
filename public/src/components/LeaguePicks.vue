<template>
    <div>
        <member-menu :league="$route.query.league" :memberInLeague="userIsLeagueMember"></member-menu>
        <div class="p-5 mx-auto text-center bg-light">
            <div class="container">
                <loading-spinner v-if="showLoadingIcon"></loading-spinner>
                <h1 class="text-violet mt-1">Picks</h1>
                <h6 class="text-secondary mb-5">Select the game to know the teams the players have picked.</h6>
                
                <b-container fluid class="my-4">
                    <div class="row">
                        <div class="col-lg-3">
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group mt-2">
                                <label style="display: inline;">
                                    <span class="text-secondary">Game:</span>
                                </label>
                                <!-- <b-form-select v-model="selected_game" :options="lockedGames"></b-form-select> -->
                                <b-form-select v-model="selected_game">           
                                    <option v-for="(game, indexOpt) in lockedGames" 
                                        :key="indexOpt"
                                        :value="game"
                                    >
                                        {{ game.displayText }}
                                    </option>
                                </b-form-select>
                                <!-- <v-select class="text-center" v-if="lockedGames && lockedGames.length > 0" v-model="selected_game" :options="lockedGames" 
                                    item-value="match_fixture_id"
                                    item-text="displayText"
                                    label="displayText">
                                </v-select> -->
                            </div>
                        </div>
                        <div class="col-lg-3">
                        </div>
                    </div>
                    
                    <hr class="my-5"/>

                    <h3 v-if="selected_game">{{getTeamFromGlobalList(selected_game.team_a_id).team_abbreviation + " v " + getTeamFromGlobalList(selected_game.team_b_id).team_abbreviation}}</h3>
                    <h5 v-if="selected_game" class="mb-5">{{$options.filters.formatDate(selected_game.match_fixture_start_date) + " " + selected_game.match_fixture_toss_time.split(':').slice(0,2).join(":") + " Hrs | " + selected_game.stadium_name + ", " + selected_game.stadium_city}}</h5>
                    
                    <div class="row">
                        <div class="col-lg-2">
                        </div>
                        <div class="col-lg-4 mb-5">
                            <img style=" " v-if="selected_game && selected_game != null" :src="getTeamFromGlobalList(selected_game.team_a_id).team_image" width="50px" height="50px"/>
                            <h4 v-if="selected_game" class="mt-2 mb-0">{{getTeamFromGlobalList(selected_game.team_a_id).team_abbreviation}}</h4>
                            <h5 v-if="selected_game" class="mt-0 mb-4">{{"Supporters: " + membersWithTeamA.length}}</h5>
                            <div class="" v-if="selected_game && selected_game != null" v-for="member in membersWithTeamA">
                                <p>{{member.name}}</p>                               
                            </div>
                        </div>
                        <div class="col-lg-4 mb-5">
                            <img style=" " v-if="selected_game && selected_game != null" :src="getTeamFromGlobalList(selected_game.team_b_id).team_image" width="50px" height="50px"/>
                            <h4 v-if="selected_game" class="mt-2 mb-0">{{getTeamFromGlobalList(selected_game.team_b_id).team_abbreviation}}</h4>
                            <h5 v-if="selected_game" class="mt-0 mb-4">{{"Supporters: " + membersWithTeamB.length}}</h5>
                            <div class="" v-if="selected_game && selected_game != null" v-for="member in membersWithTeamB">
                                <p>{{member.name}}</p>                               
                            </div>
                        </div>
                        <div class="col-lg-2">
                        </div>
                    </div>
                </b-container>
            </div>
        </div>
    </div>
</template>

<script>
import api from '@/services/api';
import LoadingSpinner from '@/components/LoadingSpinner';
import MemberMenu from '@/components/MemberMenu';
import moment from 'moment-timezone';
    export default {
        name: 'LeaguePicks',
        components: {
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
                    self.getLockedGames(self.league.league_tournament_id);
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
        data() {
            return {
                userDetails: null,
                showLoadingIcon: false,
                userIsLeagueMember: false,
                league: null,
                errors: [],
                leaguePicks: [],
                teamsInTournamentList: [],
                lockedGames: [],
                selected_game: null,
                fields: [
                    { key: 'member_name', label: 'Name', sortable: true },
                    { key: 'email', label: 'Email', sortable: true },
                    { key: 'profit_loss', label: 'P&L', sortable: true },
                    { key: 'current_streak', label: 'Current Streak', sortable: true },
                    { key: 'risk_taking_score', label: 'Risk Score', sortable: true }
                ],
                sortBy: 'member_name',
                sortDesc: false,
                sortDirection: 'asc',
                filter: null,
                currentPage: 1,
                perPage: 20,
                totalRows: 40,
                pageOptions: [10, 20, 30, 40, 50, "Infinte Scroll"]
            }
        },
        computed: {
            sortOptions() {
                // Create an options list from our fields
                return this.fields
                .filter(f => f.sortable)
                .map(f => {
                    return { text: f.label, value: f.key }
                })
            },
            membersWithTeamA: function(){
                var self = this;
                if(self.leaguePicks.length > 0){
                    return self.leaguePicks.filter(item=>{
                        return item.match_fixture_id == self.selected_game.match_fixture_id && item.selected_team == self.selected_game.team_a_id;
                    })
                }
                else{
                    return [];
                }
            },

            membersWithTeamB: function(){
                var self = this;
                if(self.leaguePicks.length > 0){
                    return self.leaguePicks.filter(item=>{
                        return item.match_fixture_id == self.selected_game.match_fixture_id && item.selected_team == self.selected_game.team_b_id;
                    })
                }
                else{
                    return [];
                }
            }
        },
        methods: {
            onFiltered(filteredItems) {
                // Trigger pagination to update the number of buttons/pages due to filtering
                this.totalRows = filteredItems.length
                this.currentPage = 1
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
                            self.getLeaguePicks(self.league.league_id);
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
            memberListWithTeam: function(match_fixture_id, selected_team_id){
                var self = this;
                if(self.leaguePicks.length > 0){
                    return self.leaguePicks.filter(item=>{
                        return item.match_fixture_id == match_fixture_id && item.selected_team == selected_team_id;
                    });
                }
                
            },
            getLockedGames: function(tournamentId){
                this.errors = [];
                this.lockedGames = [];
                var self = this;
                api().get('/fixtures/getLockedMatchFixtures', {
                        params: {
                            tournamentId: tournamentId
                        }
                }).then(result => {
                        self.lockedGames = result.data.scheduleList;
                        self.lockedGames.filter(game=>{
                            var matchStartDate = moment(game.match_fixture_start_date).format("YYYY-MM-DD");
                            var venueLocalTime = moment.tz(matchStartDate + " " + game.match_fixture_toss_time, game.stadium_timezone);
                            var matchStartLocalTime = venueLocalTime.clone().tz(moment.tz.guess()).toDate();
                            var localTimezone = moment.tz(moment.tz.guess()).zoneAbbr();

                            game.displayText = self.$options.filters.formatTime(matchStartLocalTime) + " " + localTimezone + " | " + game.team_a_abbreviation + " VS " + game.team_b_abbreviation;
                        });
                        self.selected_game = self.lockedGames[self.lockedGames.length - 1];
                    },
                    err => {
                        this.errors = [];
                        this.errors.push(err.response.data.message);
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
            getLeaguePicks: function(leagueId){
                var self = this;
                this.showLoadingIcon = true;
                    api().get('/league_member/getLeaguePicks', {
                    params: {
                            leagueId: leagueId,
                        }
                    }).then(result => {
                        self.showLoadingIcon = false;
                        self.leaguePicks = result.data.leaguePicks;
                    },
                    err => {
                        self.showLoadingIcon = false;
                        if(err.response.data.message){
                            self.errors.push(err.response.data.message);
                        }
                        else{
                            self.errors.push("Error getting league statistics");
                        }
                    })
            },
            
        }
    }
</script>

<style>
</style>