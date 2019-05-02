<template>
<div>
        <member-menu :league="$route.query.league" :memberInLeague="userIsLeagueMember"></member-menu>
        <div class="mx-auto text-center bg-light">
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
                <h1 class="text-violet mt-1 mb-3">Team Preference</h1>
                <div>
                    <span class="text-red" style="font-size:smaller">Drag the team name to modify your preference</span>
                </div>
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
import MemberMenu from '@/components/MemberMenu';
import draggable from 'vuedraggable';
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
            teamPreferenceList: null,
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