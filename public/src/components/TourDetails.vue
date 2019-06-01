<template>
    <div class="text-center container mt-5">
        <div class="row mb-2">
            <div class="col h3">
                <a href="#" class="text-violet">{{details.tournament_name}}</a> | <a href="#" class="text-violet">{{details.sport_name}}</a>
            </div>
        </div>
        <div class="row mb-2">
            <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100" role="alert">
					<span v-for="error in errors">
                    <strong>Error!</strong> {{error}}
					</span>
					<button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				</div>
                <loading-spinner v-if="showLoadingIcon"></loading-spinner>
            <div class="col-lg mb-2">
                <img src="../../static/assets/images/ipl.png" class="rounded border" width="50px" height="50px" />
            </div>
            <div class="col-lg mb-2">
                <span class="text-secondary">Teams</span><br/> {{teamString}}
            </div>
            <div class="col-lg mb-2">
                <span class="text-secondary">Dates</span><br/> {{details.tournament_start_date | formatDate}} to {{details.tournament_end_date | formatDate}}
            </div>
            <div class="col-lg mb-2">
                <span class="text-secondary">Venue</span><br/> {{details.tournament_venue}}
            </div>
            <div class="col-lg mb-2">
                <span class="text-secondary"># Games</span><br/> {{totalGames}}
            </div>
        </div>
        <form class="row mb-2">
            <div class="col-lg">
            </div>
            <div class="col-lg form-group">
                <input class="form-control" type="text" placeholder="Game Id" v-model="league_id">
            </div>
            <div class="col-lg form-group">
                <a href="" @click.prevent="searchLeagues()" class="btn btn-dark bg-violet border-0 w-100">Search Leagues</a>
            </div>
            <div class="col-lg">
            </div>
        </form>
        <hr/>
        <div v-if="leagueSearchResults && leagueSearchResults.length > 0" class="mb-2">
            <div v-for="league in leagueSearchResults">
                <div class="row">
                    <div class="col-lg mb-2">
                        <span class="text-secondary">Game Id</span><br/>
                        {{league.league_shortid}}
                    </div>
                    <div class="col-lg mb-2">
                        <span class="text-secondary">Admin</span><br/>
                        {{league.league_created_by}}
                    </div>
                    <div class="col-lg mb-2">
                        <span class="text-secondary"># Players</span><br/>
                        {{league.league_total_members}}
                    </div>
                    <div class="col-lg mb-2">
                        <span class="text-secondary">Contribution</span><br/>
                        {{league.league_minimum_bet*totalGames}}
                    </div>
                    <div class="col-lg mb-2">
                        <span class="text-secondary">Link</span><br/>
                        <a href="" @click.prevent="gotoLeagueDashboard(league)" class="text-violet">Visit League</a>
                    </div>
                </div>
                <hr/>
            </div>
        </div>
    </div>
</template>

<script>
    import api from '@/services/api';
    import LoadingSpinner from '@/components/LoadingSpinner';
    
    export default {
        name: 'TourDetails',
        components:{
            LoadingSpinner
        },
        props: ['details'],
        watch:{
            'details.tournament_id': {
                handler(newVal, oldVal){
                    this.errors = [];
                    this.getPlayingTeams(this.details.tournament_id);
                    this.getTotalGames(this.details.tournament_id);
                }
            }
        },
        created() {
            if (this.details && this.details.tournament_id) {
                this.errors = [];
                this.getPlayingTeams(this.details.tournament_id);
                this.getTotalGames(this.details.tournament_id);
            }
        },
        data() {
            return {
                teams: [],
                teamString: null,
                league_id: null,
                totalGames: null,
                leagueSearchResults: null,
                errors: [],
                showLoadingIcon: false
            }
        },
        methods: {
            getPlayingTeams: function(tournament_id) {
                this.showLoadingIcon = true;
                this.teams = [];
                this.teamString = null;
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
                this.totalGames = null;
                api().get('/tournament/totalGames',{
                    params: {
                        tournamentID: tournamentID
                    }
                }).then(result => {
                        this.totalGames = result.data.totalGames;
                    },
                    err => {
                        if (err.response.data.message) {
                            this.errors.push(err.response.data.message);
                        } else {
                            this.errors.push("Error getting total games");
                        }
                    })
            },
            searchLeagues: function(){
                this.showLoadingIcon = true;
                api().get('/league/findLeagueById', {
                    params: {
                            leagueShortId: this.league_id,
                            tournamentId: this.details.tournament_id
                        }
                }).then(result => {
                    this.showLoadingIcon = false;
                        this.leagueSearchResults = result.data.leagues;
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
            },
            gotoLeagueDashboard: function(league){
				this.$router.push({
                    name: 'LeagueDashboard',
                    query:{
                        league: league.league_shortid
                    }
                    
				})
			},
        }
    }
</script>