<template>
    <div>
        <div class="row p-5 mx-auto text-center bg-light">
            <div class="container">
                <h1 class="text-violet mt-1 mb-1">Overview</h1>
                <h4 class="text-violet mt-1 mb-3">Games and Your P&L</h4>
                <!-- Block-01: Is this code necessary -->
                    <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100" role="alert">
                        <span v-for="error in errors">
                            <strong>Error!</strong> {{error}}
                        </span>
                        <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                <!-- Block-01 -->
                <div v-if="associatedLeagues && associatedLeagues.length === 0">
                    <div class="row mt-5">
                        <div class="col-lg mb-5">
                            <div class="bg-tennis"></div>
                            <h3>Would you like to join a league?</h3>                        
                            <a class="m-1 btn btn-dark bg-violet border-0" href="" @click.prevent="redirectPage('Discover')">Discover</a><br/><br/>
                            <span class="text-secondary">You would need to get the Game Pin and Game Password from your friends!</span>
                        </div>
                        <div class="col-lg mb-5">
                            <div class="bg-high-jump"></div>
                            <h3>Would you like to create a league?</h3>
                            <a class="m-1 btn btn-dark bg-violet border-0" href="" @click.prevent="redirectPage('Create')">Create</a><br/><br/>
                            <span class="text-secondary">Once you create a leage, you would be able to share the Game Pin and Game Password with your friends!</span>
                        </div>
                    </div>
                </div>

                <div v-if="associatedLeagues.length > 0">
                    <div class="row mt-5">
                        <div class="col-lg mb-3">
                            <span class="text-secondary">Contribution, INR</span><br/>
                            <h3>450.00</h3>
                            <a href="" class="btn-sm text-violet">Running Leagues: 3</a>
                        </div>
                        <div class="col-lg mb-3">
                            <span class="text-secondary">Curr. Value, INR</span><br/>
                            <h3>652.69</h3>
                        </div>
                        <div class="col-lg mb-3">
                            <span class="text-secondary">P&L</span><br/>
                            <h3 class="text-success">45.04%</h3>
                        </div>
                        <div class="col-lg">
                            <span class="text-secondary">Funds, INR</span><br/>
                            <h3>63.00</h3>
                            <a href="#" class="btn-sm text-violet">Add Funds</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="associatedLeagues.length > 0">
            <div class="p-5 mx-auto text-center bg-white">
                <div class="container">
                    <h1 class="text-violet mt-1 mb-5">Current P&L</h1>
                    <div class="w-100 max-height-90vh table-responsive mt-4 mb-4">
                        <table class="table sortable">
                            <thead>
                                <tr>
                                    <th>Id</th>
                                    <th>League</th>
                                    <th>Tournament</th>
                                    <th>Admin</th>
                                    <th>#Players</th>
                                    <th>Contribution</th>
                                    <th>Current</th>
                                    <th>P&L</th>
                                    <th>Link</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(league, index) in associatedLeagues">
                                    <td>
                                        <span class="mb-2 text-bold text-yellow cursorPointer">{{league.league_shortid}} </span>
                                    </td>
                                    <td>
                                        {{league.league_name}}
                                    </td>
                                    <td>
                                        {{league.tournament_name}}
                                    </td>
                                    <td>
                                        {{league.league_created_by}}
                                    </td>
                                    <td>
                                        {{league.league_total_members}}
                                    </td>
                                    <td>
                                        {{league.league_minimum_bet}}
                                    </td>
                                    <td>
                                        289
                                    </td>
                                    <td>
                                        20%
                                    </td>
                                    <td>
                                        <a href="" @click.prevent="gotoLeagueDashboard(league)">Open</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="p-5 mx-auto text-center bg-white">
            <div class="container">
                <h1 class="text-violet mt-1 mb-1">Upcoming Tournaments</h1>
                <h4 class="text-violet mt-1 mb-1">Basis Your Preferences</h4>
                <a href="" @click.prevent="redirectPage('Discover')" class="text-violet">
                    <h6 class="mt-1 mb-5">Click here to update your sports preferences</h6>
                </a>

                <div class="text-center mt-4 mb-5">
                    <div class="row mb-1">
                        <div class="col h3">
                            <a href="#" class="text-violet">Gavaskar-Border Trophy 2018</a> | <a href="#" class="text-violet">Cricket</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg mb-2">
                            <img src="../../static/assets/images/ipl.png" class="rounded border" width="50px" height="50px"/>
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Teams</span><br/>
                            Austalia, England, India, Srilanka, Pakistan
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Dates</span><br/>
                            28-June-2018 to 31-December-2018
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Venue</span><br/>
                            Australia
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary"># Games</span><br/>
                            72
                        </div>
                    </div>
                </div>  

                <div class="text-center mt-4 mb-5">
                    <div class="row mb-1">
                        <div class="col h3">
                            <a href="#" class="text-violet">Gavaskar-Border Trophy 2018</a> | <a href="#" class="text-violet">Cricket</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg mb-2">
                            <img src="../../static/assets/images/ipl.png" class="rounded border" width="50px" height="50px"/>
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Teams</span><br/>
                            Austalia, England, India, Srilanka, Pakistan
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Dates</span><br/>
                            28-June-2018 to 31-December-2018
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Venue</span><br/>
                            Australia
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary"># Games</span><br/>
                            72
                        </div>
                    </div>
                </div>                
            </div>                    
            <a href="" @click.prevent="redirectPage('Discover')" class="text-violet">
                <h6 class="mt-1 mb-5">Click here to discover all the upcoming tournaments</h6>
            </a>
        </div>
    </div>
</template>

<script>
    import api from '@/services/api';
    export default {
        name: 'Home',
        mounted() {
			this.$nextTick(function () {
				this.$scrollTo('#app')
  			})
			
		},
        created() {
            if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
                this.getAssociatedLeagues(this.userDetails.shortid);
            } else {
                this.$router.push({
                    name: 'Index',
                })
            }
    
        },
        data: function() {
            return {
                userDetails: null,
                associatedLeagues: [],
                errors: []
            }
        },
        methods: {
            getAssociatedLeagues: function(shortid) {
                var self = this;
                if (shortid) {
                    api().get('/profile/associatedLeagues', {
                        params: {
                            shortid: shortid
                        }
                    }).then(result => {
                            self.associatedLeagues = result.data.leagues;
                        },
                        err => {
                            if (err.response.data.message) {
                                self.errors.push(err.response.data.message);
                            } else {
                                self.errors.push("Error creating associated leagues");
                            }
                        })
                }
            },
            gotoLeagueDashboard: function(league){
				this.$router.push({
                    name: 'LeagueDashboard',
                    query:{
                        league: league.league_shortid
                    }
                    
				})
            },
            redirectPage: function(componentName){
				this.$router.push({
					name: componentName,
				})
			},
        }
    }
</script>

<style>
    .text-bold {
        font-weight: bold;
    }
</style>