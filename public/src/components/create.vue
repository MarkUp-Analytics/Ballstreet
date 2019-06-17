<template>
    <div class="p-5 mx-auto text-center bg-light">
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
                        <label>Enter Deal Brief (Incl. Event Name)</label>
                        <textarea class="form-control" type="text" placeholder="For example: Will Kapil Dev score more than 75 in India vs Pakistan?" v-model="league_name" rows="3"></textarea>
                    </div>
                    <div class="form-group mt-4">
                        <label>Enter Scoring Methodology</label>
                        <textarea class="form-control" type="text" placeholder="For example: Runs + Wickets*3 + Catches*5" v-model="league_name" rows="2"></textarea>
                    </div>
                    <div class="form-group mt-4">
                        <label>Enter Date of the Event (DD/MM/YY HH:MM)</label>
                        <input class="form-control mb-1" type="text" placeholder="Example: 23/05/90 20:30" />
                        <select class="form-control">
                            <option>Pick Time Zone</option>
                            <option>UTC + 14 Hrs | LINT</option>
                            <option>UTC + 13 Hrs | TOT</option>
                            <option>UTC + 12:45 Hrs | CHAST</option>
                            <option>UTC + 12 Hrs | ANAT</option>
                            <option>UTC + 11 Hrs | SBT</option>
                            <option>UTC + 10:30 Hrs | LHST</option>
                            <option>UTC + 10 Hrs | AEST</option>
                            <option>UTC + 9:30 Hrs | ACST</option>
                            <option>UTC + 9 Hrs | JST</option>
                            <option>UTC + 8:45 Hrs | ACWST</option>
                            <option>UTC + 8 Hrs | CST</option>
                            <option>UTC + 7 Hrs | WIB</option>
                            <option>UTC + 6:30 Hrs | MMT</option>
                            <option>UTC + 6 Hrs | BST</option>
                            <option>UTC + 5:45 Hrs | NPT</option>
                            <option>UTC + 5:30 Hrs | IST</option>
                            <option>UTC + 5 Hrs | UZT</option>
                            <option>UTC + 4:30 Hrs | IRDT</option>
                            <option>UTC + 4 Hrs | GST</option>
                            <option>UTC + 3 Hrs | MSK</option>
                            <option>UTC + 2 Hrs | CEST</option>
                            <option>UTC + 1 Hrs | BST</option>
                            <option>UTC + 0 Hrs | GMT</option>
                            <option>UTC - 1 Hrs | CVT</option>
                            <option>UTC - 2 Hrs | WGST</option>
                            <option>UTC - 2:30 Hrs | NDT</option>
                            <option>UTC - 3 Hrs | ART</option>
                            <option>UTC - 4 Hrs | EDT</option>
                            <option>UTC - 5 Hrs | CDT</option>
                            <option>UTC - 6 Hrs | CST</option>
                            <option>UTC - 7 Hrs | PDT</option>
                            <option>UTC - 8 Hrs | AKDT</option>
                            <option>UTC - 9 Hrs | HDT</option>
                            <option>UTC - 9:30 Hrs | MART</option>
                            <option>UTC - 10 Hrs | HST</option>
                            <option>UTC - 11 Hrs | NUT</option>
                            <option>UTC - 12 Hrs | AoE</option>
                        </select>
                    </div>
                    <div class="form-group mt-4">
                        <label>Last Date to Join League (DD/MM/YY HH:MM)</label>
                        <input class="form-control mb-1" type="text" placeholder="Example: 23/05/90 20:30" />
                        <select class="form-control">
                            <option>Pick Time Zone</option>
                            <option>UTC + 14 Hrs | LINT</option>
                            <option>UTC + 13 Hrs | TOT</option>
                            <option>UTC + 12:45 Hrs | CHAST</option>
                            <option>UTC + 12 Hrs | ANAT</option>
                            <option>UTC + 11 Hrs | SBT</option>
                            <option>UTC + 10:30 Hrs | LHST</option>
                            <option>UTC + 10 Hrs | AEST</option>
                            <option>UTC + 9:30 Hrs | ACST</option>
                            <option>UTC + 9 Hrs | JST</option>
                            <option>UTC + 8:45 Hrs | ACWST</option>
                            <option>UTC + 8 Hrs | CST</option>
                            <option>UTC + 7 Hrs | WIB</option>
                            <option>UTC + 6:30 Hrs | MMT</option>
                            <option>UTC + 6 Hrs | BST</option>
                            <option>UTC + 5:45 Hrs | NPT</option>
                            <option>UTC + 5:30 Hrs | IST</option>
                            <option>UTC + 5 Hrs | UZT</option>
                            <option>UTC + 4:30 Hrs | IRDT</option>
                            <option>UTC + 4 Hrs | GST</option>
                            <option>UTC + 3 Hrs | MSK</option>
                            <option>UTC + 2 Hrs | CEST</option>
                            <option>UTC + 1 Hrs | BST</option>
                            <option>UTC + 0 Hrs | GMT</option>
                            <option>UTC - 1 Hrs | CVT</option>
                            <option>UTC - 2 Hrs | WGST</option>
                            <option>UTC - 2:30 Hrs | NDT</option>
                            <option>UTC - 3 Hrs | ART</option>
                            <option>UTC - 4 Hrs | EDT</option>
                            <option>UTC - 5 Hrs | CDT</option>
                            <option>UTC - 6 Hrs | CST</option>
                            <option>UTC - 7 Hrs | PDT</option>
                            <option>UTC - 8 Hrs | AKDT</option>
                            <option>UTC - 9 Hrs | HDT</option>
                            <option>UTC - 9:30 Hrs | MART</option>
                            <option>UTC - 10 Hrs | HST</option>
                            <option>UTC - 11 Hrs | NUT</option>
                            <option>UTC - 12 Hrs | AoE</option>
                        </select>
                    </div> 
                    <div class="form-group mt-4">
                        <label>Enter Responses</label>
                        <input class="form-control mb-1" type="text" placeholder="Response 1" />
                        <input class="form-control mb-1" type="text" placeholder="Response 2" />
                        <input class="form-control mb-1" type="text" placeholder="Response 3" />
                        <input class="form-control mb-1" type="text" placeholder="Response 4" />
                        <a href="" class="btn btn-outline-secondary w-100">Add Response</a>
                        <small>Max. number of responses: 100</small>
                    </div>
                    <div class="form-group mt-4">
                        <label>Enter number of responses each player has to pick</label>
                        <input class="form-control" type="text" placeholder="Example: 3" />
                    </div>
                    <div class="form-group mt-4">
                        <label>Enter Contribution Per Player, INR</label>
                        <input class="form-control" type="text" placeholder="Example: INR 10" v-model="minimum_bet" />                        
                    </div>
                     <div class="form-group mt-4">
                        <label>Enter Game Type</label>
                        <select class="form-control">
                            <option>Losers Lose; Winners Win</option>
                            <option>Reward Top 1</option>
                            <option>Reward Top 3</option>
                            <option>Reward Top 5</option>
                            <option>Reward Top 10%</option>
                            <option>Reward Top 30%</option>
                            <option>Reward Top 50%</option>
                        </select>
                    </div>
                    <div class="form-group mt-4">
                        <div class="mb-1">
                            <table class="table table-sm table-bordered">
                                <thead>
                                    <tr class="table-secondary">
                                        <th scope="col">Losers Lose; Winners Win</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Winners Share Total Contribution of Losers</td>
                                    </tr>
                                    <tr>
                                        <td>Losers Lose Their Contribution</td>
                                    </tr>
                                </tbody>
                            </table>                           
                        </div>
                        <div class="mb-1">
                            <table class="table table-sm table-bordered">
                                <thead>
                                    <tr class="table-secondary">
                                        <th scope="col">Reward Top 1</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Rank #1 Wins 100% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rest Lose Their Contribution</td>
                                    </tr>
                                </tbody>
                            </table>                          
                        </div>
                        <div class="mb-1">
                            <table class="table table-sm table-bordered">
                                <thead>
                                    <tr class="table-secondary">
                                        <th scope="col">Reward Top 3</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Rank #1 Wins 50% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rank #2 Wins 25% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rank #3 Wins 25% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rest Lose Their Contribution</td>
                                    </tr>
                                </tbody>
                            </table>                          
                        </div>
                        <div class="mb-1">
                            <table class="table table-sm table-bordered">
                                <thead>
                                    <tr class="table-secondary">
                                        <th scope="col">Reward Top 5</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Rank #1 Wins 50% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rank #2 Wins 20% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rank #3 Wins 20% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rank #4 Wins 5% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rank #5 Wins 5% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rest Lose Their Contribution</td>
                                    </tr>
                                </tbody>
                            </table>                          
                        </div>
                        <div class="mb-1">
                            <table class="table table-sm table-bordered">
                                <thead>
                                    <tr class="table-secondary">
                                        <th scope="col">Reward Top 10%</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Top 10% Winners Share 100% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rest Lose Their Contribution</td>
                                    </tr>
                                </tbody>
                            </table>                          
                        </div>
                        <div class="mb-1">
                            <table class="table table-sm table-bordered">
                                <thead>
                                    <tr class="table-secondary">
                                        <th scope="col">Reward Top 30%</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Top 30% Winners Share 100% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rest Lose Their Contribution</td>
                                    </tr>
                                </tbody>
                            </table>                          
                        </div>
                        <div class="mb-1">
                            <table class="table table-sm table-bordered">
                                <thead>
                                    <tr class="table-secondary">
                                        <th scope="col">Reward Top 50%</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Top 50% Winners Share 100% Of Total Pooled Contribution</td>
                                    </tr>
                                    <tr>
                                        <td>Rest Lose Their Contribution</td>
                                    </tr>
                                </tbody>
                            </table>                          
                        </div>
                    </div>
                    <div class="row mt-5 text-center">
                        <div class="col-lg">
                            <a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="saveLeague()">Create League</a>
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
                            name: 'Home', 
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