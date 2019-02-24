<template>
    <div>
        <div class="p-5 mx-auto text-center bg-light">
            <h1 class="text-violet mb-4">P&L</h1>            
            <div class="container h-100 py-2">
                <ul class="nav nav-pills nav-fill mt-3">
                    <li class="nav-item current-investments-pill">
                        <a class="nav-link active" data-toggle="tab" href="#current-investments-tab">Current P&L</a>
                    </li>
                    <li class="nav-item past-investments-pill">
                        <a class="nav-link" data-toggle="tab" href="#past-investments-tab">Past P&L</a>
                    </li>
                </ul>

                <div class="tab-content mt-4 mx-0 px-0">
                    <div class="tab-pane fade show active" id="current-investments-tab" role="tabpanel">                        
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
                                    :items="itemsCurrent"
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
                                </b-table>
                            </div>
                            <b-row class="mx-auto">
                                <b-col class="w-100 my-1 mx-auto text-center b-pagination">
                                    <b-pagination
                                        :total-rows="totalRowsCurrent"
                                        :per-page="perPage"
                                        v-model="currentPage"
                                        class="justify-content-center"
                                    />
                                </b-col>
                            </b-row>
                        </b-container>                        
                    </div>
                    <div class="tab-pane fade" id="past-investments-tab" role="tabpanel">
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
                                    :items="itemsPast"
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
                                </b-table>
                            </div>
                            <b-row class="mx-auto">
                                <b-col class="w-100 my-1 mx-auto text-center b-pagination">
                                    <b-pagination
                                        :total-rows="totalRowsPast"
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
        </div>
    </div>
</template>

<script>
    export default {
        name: 'p&l',
        data() {
            return {
                itemsCurrent: [
                    { tournament: 'Indian Premier League 2019', league: 'Amigos Indian XX IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Indian League 2019', league: 'Am IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Premier League 2019', league: 'Amigos IPL', date: '20/Mar/2019', owner: 'mithunsivagurunathan', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'League 2019', league: 'Amigos', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: '2019', league: 'IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Indian Premier League 2019', league: 'Amigos Indian XX IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Indian League 2019', league: 'Am IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Premier League 2019', league: 'Amigos IPL', date: '20/Mar/2019', owner: 'mithunsivagurunathan', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'League 2019', league: 'Amigos', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: '2019', league: 'IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Indian Premier League 2019', date: '20/Mar/2019', league: 'Amigos Indian XX IPL', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Indian League 2019', league: 'Am IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Premier League 2019', league: 'Amigos IPL', date: '20/Mar/2019', owner: 'mithunsivagurunathan', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'League 2019', league: 'Amigos', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: '2019', league: 'IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Indian Premier League 2019', league: 'Amigos Indian XX IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Indian League 2019', league: 'Am IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Premier League 2019', league: 'Amigos IPL', date: '20/Mar/2019', owner: 'mithunsivagurunathan', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'League 2019', league: 'Amigos', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: '2019', league: 'IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" }
                ],
                itemsPast: [
                    { tournament: 'Past Indian Premier League 2019', league: 'Amigos Indian XX IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Past Indian League 2019', league: 'Am IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Past Premier League 2019', league: 'Amigos IPL', date: '20/Mar/2019', owner: 'mithunsivagurunathan', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Past League 2019', league: 'Amigos', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" },
                    { tournament: 'Past 2019', league: 'IPL', date: '20/Mar/2019', owner: 'mithsi', capital: 100, current: 120, pl: "20%", link: "<a href='' class='text-violet'>Click</a>" }
                ],
                fields: [
                    { key: 'date', label: 'Date', sortable: true },
                    { key: 'tournament', label: 'Tournament', sortable: true },
                    { key: 'league', label: 'League', sortable: true },                    
                    { key: 'owner', label: 'Owner', sortable: true },
                    { key: 'capital', label: 'Capital', sortable: true },
                    { key: 'current', label: 'Current', sortable: true },
                    { key: 'pl', label: 'P&L', sortable: true },
                    { key: 'link', label: 'Link', sortable: true },
                ],
                currentPage: 1,
                perPage: 20,
                totalRowsCurrent: 40,
                totalRowsPast: 20,
                pageOptions: [10, 20, 30, 40, 50, "Infinte Scroll"],
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
    .nav-pills .current-investments-pill .nav-link:not(.active) {
        background-color: #fafafa;
        color: #462446;
    }

    .nav-pills .past-investments-pill .nav-link:not(.active) {
        background-color: #fafafa;
        color: #462446;
    }

    .nav-pills .current-investments-pill .nav-link {        
        background-color: #462446;
        color: #ffffff;
    }

    .nav-pills .past-investments-pill .nav-link {
        background-color: #462446;
        color: #ffffff;
    }
</style>