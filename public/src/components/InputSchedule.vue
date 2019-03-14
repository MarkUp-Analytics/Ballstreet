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
            <div class="container mx-auto bg-light p-5">
                <h1 class="text-violet mx-auto">Input</h1>
                <h4 class="text-violet mx-auto mb-5">Schedule</h4>
                
                <div class="w-100 table-responsive mt-4 py-0 px-1">
                    <table class="table" id="edit-schedule">
                        <thead>
                            <tr class="text-violet">
                                <th scope="col">Date</th>
                                <th scope="col">Time</th>
                                <th scope="col">Team A</th>
                                <th scope="col">Team B</th>
                                <th scope="col">Venue</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="align-middle">
                                    <div class="form-group my-0 py-0">
                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <div class="form-group my-0 py-0">
                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <div class="form-group my-0 py-0">
                                        <select class="form-control my-0 py-0">
                                            <option>Argentina</option>
                                            <option>England</option>
                                        </select>
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <div class="form-group my-0 py-0">
                                        <select class="form-control my-0 py-0">
                                            <option>Argentina</option>
                                            <option>England</option>
                                        </select>
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <div class="form-group my-0 py-0">
                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-middle">
                                    <div class="form-group my-0 py-0">
                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <div class="form-group my-0 py-0">
                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <div class="form-group my-0 py-0">
                                        <select class="form-control my-0 py-0">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <div class="form-group my-0 py-0">
                                        <select class="form-control my-0 py-0">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <div class="form-group my-0 py-0">
                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                    </div>
                                </td>
                            </tr>
                        </tbody>                            
                    </table>                      
                </div>
                <div class="row mt-2 mx-0 px-0">
                    <div class="col-lg">
                    </div>
                    <div class="col-lg">
                        <div class="row">
                            <div class="col-lg">
                                <a href="" class="btn btn-dark bg-violet border-0 w-100">Save Changes</a><br/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg mt-2">
                                <a href="" class="text-violet mt-5">Cancel</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg">
                    </div>
                </div> 
            </div>
            <hr />
            <div class="container-lg mx-auto bg-light p-5">
                <b-container fluid  class="pb-5 px-0 pt-0 m-0">
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
                            :items="items"
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
                            <span slot="link" slot-scope="data" v-html="data.value" />
                            <span slot="image" slot-scope="data" v-html="data.value" />
                        </b-table>
                    </div>
                </b-container>
            </div>
        </div>
    </div>            
</template>

<script>
    export default {
        name: 'InputSchedule',
        data() {
            return {
                items: [
                    { image: "<img src='../../static/assets/images/IPL.png' class='rounded border mb-2' width='25px' height='25px' />", tournament: "Indian Premier League 2019", from: "29/Mar/2019", to: "30/Mar/2019", games: "52", teams: "Pune Super Warriors, Chennai Super Kings, Royal Challengers Bangalore, Punjab Lions", link: "<a href='' class='text-violet'>Click</a>" },
                    { image: "<img src='../../static/assets/images/IPL.png' class='rounded border mb-2' width='25px' height='25px' />", tournament: "Indian Premier League 2019", from: "29/Mar/2019", to: "30/Mar/2019", games: "52", teams: "Royal Challengers Bangalore, Punjab Lions", link: "<a href='' class='text-violet'>Click</a>" },
                    { image: "<img src='../../static/assets/images/IPL.png' class='rounded border mb-2' width='25px' height='25px' />", tournament: "Indian Premier League 2019", from: "29/Mar/2019", to: "30/Mar/2019", games: "52", teams: "Punjab Lions", link: "<a href='' class='text-violet'>Click</a>" },
                    { image: "<img src='../../static/assets/images/IPL.png' class='rounded border mb-2' width='25px' height='25px' />", tournament: "Indian Premier League 2019", from: "29/Mar/2019", to: "30/Mar/2019", games: "52", teams: "Royal Challengers Bangalore, Chennai Super Kings, Punjab Lions", link: "<a href='' class='text-violet'>Click</a>" },
                ],
                fields: [
                    { key: 'image', label: 'Image', sortable: true },
                    { key: 'tournament', label: 'Tournament', sortable: true },
                    { key: 'from', label: 'From', sortable: true },
                    { key: 'to', label: 'To', sortable: true },
                    { key: 'games', label: '#Games', sortable: true },
                    { key: 'teams', label: 'Teams', sortable: true },
                    { key: 'link', label: 'Link', sortable: true },
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
        }
    }
</script>

<style>
    .table th, .table td {
        min-width: 150px;
    }
</style>