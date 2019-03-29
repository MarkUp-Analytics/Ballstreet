<template>
    <div>
        <div class="text-center bg-light">
            <admin-menu></admin-menu>    
            <div class="container mx-auto bg-light p-5">
                <h1 class="text-violet mx-auto">Input</h1>
                <h4 class="text-violet mx-auto mb-5">Result</h4>
                
                <div v-if="$route.params.matchFixtureDetails" class="card mx-auto">
                    <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100 mx-4 px-5 mb-4" role="alert">
                        <span v-for="error in errors">
                            <strong>Error!</strong> {{error}}<br>
                        </span>
                        <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div v-if="showSuccessMsg" class="alert alert-success alert-dismissible fade show w-100 mx-4 px-5 mb-4" role="alert">
                        <span>
                                <strong>Successfully updated match result!</strong><br>
                            </span>
                            <button type="button" class="close" data-dismiss="alert" @click="showSuccessMsg = false;" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                    </div>
					<div class="card bg-white">
						<div class="card-body">
							<form class="text-left p-3" id="tournament-create">
                                <h4 class="text-violet">{{$route.params.matchFixtureDetails.match_fixture_start_date | formatDate}}</h4>
                                <hr/>
                                <div class="form-group mt-4">
                                    <label>{{$route.params.matchFixtureDetails.tournament_name}}</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>{{$route.params.matchFixtureDetails.match_fixture_start_date | formatDate}}</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>{{$route.params.matchFixtureDetails.stadium_name}}</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <select class="form-control" v-model="matchResult">
                                        <option value="null" disabled>Select Result</option>
                                        <option v-for="option in resultOptions" :value="option.value">
                                            {{ option.name }}
                                        </option>
                                    </select>
                                </div>
                                <div class="row">
                                    <div class="col-lg mt-4">
                                        <a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="saveMatchResult()">Save</a><br/>
                                    </div>
                                </div>
                                <div class="row text-center">
                                    <div class="col-lg mt-2">
                                        <a href="" class="text-violet mt-5" @click.prevent="gotoInputSchedule()">Cancel</a>
                                    </div>
                                </div>
                            </form>
						</div>
					</div>
				</div>
            </div>
            <hr />
        </div>
    </div>            
</template>

<script>
import api from '@/services/api';
import commonServices from '@/services/commonServices';
import LoadingSpinner from '@/components/LoadingSpinner';
import AdminMenu from '@/components/AdminMenu';
    export default {
        name: 'InputResult',
        components:{
            LoadingSpinner,
            AdminMenu
        },
        created() {
            if(!this.$route.params.matchFixtureDetails){
                this.gotoInputSchedule();
            }
            this.generateOptions();
            if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
            }
    
        },
        data() {
            return {
                userDetails: null,
                resultOptions:[],
                matchResult: null,
                errors: [],
                showLoadingIcon: false,
                showSuccessMsg: false,
            }
        },
        methods: {
            generateOptions: function(){
                if(this.$route.params.matchFixtureDetails){
                    this.resultOptions.push(
                        {
                            name:this.$route.params.matchFixtureDetails.team_a_abbreviation,
                            value: this.$route.params.matchFixtureDetails.team_a_id
                        });
                        this.resultOptions.push(
                        {
                            name:this.$route.params.matchFixtureDetails.team_b_abbreviation,
                            value: this.$route.params.matchFixtureDetails.team_b_id
                        });
                        this.resultOptions.push(
                        {
                            name:'Draw',
                            value: 'draw'
                        });
                        this.resultOptions.push(
                        {
                            name:'No Result',
                            value: 'no_result'
                        });
                }
            },
            gotoInputSchedule: function(){
                this.$router.push({
                    name: 'Input Schedule2',
				});
            },
            getMatchResult: function(matchResult, matchFixtureDetails){
                if(matchResult == 'draw'){
                    matchFixtureDetails.winningTeam = null;
                    matchFixtureDetails.resultDraw = true;
                    matchFixtureDetails.noResult = null;
                }
                else if(matchResult == 'no_result'){
                    matchFixtureDetails.winningTeam = null;
                    matchFixtureDetails.resultDraw = null;
                    matchFixtureDetails.noResult = true;
                }
                else{
                    matchFixtureDetails.winningTeam = matchResult;
                    matchFixtureDetails.resultDraw = null;
                    matchFixtureDetails.noResult = null;
                }
            },
            saveMatchResult: function(){
                this.errors = [];
                if(!this.matchResult){
                    this.errors.push("Required field is missing");
                    return;
                }
                
                this.showLoadingIcon = true;

                var matchFixtureDetails = {};
                matchFixtureDetails.matchFixtureId = this.$route.params.matchFixtureDetails.match_fixture_id;
                this.getMatchResult(this.matchResult, matchFixtureDetails);
                matchFixtureDetails.userid = this.userDetails.userid;

                api().post('/fixtures/updateMatchResult', matchFixtureDetails)
                .then(result=>{
                        var self = this;
                        this.showLoadingIcon = false;
                        this.showSuccessMsg = true;
                        setTimeout(() => {
                            self.gotoInputSchedule();
                        }, 800);
                        
                    },
                    err => {
                        this.showLoadingIcon = false;
                        this.errors = [];
                        this.errors.push(err.response.data.message);
                    })
            },
        }
    }
</script>

<style>
</style>