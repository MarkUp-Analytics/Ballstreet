<template>
    <div>
        <member-menu :league="$route.query.league" :memberInLeague="userIsLeagueMember"></member-menu>
        <div class="p-5 mx-auto text-center bg-light">
            <div class="container">
                <loading-spinner v-if="showLoadingIcon"></loading-spinner>
                <h1 class="text-violet mt-1 mb-5">Players</h1>

                <b-container fluid class="my-4 px-0">
                    <b-row class="my-0 py-0">
                        <b-col>
                            <b-form-group class="my-2">
                                <b-input-group>
                                    <b-form-input v-model="filter" placeholder="Type to Search" />
                                </b-input-group>
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
                            :items="leaguePlayers"
                            :fields="fields"
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
                            <template slot="league_member_joined_on" slot-scope="data">
                                            <span>{{data.item.league_member_joined_on | formatDate}}</span>
                            </template>
                        </b-table>
                    </div>
                </b-container>
            </div>
        </div>
        </div>
    </div>
</template>

<script>
import api from '@/services/api';
import LoadingSpinner from '@/components/LoadingSpinner';
import MemberMenu from '@/components/MemberMenu';
export default {
    name: 'LeaguePlayers',
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
                leaguePlayers: [],
                fields: [
                    { key: 'league_member_joined_on', label: 'Joined Date', sortable: true },
                    { key: 'league_member_name', label: 'Name', sortable: true },
                    { key: 'league_member_email', label: 'Email', sortable: true },
                ],
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
                            self.getLeaguePlayers(self.league.league_id);
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
            getLeaguePlayers: function(leagueId){
                var self = this;
                this.showLoadingIcon = true;
                    api().get('/league_member/getAllMembers', {
                    params: {
                            leagueId: leagueId
                        }
                    }).then(result => {
                        self.showLoadingIcon = false;
                        self.leaguePlayers = result.data.leagueMembers;
                    },
                    err => {
                        self.showLoadingIcon = false;
                        if(err.response.data.message){
                            self.errors.push(err.response.data.message);
                        }
                        else{
                            self.errors.push("Error getting league players");
                        }
                    })
            },
        }
    }
</script>

<style>
</style>