<template>
<div class="p-5 text-center">
		<h1 class="mb-4 text-center text-violet">Create League</h1>
		<div class="row mx-auto">
			<div class="col-md"></div>
			<div class="col-md">
				<form class="mb-5">
					<div class="form-group mt-3">
						<label>Sport</label>
                        <select class="form-control" v-model="sportFilter">
                            <option v-for="sport in sportsList">
                                {{ sport }}
                            </option>
                        </select>
						
					</div>
					<div class="form-group mt-3">
						<label>Tournament</label>
						<select class="form-control" v-model="selectedTour">
                            <option v-for="tour in filteredUpcomingTours" :value="tour">
                                {{ tour.tournament_name }}
                            </option>
						</select>
						<small v-if="selectedTour">No. of Games: {{totalGames}}</small>
					</div>
					<div class="form-group mt-3">
						<label>Enter Cash Per Game, INR</label>
						<input class="form-control" type="text" placeholder="Example: INR 10">
						<small>Total Cash Required, {{'INR'}}: {{'5200'}}</a></small>
					</div>
					<div class="row mt-4 text-right">
						<div class="col-lg">
							<button type="submit" class="btn btn-dark bg-red border-0 w-100">Create League</button>
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
            this.getTournamentList();
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
                sportFilter: null,
                selectedTour: null,
                totalGames: null,
                upcomingTours: [],
                sportsList: [],
                newLeague: {
                    minimum_bet: 10
                },
                errors: []
            }
        },
        methods: {
            getTournamentList: function() {
                api().get('/tournament/upcomingTournaments').then(result => {
                        this.createAvailableSportsList(result.data.tours);
                        this.upcomingTours = result.data.tours;
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
                        this.totalGames = result.data;
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
            
            toggleDetails: function(tour) {
                tour.showDetails = !tour.showDetails;
                return false;
            },
            newLeagueDialog: function(tour) { //Method to open modal window
                this.newLeague = {};
                this.newLeague.tournament_name = tour.tournament_name;
                this.newLeague.tournament_id = tour.tournament_id;
                $('#myModal').modal();
            },
            saveLeague: function() {
                var self = this;
                self.errors = [];
                if (commonServices.isEmpty(self.newLeague.league_name) ||
                    commonServices.isEmpty(self.newLeague.minimum_bet)) {
                    self.errors.push("Required fields cannot be empty.");
                } else if (self.newLeague.minimum_bet < 10) {
                    self.errors.push("Minimum bet for a match has to be atleast Rs. 10.");
                }
                else{
                    api().post('/createLeague', self.newLeague).then(result=>{
                        console.log("League created");
                        self.closeModal();
                    },
                    err=>{
                        console.log(err);
                        self.errors.push("Error creating new league");
                    })
                }
            },
            closeModal: function(){
                this.errors = [];
                $('#myModal').modal('hide');
            }
        }
    }

</script>

<style>

</style>