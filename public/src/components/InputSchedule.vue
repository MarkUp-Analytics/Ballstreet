<template>
    <div>
        <div class="text-center bg-light">
            <admin-menu></admin-menu> 
            <div class="container-lg mx-auto">
                <h1 class="text-violet mt-5 mx-auto">Input</h1>
                <h4 class="text-violet mx-auto">Schedule</h4>
                <div class="row m-0 p-0">
                    
                    <loading-spinner v-if="showLoadingIcon"></loading-spinner>
                    <div class="col-lg-3 m-0 p-0">
                        <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100 mx-4 px-5 mb-4" role="alert">
                        <span v-for="error in errors">
                            <strong>Error!</strong> {{error}}<br>
                        </span>
                        <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div v-if="showSuccessMsg" class="alert alert-success alert-dismissible fade show w-100 mx-4 px-5 mb-4" role="alert">
                    <span>
                            <strong>Successfully created a schedule!</strong><br>
                        </span>
                        <button type="button" class="close" data-dismiss="alert" @click="showSuccessMsg = false;" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                </div>
                        <form class="text-left py-3 mb-5 px-5" id="tournament-create">
                            <h5 class="text-violet mt-4">Create Schedule</h5>
                            <div class="form-group mt-4">
                                <label>Tournament</label>
                                <v-select @change="updateTeamsList" v-model="selectedTour" :options="tournamentList" label="tournament_name"></v-select>
                            </div>
                            <div class="form-group mt-4">
                                <label>Team A</label>
                                <v-select :disabled="!selectedTour || teamsInTournamentList.length == 0" v-model="selectedTeamA" :options="teamsInTournamentList" label="team_abbreviation">
                                </v-select>
                            </div>
                            <div class="form-group mt-4">
                                <label>Team B</label>
                                <v-select :disabled="!selectedTour || teamsInTournamentList.length == 0" v-model="selectedTeamB" :options="teamsInTournamentList" label="team_abbreviation"></v-select>
                            </div>
                            <div class="form-group mt-4">
                                <label>From Date</label>
                                <datepicker v-model="startDate"></datepicker>
                            </div>
                            <div class="form-group mt-4">
                                <label>To Date</label>
                                <datepicker v-model="endDate"></datepicker>
                            </div>
                            <div class="form-group mt-4">
                                <label>Match Venue</label>
                                <v-select v-model="selectedVenue" :options="stadiumList" label="stadium_name">
                                </v-select>
                            </div>
                            <div class="form-group mt-4">
                                <label>Toss Time <span style="font-size:small">(Venue local time in 24 hrs format)</span></label>
                                <input style="display: inline; max-width:100px;" class="form-control" type="number" placeholder="Hour" v-model="tossHour" />
                                <input style="display: inline; max-width:100px;" class="form-control" type="number" placeholder="Minutes" v-model="tossMinutes" />
                            </div>
                            <div class="row">
                                <div class="col-lg mt-4">
                                    <a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="createSchedule()">Save</a><br/>
                                </div>
                            </div>
                            <div class="row text-center">
                                <div class="col-lg mt-2">
                                    <a href="" class="text-violet mt-5">Cancel</a>
                                </div>
                            </div>
                        </form>
                        <hr/>
                    </div>
                    <div class="col-lg-9 mx-0 px-0">
                        <section class="text-left py-3 mb-5 px-5" id="tournament-created">
                            <h5 class="text-violet mt-4">Created Schedule</h5>
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
                                        :items="scheduleList"
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
                                        <template slot="tournament_name" slot-scope="data">
                                            <span>{{data.item.tournament_name}}</span>
                                        </template>
                                        <template slot="match_fixture_start_date" slot-scope="data">
                                            <span>{{getDate(data.item.match_fixture_start_date, data.item.stadium_timezone) | formatDate}}</span>
                                        </template>
                                        <template slot="match_fixture_end_date" slot-scope="data">
                                            <span>{{getDate(data.item.match_fixture_end_date, data.item.stadium_timezone) | formatDate}}</span>
                                        </template>
                                        <template slot="team_a_abbreviation" slot-scope="data">
                                            <span>{{data.item.team_a_abbreviation ? data.item.team_a_abbreviation : "TBD"}}</span>
                                        </template>
                                        <template slot="team_b_abbreviation" slot-scope="data">
                                            <span>{{data.item.team_b_abbreviation ? data.item.team_b_abbreviation : "TBD"}}</span>
                                        </template>
                                        <template slot="match_venue" slot-scope="data">
                                            <span>{{data.item.match_venue}}</span>
                                        </template>
                                        <template slot="result" slot-scope="data">
                                            <a v-if="!data.item.winning_team && !data.item.no_result && !data.item.result_draw && data.item.team_a_abbreviation != null &&  data.item.team_b_abbreviation != null" href="" @click.prevent="inputResult(data.item)">Edit Result</a>

                                            <a v-if="data.item.team_a_abbreviation == null ||  data.item.team_b_abbreviation == null" href="" @click.prevent="openDialog(data.item)">Edit Schedule</a>

                                            <span v-if="data.item.winning_team || data.item.no_result || data.item.result_draw">{{data.item.winning_team_abbreviation}}</span>

                                            <div v-if="data.item.team_a_abbreviation == null ||  data.item.team_b_abbreviation == null">
                                                <b-modal :id="'edit-modal-' + data.item.match_fixture_id" v-model="data.item.show" centered title="Edit Schedule">
                                                    <div v-if="editErrors.length" class="alert alert-danger alert-dismissible fade show" role="alert">
                                                        <span v-for="error in editErrors">
                                                            <strong>Error!</strong> {{error}}<br>
                                                        </span>
                                                        <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <form class="text-left pt-5 px-5">
                                                        <div class="form-group mt-4">
                                                            <label><b>Tournament: </b></label>
                                                            <label v-if="editSchedule">{{editSchedule.tournament_name}}</label>
                                                        </div>
                                                        <div class="form-group mt-4">
                                                            <label><b>Team A: </b></label>
                                                            <v-select v-if="editSchedule" v-model="editSchedule.selectedTeamA" :options="editSchedule.teamsInTournamentList" label="team_abbreviation">
                                                            </v-select>
                                                        </div>
                                                        <div class="form-group mt-4">
                                                            <label><b>Team B: </b></label>
                                                            <v-select v-if="editSchedule" v-model="editSchedule.selectedTeamB" :options="editSchedule.teamsInTournamentList" label="team_abbreviation"></v-select>
                                                        </div>
                                                        <div class="form-group mt-4">
                                                            <label><b>From Date: </b></label>
                                                            <label v-if="editSchedule">{{editSchedule.match_fixture_start_date}}</label>
                                                        </div>
                                                        <div class="form-group mt-4">
                                                            <label><b>To Date: </b></label>
                                                            <label v-if="editSchedule">{{editSchedule.match_fixture_end_date}}</label>
                                                        </div>
                                                        <div class="form-group mt-4">
                                                            <label><b>Match Venue: </b></label>
                                                            <label v-if="editSchedule">{{editSchedule.stadium_name}}</label>
                                                        </div>
                                                    </form>
                                                    <template slot="modal-footer">
                                                        <div class="row">
                                                            <div class="col-lg mt-4">
                                                                <a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="updateSchedule(editSchedule)">Save Changes</a><br/>    
                                                            </div>
                                                        </div>
                                                        <div class="row text-center">
                                                            <div class="col-lg mt-2">
                                                                <a href="" class="text-violet mt-5" @click.prevent="closeModal(data.item)">Cancel</a>
                                                            </div>
                                                        </div>
                                                    </template>  
                                                </b-modal>
                                            </div>
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
                        </section>
                    </div>
                </div>
            </div>
        </div>
    </div>            
</template>

<script>
import api from '@/services/api';
import commonServices from '@/services/commonServices';
import LoadingSpinner from '@/components/LoadingSpinner';
import AdminMenu from '@/components/AdminMenu';
import Datepicker from 'vuejs-datepicker';
import { parse } from 'querystring';

    export default {
        name: 'InputSchedule',
        components: {
            LoadingSpinner,
            Datepicker,
            AdminMenu
        },
        created() {
            if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
            }
            this.getScheduleList();
            this.getTourList();
            this.getStadiumList();
        },
        data() {
            return {
                errors: [],
                userDetails: null,
                selectedTour: null,
                selectedTeamA: null,
                selectedTeamB: null,
                selectedVenue: null,
                tossHour: null,
                tossMinutes: null,
                stadiumList: [],
                teamsInTournamentList: [],
                showSuccessMsg: false,
                showLoadingIcon: false,
                startDate : null,
                endDate : null,
                venue : null,
                userid : null,
                tournamentList: [],
                scheduleList: [],
                editSchedule: {},
                filterTournament: null,
                editErrors: [],
                fields: [
                    { key: 'tournament_name', label: 'Tournament', sortable: true },
                    { key: 'match_fixture_start_date', label: 'Start Date', sortable: true },
                    { key: 'match_fixture_end_date', label: 'End Date', sortable: true },
                    { key: 'team_a_abbreviation', label: 'Team 1', sortable: true },
                    { key: 'team_b_abbreviation', label: 'Team 2', sortable: true },
                    { key: 'stadium_name', label: 'Venue', sortable: true },
                    { key: 'result', label: 'Result/Action', sortable: false },
                    
                ],
                currentPage: 1,
                perPage: 20,
                totalRows: 4,
                pageOptions: [25, 50, 75, 100, "Infinte Scroll"],
                sortBy: 'date',
                sortDesc: false,
                sortDirection: 'desc',
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
            inputResult: function(matchFixtureDetails){
				this.$router.push({
                    name: 'Input Result',
                    params:{
                        matchFixtureDetails: matchFixtureDetails
                    }
                    
				})
            },
            getDate: function(date, timeZone){
            var dateObj = new Date(new Date(date).toLocaleString("en-US", {timeZone: timeZone}));
            // var year = dateObj.getFullYear();
            // var month = dateObj.getMonth();
            // var date = dateObj.getDate();
            // var dateTimeString = year + "/" + month + "/" + date + " " + hr;
            // return dateTimeString;
            return dateObj;
            },
            getTimeStamp: function(hour, minutes){
                var hr = null;
                var mins = null;
                if(hour < 10){
                    hr = '0' + hour;
                }
                else{
                    hr = hour.toString();
                }
                if(minutes < 10){
                    mins = '0' + minutes;
                }
                else{
                    mins = minutes.toString();
                }
                return (hr + ":" + mins + ":00");

            },

            openDialog: function(item){
                var tour = this.tournamentList.find(tour=> tour.tournament_name.toLowerCase() == item.tournament_name.toLowerCase());
                this.getTeamList(tour.tournament_id).then(result=>{
                    this.editSchedule.teamsInTournamentList = result.data.teams;
                    this.editSchedule.match_fixture_id = item.match_fixture_id;
                    this.editSchedule.match_fixture_start_date = item.match_fixture_start_date;
                    this.editSchedule.match_fixture_end_date = item.match_fixture_end_date;
                    this.editSchedule.stadium_name = item.stadium_name;
                    this.editSchedule.tournament_id = item.tournament_id;
                    this.editSchedule.tournament_name = item.tournament_name;
                    this.editSchedule.selectedTeamA = {};
                    this.editSchedule.selectedTeamA = {};
                    this.editSchedule.team_a_id = item.team_a_id;
                    this.editSchedule.team_b_id = item.team_b_id;
                    this.editSchedule.team_a_abbreviation = item.team_a_abbreviation;
                    this.editSchedule.team_b_abbreviation = item.team_b_abbreviation;
                    item.show = true;
                });
                
            },

            createSchedule: function(){
                this.errors = [];
                if(!this.selectedTour || !this.selectedTeamA || !this.selectedTeamB || ! this.startDate || !this.endDate || !this.selectedVenue || !this.tossHour || !this.tossMinutes){
                    this.errors.push("Required fields are missing");
                    return;
                }
                if(this.selectedTeamA.team_id != -1 && (this.selectedTeamA.team_id === this.selectedTeamB.team_id)){ // Both the teams can be TBD if the schedule is not yet confirmed
                    console.log(this.selectedTeamA);
                    console.log(this.selectedTeamB);
                    this.errors.push("Please select different teams");
                    return;
                }
                if(this.startDate.getTime() > this.endDate.getTime()){
                    this.errors.push("Start date cannot be greater than end date");
                    return;
                }
                if(parseInt(this.tossHour) < 0 || parseInt(this.tossHour) > 23){
                    this.errors.push("Toss hour must be an integer between 0 - 23");
                    return;
                }
                if(parseInt(this.tossMinutes) < 0 || parseInt(this.tossMinutes) > 59){
                    this.errors.push("Toss minutes must be an integer between 0 - 59");
                    return;
                }
                this.showLoadingIcon = true;

                var matchFixtureDetails = {};
                matchFixtureDetails.tournamentId = this.selectedTour.tournament_id;
                //Save team as null if the selected team is TBD
                matchFixtureDetails.team1 = this.selectedTeamA.team_id == -1 ? null : this.selectedTeamA.team_id;
                matchFixtureDetails.team2 = this.selectedTeamB.team_id == -1 ? null : this.selectedTeamB.team_id;
                matchFixtureDetails.startDate = this.startDate;
                matchFixtureDetails.endDate = this.endDate;
                matchFixtureDetails.venue = this.selectedVenue.stadium_id;
                matchFixtureDetails.tossTime = this.getTimeStamp(this.tossHour, this.tossMinutes);
                matchFixtureDetails.userid = this.userDetails.userid;

                api().post('/fixtures/createSchedule', matchFixtureDetails)
                .then(result=>{
                        this.showLoadingIcon = false;
                        this.showSuccessMsg = true;
                        this.scheduleList.push(result.data.schedule);
                        this.clearInputFields();
                    },
                    err => {
                        this.showLoadingIcon = false;
                        this.errors = [];
                        this.errors.push(err.response.data.message);
                    })
            },

            getStadiumList: function(){
                var self = this;
                api().get('/stadium/getStadiumList').then(result => {
                        self.stadiumList = result.data.stadiumList;
                    },
                    err => {
                        this.errors = [];
                        this.errors.push(err.response.data.message);
                    })
            },
            getTourList: function(){
                var self = this;
                api().get('/tournament/allTournaments').then(result => {
                        self.tournamentList = result.data.tours;
                    },
                    err => {
                        this.errors = [];
                        this.errors.push(err.response.data.message);
                    })
            },
            getScheduleList: function(){
                var self = this;
                api().get('/fixtures/getAllMatchFixtures',{
                    params:{
                        userid: self.userDetails.userid
                    }
                }).then(result => {
                        result.data.scheduleList.filter(schedule=>{
                            schedule.show = false; // This is for edit modal
                        });
                        self.scheduleList = result.data.scheduleList;
                    },
                    err => {
                        this.errors = [];
                        this.errors.push(err.response.data.message);
                    })
            },
            getTeamList: function(tournamentId){
                return api().get('/tournament/playingTeams', {
                        params: {
                            tournamentId: tournamentId
                        }
                    });
            },
            updateTeamsList: function(tour){
                this.errors = [];
                this.teamsInTournamentList = [];
                this.selectedTeamA = null;
                this.selectedTeamB = null;
                if(tour){
                    var self = this;
                    // api().get('/tournament/playingTeams', {
                    //     params: {
                    //         tournamentId: tour.tournament_id
                    //     }
                    // }).then(result => {
                    //     result.data.teams.filter(team=>{
                    //         team.disabled = true;
                    //     });
                    //     self.teamsInTournamentList = result.data.teams;
                    //     self.teamsInTournamentList.push({ // To add TBD option in dropdown
                    //         team_id: -1,
                    //         team_abbreviation: "TBD",
                    //         team_name: "To Be Decided"
                    //     });
                    // },
                    // err => {
                    //     this.errors = [];
                    //     this.errors.push(err.response.data.message);
                    // })

                    self.getTeamList(tour.tournament_id).then(result => {
                        result.data.teams.filter(team=>{
                            team.disabled = true;
                        });
                        self.teamsInTournamentList = result.data.teams;
                        self.teamsInTournamentList.push({ // To add TBD option in dropdown
                            team_id: -1,
                            team_abbreviation: "TBD",
                            team_name: "To Be Decided"
                        });
                    },
                    err => {
                        this.errors = [];
                        this.errors.push(err.response.data.message);
                    })
                }
                
            },
            clearInputFields: function(){
                this.selectedTour = null;
                this.selectedTeamA = null;
                this.selectedTeamB = null;
                this.startDate = null;
                this.endDate = null;
                this.selectedVenue = null;
                this.tossHour = null;
                this.tossMinutes = null;
            },
        }
    }
</script>

<style>
    img {
        width: 50px;
        height: 50px;
        margin-bottom: 2;
        border-radius: 2px;
        border: 1px solid #dadada;
    }
</style>