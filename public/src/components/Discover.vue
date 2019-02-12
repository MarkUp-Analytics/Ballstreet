<template>
    <div>
        <div class="p-5 mx-auto text-center bg-light">
            <h1 class="mb-4 text-center text-violet">Discover</h1>
            <div class="row mx-auto mb-5">
                <div class="col-md"></div>
                <div class="col-md">
                        <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100" role="alert">
                            <span v-for="error in errors">
                                <strong>Error!</strong> {{error}}
                            </span>
                            <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    <loading-spinner v-if="showLoadingIcon"></loading-spinner>
                    <form>
                        <div class="form-group mt-3">
                            <label>Sport</label>
                            <select class="form-control" v-model="selectedSport">
                                <option v-for="sport in sportsList" :value="sport">
                                    {{ sport.sport_name }}
                                </option>
                            </select>
                        </div>
                        <div class="form-group mt-3">
                            <label>Tournament</label>
                            <select class="form-control" v-model="selectedtournament">
                                <option v-for="tour in filteredTournamentList" :value="tour">
                                    {{ tour.tournament_name }}
                                </option>
                            </select>
                        </div>
                        <div class="row mt-5 text-center">
                            <div class="col-lg">
                                <a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="searchTournaments()">Discover</a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md"></div>
            </div>
        </div>
        
        <div id="searchResults" v-if="tournamentSearchResults && tournamentSearchResults.length > 0">
            <div v-for="tournament in tournamentSearchResults">
                <section class="container pb-3">
                    <div class="p-5 mx-auto text-center bg-white">        
                        <h5 class="mt-1">SEARCH RESULTS</h5>
                        <i class="fas fa-arrow-down"></i>
                        <tour-details :details="tournament"></tour-details>
                    </div>
                </section>
            </div>    
        </div>
    </div>
</template>

<script>
    import api from '@/services/api';
    import commonServices from '@/services/commonServices';
    import LoadingSpinner from '@/components/LoadingSpinner';
    import TourDetails from '@/components/TourDetails';
    export default {
        name: 'Discover',
        components: {
            LoadingSpinner,
            TourDetails
    	},
        created() {
            this.getSportsList();
            this.getTournamentsList();
        },
        computed:{
            filteredTournamentList: function(){
                var self = this;
                if(!self.selectedSport){
                    return self.tournamentList;
                }
                else{
                    return self.tournamentList.filter(tour=>{
                        return tour.sport_id == self.selectedSport.sport_id;
                    })
                }
            }
        },
        watch:{
            selectedSport:{
                handler(newVal, oldVal){
                    if(this.selectedtournament && this.selectedtournament.sport_id != newVal.sport_id){
                        this.selectedtournament = null;
                    }
                    
                }
            },
            selectedtournament: {
                handler(newVal, oldVal){
                    var self = this;
                    self.sportsList.filter(sport=>{
                        if(sport.sport_id == newVal.sport_id){
                            self.selectedSport = sport;
                        }
                    });
                }
            }
        },
        data() {
            return{
                sportsList : [],
                tournamentList: [],
                selectedSport: null,
                selectedtournament: null,
                tournamentSearchResults: [],
                showLoadingIcon: false,
                errors: []
            }
        },
        methods: {
            getSportsList: function() {
                api().get('/sport/getSportsList').then(result => {
                        this.sportsList = result.data.sports;
                    },
                    err => {
                        if(err.response.data.message){
                            self.errors.push(err.response.data.message);
                        }
                        else{
                            self.errors.push("Error getting sports list for dropdown");
                        }
                    })
            },
            getTournamentsList: function(){
                api().get('/tournament/ongoingTournaments').then(result => {
                        this.tournamentList = result.data.tours;
                    },
                    err => {
                        if(err.response.data.message){
                            self.errors.push(err.response.data.message);
                        }
                        else{
                            self.errors.push("Error getting tournament list for dropdown");
                        }
                    })
            },
            gotoCreate: function(tournament){
				this.$router.push({
                    name: 'Create',
                    params:{
                        tournament_id: tournament.tournament_id
                    }
                    
				})
			},
            searchTournaments: function(){
                this.showLoadingIcon = true;
                api().get('/tournament/searchTournament', {
                    params: {
                            tournamentName: this.selectedtournament.tournament_name,
                            sportId: this.selectedSport.sport_id
                        }
                }).then(result => {
                        var self = this;
                        this.showLoadingIcon = false;
                        this.tournamentSearchResults = result.data.tournaments;
                        setTimeout(function(){
                            self.$scrollTo('#searchResults');
                        }, 300);
                        
                    },
                    err => {
                        this.showLoadingIcon = false;
                        this.$scrollTo('#search-results');
                        if(err.response.data.message){
                            this.errors.push(err.response.data.message);
                        }
                        else{
                            this.errors.push("Error searching");
                        }
                    })
            },
           
        }

        
    }
</script>

<style>
    
</style>