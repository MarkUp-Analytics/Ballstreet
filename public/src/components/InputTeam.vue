<template>
<div>
    <div class="text-center bg-light">
        <admin-menu></admin-menu>

        <div class="container-lg mx-auto">
            <h1 class="text-violet mt-5 mx-auto">Input</h1>
            <h4 class="text-violet mx-auto">Team</h4>
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
                            <input id="team_image" type="file" class="form-control-file" @change="processFile($event)">
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
                        <input class="form-control form-control-md mt-4 mb-3" type="text" v-model="filter" placeholder="Search for Teams/Players"/>
                            <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :items="teamList" :filter="filter" @filtered="onFiltered" :fields="fields">
                                <template slot="team_image" slot-scope="data">
                                    <img :src="data.item.team_image" class="rounded border mb-2" width="50px" height="50px" />
                                </template>
                                <template slot="edit" slot-scope="data">
                                    <a href="" @click.prevent="openDialog(data.item)">Edit</a>
                                    <div>
                                        <b-modal :id="'edit-modal-' + data.item.team_id" v-model="data.item.show" centered title="Edit Players / Teams">
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
                            <label>Choose Image</label>
                            <input id="team_image" type="file" class="form-control-file" @change="editTeamImage(editTeam, $event)">
                        </div>
                        <div class="form-group mt-4">
                            <label>Team/Player Name</label>
                            <input class="form-control" type="text" placeholder="Ex: India/Roger Federer" v-model="editTeam.team_name" />
                        </div>
                        <div class="form-group mt-4">
                            <label>Short Name</label>
                            <input class="form-control" type="text" placeholder="Ex: Ind/Aus" v-model="editTeam.team_abbreviation" />
                        </div>
                        
                    </form>
                                          <template slot="modal-footer">
                                                <div class="row">
                                                <div class="col-lg mt-4">
                                <a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="updateTeam(editTeam)">Save Changes</a><br/>    
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
    export default {
        name: 'InputTeam',
        components: {
            LoadingSpinner,
            AdminMenu
        },
         created() {
            this.getAllTeam();
            if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
            }
    
        },
        watch:{

        },
        data(){
            return{
                sortBy: 'team_name',
                sortDesc: false,
                currentPage: 1,
                perPage: 20,
                totalRows: 4,
                pageOptions: [25, 50, 75, 100, "Infinte Scroll"],
                sortDirection: 'desc',
                filter: null,
                fields: [
                    { key: 'team_name', label: 'Team Name', sortable: true },
                    { key: 'team_image', label: 'Team Image' },
                    { key: 'team_name', sortable: true },
                    { key: 'edit', label: 'Edit' },
                ],
                teamList: null,
                teamImage: null,
                teamName: null,
                teamShortName: null,
                showLoadingIcon: false,
                showSuccessMsg: false,
                showModal: false,
                editTeam: {
                    showModal: false
                },
                errors: [],
                editErrors: []
            }
        },
        methods:{
            onFiltered(filteredItems) {
                // Trigger pagination to update the number of buttons/pages due to filtering
                this.totalRows = filteredItems.length
                this.currentPage = 1
            },
            processFile: function(event) {
                this.teamImage = event.target.files[0];
            },
            editTeamImage: function(editTeam, event){
                editTeam.teamImage = event.target.files[0];
            },
            closeModal: function(item){
               item.show = false;
            },
            openDialog: function(item){
                this.editTeam.team_name = item.team_name;
                this.editTeam.team_abbreviation = item.team_abbreviation;
                this.editTeam.team_id = item.team_id;
                item.show = true;
            },
            saveTeam: function(){
                var self = this;
                this.errors = [];
                if(!this.teamImage || !this.teamName || !this.teamShortName){
                    this.errors.push("Required fields are missing");
                    return;
                }
                else if(this.teamShortName.length > 4){
                    this.errors.push("Short name cannot be greater than 4 characters");
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
            updateTeam: function(editTeam){
                var self = this;
                if(!editTeam.team_name || !editTeam.team_abbreviation){
                    self.editErrors = [];
                    self.editErrors.push("Team name or abbreviation cannot be empty");
                    return;
                }
                var duplicateTeam = self.teamList.filter(team=>{
                    if(team.team_id != editTeam.team_id && team.team_name.toLowerCase().trim() === editTeam.team_name.toLowerCase().trim()){
                        return team;
                    }
                });
                if(duplicateTeam.length > 0){
                    self.editErrors = [];
                    self.editErrors.push("Team name already exist");
                    return;
                }

                const formData = new FormData();
                var editWithImage = false;
                if(editTeam.teamImage){
                    formData.append('file', editTeam.teamImage, editTeam.teamImage.name);
                    editWithImage = true;
                }
                
                var team_details = {};
                team_details.team_name = editTeam.team_name;
                team_details.team_abbreviation = editTeam.team_abbreviation;
                team_details.team_id = editTeam.team_id;
                team_details.userid = this.userDetails.userid;
                formData.append('teamDetails', JSON.stringify(team_details));
                this.showLoadingIcon = true;
                if(editWithImage){
                    api().post('/team/updateTeamWithImage', formData, {
                        headers: {
                        'Content-Type': 'multipart/form-data'
                        }
                    }).then(result=>{
                        self.showLoadingIcon = false;
                        var oldTeamIndex = self.teamList.findIndex(team=> team.team_id == editTeam.team_id);
                        result.data.team.show = false;
                        self.closeModal(self.teamList[oldTeamIndex]);
                        self.teamList.splice(oldTeamIndex, 1, result.data.team);
                    },
                    err => {
                        this.showLoadingIcon = false;
                        this.editErrors = [];
                        this.editErrors.push(err.response.data.message);
                    })
                }
                else{
                    api().post('/team/updateTeamWithoutImage', team_details
                ).then(result=>{
                    self.showLoadingIcon = false;
                    var oldTeamIndex = self.teamList.findIndex(team=> team.team_id == editTeam.team_id);
                    result.data.team.show = false;
                    self.closeModal(self.teamList[oldTeamIndex]);
                    self.teamList.splice(oldTeamIndex, 1, result.data.team);
                },
                err => {
                    this.showLoadingIcon = false;
                    this.editErrors = [];
                    this.editErrors.push(err.response.data.message);
                })
                }
                
            },
            clearForm: function(){
                this.teamName = null;
                this.teamImage = null;
                document.getElementById('team_image').value= null;
                this.teamShortName = null;
            },
            getAllTeam: function(){
                this.showLoadingIcon = true;

                api().get('/team/getTeamsList')
                    .then(result=>{
                        this.showLoadingIcon = false;
                        result.data.teamList.filter(team=>{team.show = false}); // This is for edit modal
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