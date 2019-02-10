<template>
    <div class="p-5 text-center">
        <h1 class="mb-4 text-center text-violet">Create League</h1>
        <div class="row mx-auto mb-5">
            <div class="col-md"></div>
            <div class="col-md">
                <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100 mt-2" role="alert">
                    <span v-for="error in errors">
                    <strong>Error!</strong> {{error}}
                    </span>
                    <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form>
                    <div class="form-group mt-4">
                        <label>Sport</label>
                        <select class="form-control" v-model="sportFilter">
                            <option v-for="sport in sportsList">
                                {{ sport }}
                            </option>
                        </select>
                        
                    </div>
                    <div class="form-group mt-3">
                        <label>Tournament</label>
                        <select class="form-control" v-model="selectedTour" :disabled="!sportFilter">
                            <option v-for="tour in filteredUpcomingTours" :value="tour">
                                {{ tour.tournament_name }}
                            </option>
                        </select>
                        <small v-if="selectedTour">No. of Games: {{totalGames}}</small>
                    </div>
                    <div class="form-group mt-3">
                        <label>Enter Cash Per Game, INR</label>
                        <input class="form-control" type="text" placeholder="Example: INR 10" v-model="minimum_bet">
                        <small v-if="minimum_bet">Total Cash Required, {{'INR'}}: {{minimum_bet * totalGames}}</a></small>
                    </div>
                    <div class="form-group mt-3">
                        <label>League Name</label>
                        <input class="form-control" type="text" placeholder="Enter League name" v-model="league_name">
                    </div>
                    <div class="row mt-5 text-center">
                        <div class="col-lg">
                            <a href="" class="btn btn-dark bg-red border-0 w-100" @click.prevent="saveLeague()">Create League</a>
                            <small>All fields are required</small>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-md"></div>
        </div>
    </div>
</template>

<script>
import api from '@/services/api';
    import commonServices from '@/services/commonServices';
    export default {
        name: 'Create',
        created() {
            
            if(this.$route.params != null){
                this.getTournamentList(this.$route.params.tournament_id);
            }
            else{
                this.getTournamentList(null);
            }
        },
        watch: {
            selectedTour: {
                handler(newVal, oldVal){
                    this.getTotalGames(newVal.tournament_id);
                }
            }
        },
        computed:{
            filteredUpcomingTours: function(){
                if(!this.sportFilter){
                    return this.upcomingTours;
                }
                else{
                    return this.upcomingTours.filter(tour=>{
                        if(tour.sport_name === this.sportFilter){
                            return tour;
                        }
                    })
                } 
            }

        },
        data() {
            return {
                get userDetails() {
					if (localStorage.getItem('userDetails')) {
						return JSON.parse(localStorage.getItem('userDetails'));
					}
				},
                sportFilter: null,
                selectedTour: null,
                totalGames: null,
                minimum_bet: null,
                league_name: null,
                upcomingTours: [],
                sportsList: [],
                newLeague: {
                    minimum_bet: 10
                },
                errors: []
            }
        },
        methods: {
            getTournamentList: function(preselectedTour) {
                var self = this;
                api().get('/tournament/upcomingTournaments').then(result => {
                        self.createAvailableSportsList(result.data.tours);
                        self.upcomingTours = result.data.tours;
                        if(preselectedTour != null){
                            self.selectedTour = self.upcomingTours.filter(function(tour){
                                return tour.tournament_id === preselectedTour;
                            })[0];
                            self.sportFilter = self.selectedTour.sport_name;
                        }
                    },
                    err => {
                        console.log(err)
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

            createAvailableSportsList: function(upcomingTours){
                var self = this;
                for(var i=0; i<upcomingTours.length; i++){
                    if(self.sportsList.indexOf(upcomingTours[i].sport_name) == -1){
                        self.sportsList.push(upcomingTours[i].sport_name);
                    }
                }
            },
            
            saveLeague: function() {
                console.log('test');
                var self = this;
                self.errors = [];
                if (commonServices.isEmpty(self.league_name) ||
                    commonServices.isEmpty(self.minimum_bet) ||
                    commonServices.isEmpty(self.selectedTour)) {
                    self.errors.push("Required fields cannot be empty.");
                } else if (self.minimum_bet < 10) {
                    self.errors.push("Minimum bet for a match has to be atleast Rs. 10.");
                }else if(self.minimum_bet > 100){
                    self.errors.push("Maximum bet for a match cannot exceed Rs. 100.");
                }
                else{
                    var formData = {
                        userid: this.userDetails.userid,
                        newLeague : {
                            league_name: this.league_name.trim().toUpperCase(),
                            minimum_bet: this.minimum_bet,
                            tournament_id: this.selectedTour.tournament_id
                        }
                    }
                    api().post('/league/createLeague/', formData).then(result=>{
                        console.log("League created");
                        this.$router.push({
                            name: 'Profile', 
                        })
                    },
                    err=>{
                        console.log(err);
                        if(err.response.data.message){
                            this.errors.push(err.response.data.message);
                        }
                        else{
                            this.errors.push("Error creating new league");
                        }
                        
                    })
                }
            }
        }
    }

</script>

<style>

</style>