<template>
    <div>
        <div class="row p-5 mx-auto text-center bg-light">
            <div class="container">
                <loading-spinner v-if="showLoadingIcon"></loading-spinner>
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
                            <h3>{{total_contribution}}</h3>
                        </div>
                        <div class="col-lg mb-3">
                            <span class="text-secondary">Curr. Value, INR</span><br/>
                            <h3>{{current_value}}</h3>
                        </div>
                        <div class="col-lg mb-3">
                            <span class="text-secondary">P&L, INR</span><br/>
                            <h3 :class="total_profit_loss > 0 ? 'text-success' : 'text-danger'">{{total_profit_loss}}</h3>
                        </div>
                        <div class="col-lg mb-3">
                            <span class="text-secondary">P&L, %</span><br/>
                            <h3 :class="total_profit_loss > 0 ? 'text-success' : 'text-danger'">{{Number((total_profit_loss*100/current_value).toFixed(2))}}%</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="associatedLeagues.length > 0">
            <div class="p-5 mx-auto text-center bg-white">
                <div class="container" id="current-pl">
                    <h1 class="text-violet mt-1 mb-5">Ongoing Leagues</h1>
                    <b-container fluid  class="p-0">
                        <b-row class="my-0 py-0">
                            <b-col md="7">
                                <b-form-group class="my-2">
                                    <b-input-group>
                                        <b-form-input v-model="filter" placeholder="Type to Search" />
                                    </b-input-group>
                                </b-form-group>
                            </b-col>
                            <b-col md="5">
                                <b-form-group label-cols="3" label="Per Pg" class="my-2">
                                    <b-form-select :options="pageOptions" v-model="perPage" />
                                </b-form-group>
                            </b-col>
                        </b-row>
                        <b-form-group class="my-2 d-md-none">
                            <b-input-group>
                                <b-col cols="8" class="p-0">
                                    <b-form-select v-model="sortBy" :options="sortOptions">
                                        <option slot="first" :value="null">Select field to sort by...</option>
                                    </b-form-select>
                                </b-col>
                                <b-col class="p-0">
                                    <b-form-select :disabled="!sortBy" v-model="sortDesc" slot="append">
                                        <option :value="false">
                                            Asc
                                        </option>
                                        <option :value="true">
                                            Desc
                                        </option>
                                    </b-form-select>
                                </b-col>
                            </b-input-group>
                        </b-form-group>
                        <div class="w-100 table-responsive mt-4 mb-4 px-1">
                            <b-table 
                                stacked="md"
                                :items="associatedLeagues"
                                :fields="fields"
                                :current-page="currentPage"
                                :per-page="perPage"
                                :filter="filter"
                                :sort-by.sync="sortBy"
                                :sort-desc.sync="sortDesc"
                                :sort-direction="sortDirection"
                                @filtered="onFiltered"
                                show-empty
                                class="w-100 align-middle"
                            >
                                <template slot="empty" slot-scope="scope">
                                    <h4>{{ scope.emptyText }}</h4>
                                </template>
                                <template slot="emptyfiltered" slot-scope="scope">
                                    <h4>{{ scope.emptyFilteredText }}</h4>
                                </template>
                                <template slot="league_shortid" slot-scope="scope">
                                    <span @click.prevent="gotoLeagueDashboard(scope.item)" class="text-violet cursorPointer"><b>{{scope.item.league_shortid}}</b></span>
                                </template>
                                <template slot="profit_loss_percentage" slot-scope="scope">
                                    <span>{{Number((scope.item.profit_loss*100/(scope.item.contribution + Number(scope.item.profit_loss))).toFixed(2))}}%</span>
                                </template>
                            </b-table>
                        </div>
                        <b-row class="mx-auto">
                            <b-col class="w-100 my-1 mx-auto text-center b-pagination">
                                <b-pagination
                                    :total-rows="totalRowsCurrent"
                                    :per-page="perPage"
                                    v-model="currentPage"
                                    class="justify-content-center"
                                />
                            </b-col>
                        </b-row>
                    </b-container>
                </div>
            </div>
        </div>
        <hr/>
        <div class="p-5 mx-auto text-center bg-white">
            <div class="container">
                <h1 class="text-violet mt-1 mb-1">Upcoming Events</h1>
                <h4 class="text-violet mt-1 mb-1">Basis Your Preferences</h4>
                <a href="" class="text-violet"><h6 class="mt-1 mb-5">Click here to update your event preferences</h6></a>
                <div class="text-center mt-4 mb-5">
                    <div class="row mb-1">
                        <div class="col h3">
                            <a href="#" class="text-violet">Gavaskar-Border Trophy 2018</a> | <a href="#" class="text-violet">Cricket</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg mb-2">
                            <img src="/static/img/ipl.ef8e5c1.png" width="50px" height="50px" class="rounded border">
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Teams</span><br>
                            Austalia, England, India, Srilanka, Pakistan
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Dates</span><br>
                            28-June-2018 to 31-December-2018
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Venue</span><br>
                            Australia
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary"># Games</span><br>
                            72
                        </div>
                    </div>
                </div> 
            </div>
            <a href="" class="text-violet"><h6 class="mt-1 mb-5">Click here to discover all the upcoming tournaments</h6></a>
        </div>
    </div>
</template>

<script>
    import api from '@/services/api';
    import LoadingSpinner from '@/components/LoadingSpinner';
    export default {
        name: 'Home',
        components: {
            LoadingSpinner,
        },
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
                showLoadingIcon: false,
                total_contribution: 0.0,
                total_leagues_admin: 0,
                current_value: 0.0,
                total_profit_loss: 0.0,
                associatedLeagues: [],
                errors: [],
                fields: [
                    { key: 'league_shortid', label: 'League Id', sortable: true },
                    { key: 'league_name', label: 'League Name', sortable: true },
                    { key: 'tournament_name', label: 'Event', sortable: true },
                    { key: 'league_created_by', label: 'Admin', sortable: true },
                    { key: 'league_total_members', label: '#Players', sortable: true },
                    { key: 'contribution', label: 'Contribution', sortable: true },
                    { key: 'contribution', label: 'Current Value', sortable: true },
                    { key: 'profit_loss', label: 'P&L', sortable: true },
                    { key: 'profit_loss_percentage', label: 'P&L, %', sortable: true }
                ],
                currentPage: 1,
                perPage: 20,
                totalRowsCurrent: null,
                totalRowsPast: 20,
                pageOptions: [10, 20, 30, 40, 50, "Infinte Scroll"],
                sortBy: 'date',
                sortDesc: false,
                sortDirection: 'asc',
                filter: null
            }
        },
        computed: {
            sortOptions() {
                // Create an options list from our fields
                return this.fields
                .filter(f => f.sortable)
                .map(f => {
                    return { text: f.label, value: f.key }
                })
            }
        },        
        methods: {
            getAssociatedLeagues: function(shortid) {
                var self = this;
                self.showLoadingIcon = true;
                if (shortid) {
                    api().get('/profile/associatedLeagues', {
                        params: {
                            shortid: shortid
                        }
                    }).then(result => {
                        self.showLoadingIcon = false;
                            self.associatedLeagues = result.data.leagues;
                            self.associatedLeagues.filter(league=>{
                                league.contribution = league.tournament_total_games * parseFloat(league.league_minimum_bet);
                                self.total_contribution += (league.tournament_total_games * parseFloat(league.league_minimum_bet));
                                if(league.league_created_by == (self.userDetails.firstname + " " + self.userDetails.lastname)){
                                    self.total_leagues_admin += 1;
                                }
                
                
                            self.total_profit_loss += parseFloat(league.profit_loss);
                            self.current_value += (parseFloat(league.tournament_total_games * league.league_minimum_bet) + parseFloat(league.profit_loss));
                            });
                            self.totalRowsCurrent = self.associatedLeagues.length;
                        },
                        err => {
                            self.showLoadingIcon = false;
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
            onFiltered(filteredItems) {
                // Trigger pagination to update the number of buttons/pages due to filtering
                this.totalRows = filteredItems.length
                this.currentPage = 1
            }
        }
    }
</script>

<style>
    .text-bold {
        font-weight: bold;
    }
</style>