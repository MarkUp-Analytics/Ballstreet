<template>
    <div>
        <nav class="navbar navbar-light bg-light shadow-sm w-100 z-index-3">
            <div class=" px-5 mx-auto">
                <nav class="nav nav-secondary justify-content-center">
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Dashboard">Dash</span>
                        <span class="d-none d-sm-block">Dashboard</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Preferences">Pref</span>
                        <span class="d-none d-sm-block">Preferences</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Results">Resu</span>
                        <span class="d-none d-sm-block">Results</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Statistics">Stat</span>
                        <span class="d-none d-sm-block">Statistics</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Statistics">Play</span>
                        <span class="d-none d-sm-block">Players</span>
                    </a>
                </nav>
            </div>
        </nav>
        <div class="p-5 mx-auto text-center bg-light">
            <div class="container">
                <h1 class="text-violet mt-1 mb-5">Results</h1>
                
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
                            :items="items"
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
                        </b-table>
                    </div>
                </b-container>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'Page7',
        data() {
            return {
                items: [
                    { date: "20/Mar/2019 12:30 Hrs", venue: "Chinnaswamy Stadium, Chennai", A: "Chennai Super Kings", B: "Royal Challengers Bangalore", aSupporters: "43", bSupporters: "55", result: "Chennai Super Kings", pick: "Chennai Super Kings", pl: "-43%" },
                    { date: "20/Mar/2019 12:30 Hrs", venue: "Chinnaswamy Stadium, Chennai", A: "Chennai Super Kings", B: "Mumbai Indians", aSupporters: "43", bSupporters: "55", result: "Chennai Super Kings", pick: "Chennai Super Kings", pl: "-43%" },
                ],
                fields: [
                    { key: 'date', label: 'Date', sortable: true },
                    { key: 'venue', label: 'Venue', sortable: true },
                    { key: 'A', label: 'A', sortable: true },
                    { key: 'B', label: 'B', sortable: true },
                    { key: 'aSupporters', label: 'A Supporters', sortable: true },
                    { key: 'bSupporters', label: 'B Supporters', sortable: true },
                    { key: 'result', label: 'Result', sortable: true },
                    { key: 'pick', label: 'Your Pick', sortable: true },
                    { key: 'pl', label: 'P&L', sortable: true },
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
</style>