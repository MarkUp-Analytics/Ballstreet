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
                <h1 class="text-violet mx-auto">Report</h1>
                <h4 class="text-violet mx-auto mb-5">Acquisition</h4>
                
                <form>
                    <div class="form-row mt-5 mb-3">
                        <div class="col-sm">
                            <input type="text" class="form-control my-2" placeholder="From: DD/MM/YY">
                        </div>
                        <div class="col-sm">
                            <input type="text" class="form-control my-2" placeholder="To: DD/MM/YY">
                        </div>
                        <div class="col-sm">
                            <button class="btn btn-dark bg-violet w-100 my-2">Download</button>
                        </div>
                    </div>
                </form>
                <hr />
                <h6 class="mt-4 row">
                    <a href="#" class="text-violet col-sm px-1">
                        1D
                        <h4 class="text-dark">23</h4>
                    </a>
                    <a href="#" class="text-violet col-sm px-1">
                        3D
                        <h4 class="text-dark">123</h4>
                    </a>
                    <a href="#" class="text-violet col-sm px-1">
                        1W
                        <h4 class="text-dark">223</h4>
                    </a>
                    <a href="#" class="text-violet col-sm px-1">
                        2W
                        <h4 class="text-dark">323</h4>
                    </a>
                    <a href="#" class="text-violet col-sm px-1">
                        1M
                        <h4 class="text-dark">423</h4>
                    </a>
                    <a href="#" class="text-violet col-sm px-1">
                        3M
                        <h4 class="text-dark">523</h4>
                    </a>
                    <a href="#" class="text-violet col-sm px-1">
                        6M
                        <h4 class="text-dark">623</h4>
                    </a>
                </h6>
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
                    <b-row class="mx-auto">
                        <b-col class="w-100 mx-auto text-center b-pagination">
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
    export default {
        name: 'ReportAcquisition',
        data() {
            return {
                items: [
                    { date: "05/Mar/2019 10:30 Hrs", email: "mithsi@ballstreet.com",  name: "Mithun Sivagurunathan", source: "Google Search", campaignCode: "HXHS190202", campaignName: "20/Mar/2019 25/Apr/2019 - Diwali - Festival Lights", promoCode: "DIWALI50"
                    },
                ],
                fields: [
                    { key: 'date', label: 'Date', sortable: true },
                    { key: 'email', label: 'Email', sortable: true },
                    { key: 'name', label: 'Name', sortable: true },
                    { key: 'source', label: 'Source', sortable: true },
                    { key: 'campaignCode', label: 'Campaign Code', sortable: true },
                    { key: 'campaignName', label: 'Campaign Name', sortable: true },
                    { key: 'promoCode', label: 'Promo Code', sortable: true }
                ],
                currentPage: 1,
                perPage: 2,
                totalRows: 4,
                pageOptions: [25, 50, 75, 100, "Infinte Scroll"],
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
            }
        }
    }
</script>

<style>
</style>