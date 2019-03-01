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
                    <div class="col-lg-3 m-0 p-0">
                        <form class="text-left py-3 mb-5 px-5" id="tournament-create">
                            <h5 class="text-violet mt-4">Create Tournament</h5>
                            <div class="form-group mt-4">
                                <img src="../../static/assets/images/IPL.png" /><br/>
                                <label class="mt-2">Choose Image</label>
                                <input type="file" class="form-control-file">
                            </div>
                            <div class="form-group mt-4">
                                <label>Tournament Name</label>
                                <input class="form-control" type="email" placeholder="Ex: IPL 2018" value="IPL 2018" />
                            </div>
                            <div class="form-group mt-4">
                                <label>From Dates</label>
                                <input class="form-control" type="email" placeholder="DD/MMM/YYYY: 29/Apr/2018" value="29/Apr/2018" />
                            </div>
                            <div class="form-group mt-4">
                                <label>To Dates</label>
                                <input class="form-control" type="email" placeholder="DD/MMM/YYYY: 29/Apr/2018" value="29/Apr/2018" />
                            </div>
                            <div class="form-group mt-4">
                                <label># Games</label>
                                <input class="form-control" type="email" placeholder="No. of Games" value="32" />
                            </div>
                            <div class="form-group mt-4">
                                <label>Teams</label>
                                <input class="form-control" type="email" placeholder="Multi-select Teams" value="A, B, C" />
                            </div>
                            <div class="row">
                                <div class="col-lg mt-4">
                                    <a href="" class="btn btn-dark bg-violet border-0 w-100">Save</a><br/>
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
    export default {
        name: 'InputTournament',
        data() {
            return {
                items: [
                    { date: "18/Mar/1990 11:30 Hrs", image: "<img src='../../static/assets/images/IPL.png' />", tournament: 'Indian Premier League 2019', link: "<a href='' class='text-violet'>Click</a>" },
                    { date: "18/Mar/1990 12:30 Hrs", image: "<img src='../../static/assets/images/IPL.png' />", tournament: 'IPL 2019', link: "<a href='' class='text-violet'>Click</a>" },
                    { date: "18/Mar/1990 13:30 Hrs", image: "<img src='../../static/assets/images/IPL.png' />", tournament: 'Premier League 2019', link: "<a href='' class='text-violet'>Click</a>" },
                    { date: "18/Mar/1990 01:30 Hrs", image: "<img src='../../static/assets/images/IPL.png' />", tournament: 'League 2019', link: "<a href='' class='text-violet'>Click</a>" }
                ],
                fields: [
                    { key: 'date', label: 'Date Created', sortable: true },
                    { key: 'image', label: 'Image', sortable: true },
                    { key: 'tournament', label: 'Tournament', sortable: true },
                    { key: 'link', label: 'Link', sortable: true },
                ],
                currentPage: 1,
                perPage: 2,
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