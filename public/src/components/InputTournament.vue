<template>
    <div>
        <div class="text-center bg-light">
            <nav class="navbar sticky-top navbar-light bg-white shadow-sm w-100 z-index-3 border-top">
                <div class=" px-1 mx-auto">
                    <nav class="nav nav-secondary justify-content-center">
                        <a class="nav-link text-secondary b-0" href="#/inputteam">
                            <span class="d-sm-none" title="Team">Te</span>
                            <span class="d-none d-sm-block">Team</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/inputtournament">
                            <span class="d-sm-none" title="Tournament">To</span>
                            <span class="d-none d-sm-block">Tournament</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/inputschedule">
                            <span class="d-sm-none" title="Schedule">Sc</span>
                            <span class="d-none d-sm-block">Schedule</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/inputresult">
                            <span class="d-sm-none" title="Live">Re</span>
                            <span class="d-none d-sm-block">Result</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/reportacquisition">
                            <span class="d-sm-none" title="Acquisition">Ac</span>
                            <span class="d-none d-sm-block">Acquisition</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/reporthealth">
                            <span class="d-sm-none" title="Health">He</span>
                            <span class="d-none d-sm-block">Health</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/reporttransaction">
                            <span class="d-sm-none" title="reporttransaction">Tr</span>
                            <span class="d-none d-sm-block">Transaction</span>
                        </a>
                    </nav>
                </div>
            </nav> 
            <div class="container-lg mx-auto">
                <h1 class="text-violet mt-5 mx-auto">Input</h1>
                <h4 class="text-violet mx-auto">Tournament</h4>
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
                            <strong>Successfully created a tour!</strong><br>
                        </span>
                        <button type="button" class="close" data-dismiss="alert" @click="showSuccessMsg = false;" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                </div>
                        <form class="text-left py-3 mb-5 px-5" id="tournament-create">
                            <h5 class="text-violet mt-4">Create Tournament</h5>
                            <div class="form-group mt-4">
                                <label>Sport</label>
                                <select class="form-control" v-model="selectedSport">
                                    <option v-for="sport in sportsList" :value="sport">
                                        {{ sport.sport_name }}
                                    </option>
                                </select>
                            </div>
                            <div class="form-group mt-4">
                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" /><br/>
                            <label>Choose Image</label>
                            <input type="file" class="form-control-file" @change="processFile($event)">
                        </div>
                            <div class="form-group mt-4">
                                <label>Tournament Name</label>
                                <input class="form-control" type="text" placeholder="Ex: IPL 2018" v-model="tournamentName" />
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
                                <label>Tournament Venue</label>
                                <input class="form-control" type="text" placeholder="Ex: India" v-model="venue" />
                            </div>
                            <div class="form-group mt-4">
                                <label># Games</label>
                                <input class="form-control" type="number" placeholder="No. of Games" v-model="totalGames" />
                            </div>
                            <div class="form-group mt-4">
                                <label>Teams</label>
                                <v-select v-if="teamList && teamList.length > 0" multiple v-model="selectedTeams" :options="teamList" label="team_abbreviation"></v-select>
                            </div>
                            <div class="row">
                                <div class="col-lg mt-4">
                                    <a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="createTournament()">Save</a><br/>
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
                            <h5 class="text-violet mt-4">Created Tournament</h5>
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
                                        :items="tournamentList"
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
                                        <template slot="Link" slot-scope="scope">
                                            <a href="">Link</a>
                                        </template>
                                        <template slot="tourImage" slot-scope="data">
                                    <img :src="data.item.tourImage" class="rounded border mb-2" width="50px" height="50px" />
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
import Datepicker from 'vuejs-datepicker';

    export default {
        name: 'InputTournament',
        components: {
            LoadingSpinner,
            Datepicker,
        },
        created() {
            this.getAllTeam();
            this.getSportList();
            this.getTourList();
            if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
            }
    
        },
        data() {
            return {
                errors: [],
                userDetails: null,
                teamList: null,
                selectedTeams: [],
                selectedSport: null,
                sportsList: [],
                showSuccessMsg: false,
                showLoadingIcon: false,
                tournamentName: null,
                sportId : null,
                startDate : null,
                endDate : null,
                venue : null,
                userid : null,
                totalGames : null,
                tourImage:null,
                tournamentList: null,
                fields: [
                    { key: 'tournament_created_on', label: 'Date Created', sortable: true },
                    { key: 'tourImage', label: 'Image', sortable: true },
                    { key: 'tournament_name', label: 'Tournament', sortable: true },
                    'Link'
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

            processFile: function(event) {
                this.tourImage = event.target.files[0];
            },

            createTournament: function(){
                this.errors = [];
                if(!this.tournamentName || !this.selectedSport || ! this.startDate || !this.endDate || !this.venue || !this.totalGames || !this.selectedTeams){
                    this.errors.push("Required fields are missing");
                    return;
                }
                if(this.startDate.getTime() > this.endDate.getTime()){
                    this.errors.push("Start date cannot be greater than end date");
                    return;
                }
                if(this.selectedTeams.length < 2){
                    this.errors.push("Must select atleast 2 teams to create a tournament");
                    return;
                }
                if(this.totalGames < 1){
                    this.errors.push("Total games must be atleast 1");
                    return;
                }
                if(this.tourImage && this.tourImage.type.indexOf('image') == -1){
                    this.errors.push("You can upload only image file");
                    return;
                }
                this.showLoadingIcon = true;

                var tourDetails = {};
                const formData = new FormData()
                formData.append('file', this.tourImage, this.tourImage.name);
                tourDetails.tournamentName = this.tournamentName;
                tourDetails.sportId = this.selectedSport.sport_id;
                tourDetails.startDate = this.startDate;
                tourDetails.endDate = this.endDate;
                tourDetails.venue = this.venue;
                tourDetails.userid = this.userDetails.userid;
                tourDetails.totalGames = this.totalGames;
                tourDetails.teams = this.selectedTeams.map(team=>{ return team.team_id;});
                formData.append('tourDetails', JSON.stringify(tourDetails));

                api().post('/tournament/createTournament', formData)
                .then(result=>{
                        this.showLoadingIcon = false;
                        this.showSuccessMsg = true;
		                console.log(result.data.message);
                        
                    },
                    err => {
                        this.showLoadingIcon = false;
                        this.errors = [];
                        this.errors.push(err.response.data.message);
                    })
            },

            getAllTeam: function(){
                this.showLoadingIcon = true;

                api().get('/team/getTeamsList')
                    .then(result=>{
                        this.showLoadingIcon = false;
                        this.teamList = result.data.teamList;
                    },
                    err => {
                        this.showLoadingIcon = false;
                        this.errors = [];
                        this.errors.push(err.response.data.message);
                    })
            },
            getSportList: function() {
                var self = this;
                api().get('/sport/getSportsList').then(result => {
                        self.sportsList = result.data.sports;
                    },
                    err => {
                        console.log(err)
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
            }
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