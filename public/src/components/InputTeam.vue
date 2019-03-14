<template>
    <div class="text-center bg-light">
        <nav class="navbar sticky-top navbar-light bg-light shadow-sm w-100 z-index-3">
            <div class=" px-1 mx-auto">
                <nav class="nav nav-secondary justify-content-center">
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Team">Te</span>
                        <span class="d-none d-sm-block">Team</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Tournament">To</span>
                        <span class="d-none d-sm-block">Tournament</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Schedule">Sc</span>
                        <span class="d-none d-sm-block">Schedule</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Result">Re</span>
                        <span class="d-none d-sm-block">Result</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Acquisition">Ac</span>
                        <span class="d-none d-sm-block">Acquisition</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Transaction">Tr</span>
                        <span class="d-none d-sm-block">Transaction</span>
                    </a>
                </nav>
            </div>
        </nav>

        <div class="container-lg bg-light">
            <h1 class="text-violet">Input</h1>
            <h4 class="text-violet">Tournament</h4>
            <loading-spinner v-if="showLoadingIcon"></loading-spinner>
            <div class="row">
                <div class="col-lg-3 border-right mx-0 w-100">
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
                                <strong>Successfully created a team!</strong><br>
                            </span>
                            <button type="button" class="close" data-dismiss="alert" @click="showSuccessMsg = false;" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                    </div>
                    <form class="text-left pt-5 px-5">
                        <h4 class="text-violet mt-4">Create Players / Teams</h4>
                        <div class="form-group mt-4">
                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" /><br/>
                            <label>Choose Image</label>
                            <input type="file" class="form-control-file" @change="processFile($event)">
                        </div>
                        <div class="form-group mt-4">
                            <label>Team/Player Name</label>
                            <input class="form-control" type="text" placeholder="Ex: India/Roger Federer" v-model="teamName" />
                        </div>
                        <div class="form-group mt-4">
                            <label>Short Name</label>
                            <input class="form-control" type="text" placeholder="Ex: Ind/Aus" v-model="teamShortName" />
                        </div>
                        <div class="row">
                            <div class="col-lg mt-4">
                                <a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="saveTeam()">Save Changes</a><br/>
                            </div>
                        </div>
                        <div class="row text-center">
                            <div class="col-lg mt-2">
                                <a href="" class="text-violet mt-5" @click.prevent="clearForm()">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-lg-9 mx-0 w-100">
                    <section class="text-left pt-5 px-5">
                        <h4 class="text-violet mt-4">Created Players / Teams</h4>
                        <input class="form-control form-control-md mt-4 mb-3" type="text" placeholder="Search for Teams/Players"/>
                            <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :items="teamList" :fields="fields">
                                <template slot="teamImage" slot-scope="data">
                                    <img :src="data.item.team_image" class="rounded border mb-2" width="50px" height="50px" />
                                </template>
                                <template slot="edit" slot-scope="data">
                                    <a href="" @click.prevent="editTeam(data.item.team_id)">Edit</a>
                                </template>
                            </b-table>
                    </section>
                </div>
            </div>
        </div>
    </div>
              
</template>

<script>
import api from '@/services/api';
import commonServices from '@/services/commonServices';
import LoadingSpinner from '@/components/LoadingSpinner';
    export default {
        name: 'InputTeam',
        components: {
        	LoadingSpinner
        },
         created() {
            this.getAllTeam();
            if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
            }
    
        },
        data(){
            return{
                sortBy: 'team_name',
                sortDesc: false,
                fields: [
                    { key: 'teamImage', label: 'Team Image' },
                    { key: 'team_name', sortable: true },
                    { key: 'edit', label: 'Edit' },
                ],
                teamList: null,
                teamImage: null,
                teamName: null,
                teamShortName: null,
                showLoadingIcon: false,
                showSuccessMsg: false,
                errors: []
            }
        },
        methods:{
            processFile: function(event) {
                this.teamImage = event.target.files[0];
            },
            saveTeam: function(){
                var self = this;
                this.errors = [];
                if(!this.teamImage || !this.teamName || !this.teamShortName){
                    this.errors.push("Required fields are missing");
                    return;
                }
                else if(this.teamImage && this.teamImage.type.indexOf('image') == -1){
                    this.errors.push("You can upload only image file");
                    return;
                }
                else{
                    const formData = new FormData()
                    formData.append('file', this.teamImage, this.teamImage.name);
                    var team_details = {};
                    team_details.team_name = this.teamName;
                    team_details.team_abbreviation = this.teamShortName;
                    team_details.userid = this.userDetails.userid;
                    formData.append('teamDetails', JSON.stringify(team_details));
                    this.showLoadingIcon = true;
                    api().post('/team/createTeam', formData, {
                        headers: {
                            'Content-Type': 'multipart/form-data'
                        }
                        }).then(result=>{
                        self.showLoadingIcon = false;
                        self.teamList.push(result.data.team);
                        self.showSuccessMsg = true;
                        self.clearForm();
                    },
                    err => {
                        this.showLoadingIcon = false;
                        this.errors = [];
                        this.errors.push(err.response.data.message);
                    })
                }

            },
            clearForm: function(){
                this.teamName = null;
                this.teamImage = null;
                this.teamShortName = null;
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