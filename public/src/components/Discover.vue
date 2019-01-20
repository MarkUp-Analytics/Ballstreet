<template>
    <div class="container bg-white py-5 px-5 shadow-sm w-95">
        <h3 class="mb-5 text-center">Discover</h3>
    
        <div class="row mb-5">
            <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100" role="alert">
					<span v-for="error in errors">
                    <strong>Error!</strong> {{error}}
					</span>
					<button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				</div>
                <loading-spinner v-if="showLoadingIcon"></loading-spinner>
            <div class="col-lg-6">
                <input class="form-control form-control-md mb-3" type="text" placeholder="Search for league or tournament" v-model="searchText" />
            </div>
            <div class="col-lg-3">
                <div class="form-group">
                    <select class="form-control" v-model="selectedSport">
                            <option v-for="sport in sportsList" :value="sport">
                                {{ sport.sport_name }}
                            </option>
                        </select>
                </div>
            </div>
            <div class="col-lg-3">
                <a href="" class="btn btn-md btn-outline-success rounded-1 w-100" @click.prevent="searchTournaments()">Search</a>
            </div>
        </div>
    
        <hr class="mb-5" />
    </div>
</template>

<script>
    import api from '@/services/api';
    import commonServices from '@/services/commonServices';
    import LoadingSpinner from '@/components/LoadingSpinner';
    export default {
        name: 'Discover',
        components: {
        	LoadingSpinner
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