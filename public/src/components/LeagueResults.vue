<template>
    <div>
        <member-menu :league="$route.query.league" :memberInLeague="userIsLeagueMember"></member-menu>
        <div class="p-5 mx-auto text-center bg-light">
            <div class="container">
                <loading-spinner v-if="showLoadingIcon"></loading-spinner>
                <h1 class="text-violet mt-1 mb-5">Results</h1>
                
                <!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ModalPlayers">
                    Launch demo modal
                </button> -->

                <!-- Modal -->
                <!-- <div class="modal fade" id="ModalPlayers" tabindex="-1" role="dialog" aria-labelledby="ModalPlayersTitle" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-body">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h3>IND v SA</h3>
                                <h5>23-Jun-2019 15:00 Hrs | The Oval Cricket Ground (The Oval), Kennington</h5>
                                <hr class="mt-4 mb-3"/>
                                <div class="row">
                                    <div class="col-lg">
                                        <h4 class="mt-2 mb-0">Ind</h4>
                                        <h5 class="mt-0 mb-4">Supporters: 10</h5>
                                        <div class="">
                                            <p>Mithun S | mithsee@gmail.com</p>
                                            <p>Gowthaman Ilango | gilango@g.clemson.edu</p>
                                            <p>Shriram Kannusami | shriram.narayan66@gmail.com</p>
                                            <p>Suriya Manivannan | smsuriya@gmail.com</p>
                                            <p>Sikki Fazil | fazildan@gmail.com</p>
                                            <p>Rajeshwaran B | rajesh.koolll9@gmail.com</p>
                                            <p>Viwaswan bala | viwaswan90@gmail.com</p>
                                            <p>Mithun S | mithsee@gmail.com</p>
                                            <p>Gowthaman Ilango | gilango@g.clemson.edu</p>
                                            <p>Shriram Kannusami | shriram.narayan66@gmail.com</p>
                                            <p>Suriya Manivannan | smsuriya@gmail.com</p>
                                            <p>Sikki Fazil | fazildan@gmail.com</p>
                                            <p>Rajeshwaran B | rajesh.koolll9@gmail.com</p>
                                            <p>Viwaswan bala | viwaswan90@gmail.com</p>
                                            <p>Mithun S | mithsee@gmail.com</p>
                                            <p>Gowthaman Ilango | gilango@g.clemson.edu</p>
                                            <p>Shriram Kannusami | shriram.narayan66@gmail.com</p>
                                            <p>Suriya Manivannan | smsuriya@gmail.com</p>
                                            <p>Sikki Fazil | fazildan@gmail.com</p>
                                            <p>Rajeshwaran B | rajesh.koolll9@gmail.com</p>
                                            <p>Viwaswan bala | viwaswan90@gmail.com</p>
                                        </div>
                                    </div>
                                    <div class="col-lg">
                                        <h4 class="mt-2 mb-0">Ind</h4>
                                        <h5 class="mt-0 mb-4">Supporters: 10</h5>
                                        <div class="">
                                            <p>Mithun S | mithsee@gmail.com</p>
                                            <p>Gowthaman Ilango | gilango@g.clemson.edu</p>
                                            <p>Shriram Kannusami | shriram.narayan66@gmail.com</p>
                                            <p>Suriya Manivannan | smsuriya@gmail.com</p>
                                            <p>Sikki Fazil | fazildan@gmail.com</p>
                                            <p>Rajeshwaran B | rajesh.koolll9@gmail.com</p>
                                            <p>Viwaswan bala | viwaswan90@gmail.com</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div> -->
                
                <b-container fluid class="my-4 px-0">
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
                            :items="leagueResults"
                            :fields="fields"
                            :filter="filter"
                            :current-page="currentPage"
                            :per-page="perPage"
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
                            <template slot="match_fixture_start_date" slot-scope="data">
                                            <span>{{data.item.match_fixture_start_date | formatDate}}</span>
                                        </template>
                        </b-table>
                    </div>
                    <b-row class="mx-auto">
                        <b-col class="w-100 my-1 mx-auto text-center b-pagination">
                            <b-pagination
                                :total-rows="totalRows"
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
</template>

<script>
import api from '@/services/api';
import LoadingSpinner from '@/components/LoadingSpinner';
import MemberMenu from '@/components/MemberMenu';
    export default {
        name: 'LeagueResults',
     components:{
        LoadingSpinner,
        MemberMenu
    },
    created() {
        var self = this;
        if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
                
            }
            if(this.$route.query.league){
                self.showLoadingIcon = true;
                api().get('/league/getLeague', {
                    params:{
                        leagueShortId: this.$route.query.league
                    }
                }).then(result =>{
                    self.showLoadingIcon = false;
                    self.league = result.data.league;
                    self.memberBelongsToLeague();
                    self.showDetails = true;
                },
                err =>{
                    self.errors = [];
                    self.showLoadingIcon = false;
                    if(err.response.data.message){
                        self.errors.push(err.response.data.message);
                    }
                    else{
                        self.errors.push("Error getting league details");
                    }
                })
                
                
            }
            else{
                this.$router.push({
                    name: 'Home',
				});
            }
    },
        data() {
            return {
                userDetails: null,
                showLoadingIcon: false,
                userIsLeagueMember: false,
                league: null,
                errors: [],
                leagueResults: [],
                fields: [
                    { key: 'match_fixture_start_date', label: 'Date', sortable: true },
                    { key: 'stadium', label: 'Venue', sortable: true },
                    { key: 'team_a_abbreviation', label: 'Team A', sortable: true },
                    { key: 'team_b_abbreviation', label: 'Team B', sortable: true },
                    { key: 'team_a_supporters', label: 'A Supporters', sortable: true },
                    { key: 'team_b_supporters', label: 'B Supporters', sortable: true },
                    { key: 'match_result_abbreviation', label: 'Result', sortable: true },
                    { key: 'user_selection', label: 'Your Pick', sortable: true },
                    { key: 'profit_loss', label: 'P&L', sortable: true },
                ],
                sortBy: 'match_fixture_start_date',
                sortDesc: false,
                sortDirection: 'asc',
                filter: null,
                currentPage: 1,
                perPage: 20,
                totalRows: 40,
                pageOptions: [10, 20, 30, 40, 50, "Infinte Scroll"]
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
            onFiltered(filteredItems) {
                // Trigger pagination to update the number of buttons/pages due to filtering
                this.totalRows = filteredItems.length
                this.currentPage = 1
            },
            memberBelongsToLeague: function(){ //Method to check if the user is part of the league.
                var self = this;
                this.showLoadingIcon = true;
                    api().get('/league/memberInLeague', {
                    params: {
                            userId: this.userDetails.userid,
                            leagueId: this.league.league_id
                        }
                    }).then(result => {
                        self.showLoadingIcon = false;
                        self.userIsLeagueMember = result.data.memberBelongsToLeague;
                        if(self.userIsLeagueMember){
                            self.getLeagueMemberId(self.userDetails.userid, self.league.league_id);
                        }
                        else{
                            //send to dashboard
                            self.$router.push({
                                name: 'LeagueDashboard',
                                query:{
                                    league: self.league.league_shortid
                                }
				            });
                        }
                        
                    },
                    err => {
                        self.showLoadingIcon = false;
                        if(err.response.data.message){
                            self.errors.push(err.response.data.message);
                        }
                        else{
                            self.errors.push("Error getting league details");
                        }
                    })
            },
            getLeagueMemberId: function(userId, leagueId){
                var self = this;
                this.showLoadingIcon = true;
                api().get('/league/getLeagueMemberId',{
                    params: {
                        userId: userId,
                        leagueId: leagueId
                    }
                }).then(result => {
                    self.showLoadingIcon = false;
                    self.league.league_member_id = result.data.leagueMemberId;
                    
                    self.getLeagueResults(self.league.league_member_id, self.league.league_tournament_id);
                },
                err => {
                    self.showLoadingIcon = false;
                    if (err.response.data.message) {
                        self.errors.push(err.response.data.message);
                    } else {
                        self.errors.push("Error getting league member ID");
                    }
                });
        
            },
            getLeagueResults: function(leagueMemberId, tournamentId){
                var self = this;
                this.showLoadingIcon = true;
                    api().get('/league_member/getResults', {
                    params: {
                            leagueMemberId: leagueMemberId,
                            tournamentId: tournamentId
                        }
                    }).then(result => {
                        self.showLoadingIcon = false;
                        self.leagueResults = result.data.result;
                    },
                    err => {
                        self.showLoadingIcon = false;
                        if(err.response.data.message){
                            self.errors.push(err.response.data.message);
                        }
                        else{
                            self.errors.push("Error getting league results");
                        }
                    })
            },
            
        }
    }
</script>

<style>
</style>