<template>
    <div>
        <div class="p-5 mx-auto text-center bg-light">
            <h1 class="mb-4 text-center text-violet">Discover</h1>
            <div class="row mx-auto mb-5">
                <div class="col-md"></div>
                <div class="col-md">
                    <!-- Block-02: Is this code necessary -->
                        <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100" role="alert">
                            <span v-for="error in errors">
                                <strong>Error!</strong> {{error}}
                            </span>
                            <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    <!-- Block-02 -->
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
                            <select class="form-control" v-model="selectedSport">
                                <option v-for="sport in sportsList" :value="sport">
                                    {{ sport.sport_name }}
                                </option>
                            </select>
                        </div>
                        <div class="row mt-5 text-center">
                            <div class="col-lg">
                                <a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="saveLeague()">Discover</a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md"></div>
            </div>
        </div>
        
        <div v-if="tournamentSearchResults && tournamentSearchResults.length > 0">
            <div v-for="tournament in tournamentSearchResults">
                <section id="search-results" class="container pb-3">
                    <div class="p-5 mx-auto text-center bg-white">        
                        <h5 class="mt-1">SEARCH RESULTS</h5>
                        <i class="fas fa-arrow-down"></i>
                        <tour-details :details="tournament"></tour-details>
                        <!-- <table class="table table-md sortable">
                            <thead>
                                <tr>
                                    <th scope="col-2">Tournament Name</th>
                                    <th scope="col-2">Start Date</th>
                                    <th scope="col-2">End Date</th>
                                    <th scope="col-2">Link</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(tournament, index) in tournamentSearchResults">
                                    <td>
                                        {{tournament.tournament_name}}
                                    </td>
                                    <td>
                                        {{tournament.tournament_start_date | formatDate}}
                                    </td>
                                    <td>
                                        {{tournament.tournament_end_date | formatDate}}
                                    </td>
                                    <td>
                                        <a href="" @click.prevent="gotoCreate(tournament)">Create League</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table> -->
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
        },
        data() {
            return{
                searchText: null,
                sportsList : [],
                selectedSport: null,
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
                            tournamentName: this.searchText,
                            sportId: this.selectedSport.sport_id
                        }
                }).then(result => {
                    this.showLoadingIcon = false;
                        this.tournamentSearchResults = result.data.tournaments;
                    },
                    err => {
                        this.showLoadingIcon = false;
                        if(err.response.data.message){
                            this.errors.push(err.response.data.message);
                        }
                        else{
                            this.errors.push("Error searching");
                        }
                    })
            }
        }

        
    }
</script>

<style>
    
</style>