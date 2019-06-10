<template>
    <div>
        <div class="p-5 mx-auto text-center bg-light">
            <h1 class="text-violet mb-4">P&L</h1>            
            <div class="container h-100 py-2">
                <loading-spinner v-if="showLoadingIcon"></loading-spinner>
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
                                    <template slot="link" slot-scope="scope">
                                        <a href="" @click.prevent="gotoLeagueDashboard(scope.item)" class="text-violet">Click</a>
                                    </template>
                                    <template slot="profit_loss_percentage" slot-scope="scope">
                                    <span>{{Number((scope.item.profit_loss*100/(scope.item.current_value)).toFixed(2))}}%</span>
                                </template>
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
    import api from '@/services/api';
    import LoadingSpinner from '@/components/LoadingSpinner';
    export default {
        name: 'PandL',
        components: {
            LoadingSpinner,
        },
        created() {
            if (localStorage.getItem('userDetails')) {
                this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
                this.getAssociatedLeagues(this.userDetails.shortid);
            } else {
                this.$router.push({
                    name: 'Index',
                })
            }
    
        },
        data() {
            return {
                userDetails: null,
                associatedLeagues: [],
                errors: [],
                showLoadingIcon: false,
                itemsCurrent: [],
                itemsPast: [],
                fields: [
                    { key: 'league_shortid', label: 'League Id', sortable: true },
                    { key: 'league_name', label: 'League Name', sortable: true },
                    { key: 'tournament_name', label: 'Event', sortable: true },                    
                    { key: 'league_created_by', label: 'Admin', sortable: true },
                    { key: 'capital', label: 'Contribution', sortable: true },
                    { key: 'current_value', label: 'Current Value', sortable: true },
                    { key: 'profit_loss', label: 'P&L', sortable: true },
                    { key: 'profit_loss_percentage', label: 'P&L, %', sortable: true },
                ],
                currentPage: 1,
                perPage: 20,
                totalRowsCurrent: null,
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
            },

            getAssociatedLeagues: function(shortid) {
                var self = this;
                self.showLoadingIcon = true;
                if (shortid) {
                    api().get('/profile/associatedLeagues', {
                        params: {
                            shortid: shortid
                        }
                    }).then(result => {
                            self.showLoadingIcon = false;
                            self.itemsCurrent = result.data.leagues;
                            self.itemsCurrent.filter(league=>{
                                league.capital = (league.tournament_total_games * parseFloat(league.league_minimum_bet));
                                league.profit_loss = parseFloat(league.profit_loss);
                                league.current_value = (parseFloat(league.tournament_total_games * league.league_minimum_bet) + parseFloat(league.profit_loss));
                            });
                            self.totalRowsCurrent = self.itemsCurrent.length;
                        },
                        err => {
                            sel.showLoadingIcon = false;
                            if (err.response.data.message) {
                                self.errors.push(err.response.data.message);
                            } else {
                                self.errors.push("Error creating associated leagues");
                            }
                        })
                }
            },
            gotoLeagueDashboard: function(league){
				this.$router.push({
                    name: 'LeagueDashboard',
                    query:{
                        league: league.league_shortid
                    }
                    
				})
            },
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