<template>
    <div class="container bg-white py-5 px-3 shadow-sm w-95">
        <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100" role="alert">
            <span v-for="error in errors">
                        <strong>Error!</strong> {{error}}
    					</span>
            <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
    					<span aria-hidden="true">&times;</span>
    				</button>
        </div>
        <div v-if="associatedLeagues && associatedLeagues.length === 0">
            <div class="card bg-light">
                <div class="card-body">
                    <b>You are not associated with any league. You can create a new league or you can join your friend's league</b>
                </div>
            </div>
        </div>
    
        <div v-if="associatedLeagues.length > 0" class="w-100 overflow-x-auto mb-5">
            <table class="table table-md sortable">
                <thead>
                    <tr>
                        <th scope="col-2"><b>Game Id</b></th>
                        <th scope="col-2">League Name</th>
                        <th scope="col-2">Tournament</th>
                        <th scope="col-2">Value Per Game</th>
                        <th scope="col-2">Link</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(league, index) in associatedLeagues">
                        <td>
                            <span class="mb-2 text-bold text-yellow cursorPointer">{{league.league_shortid}} </span>
                        </td>
                        <td>
                            {{league.league_name}}
                        </td>
                        <td>
                            {{league.tournament_name}}
                        </td>
                        <td>
                            {{league.league_minimum_bet}}
                        </td>
                        <td>
                            <a href="#">Open</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="row" style="margin: 15px 0px;">
            <div class="col-lg-6 col-sm-6 col-6" style="padding: 0px;">
                <a href="#/create" class="btn btn-sm btn-info pull-left">Create New League</a>
            </div>
            <div class="col-lg-6 col-sm-6 col-6" style="padding: 0px;">
                <a href="" class="btn btn-sm btn-success pull-right">Join League</a>
            </div>
        </div>
    </div>
</template>

<script>
    import api from '@/services/api';
    export default {
        name: 'Profile',
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
        data: function() {
            return {
                userDetails: null,
                associatedLeagues: [],
                errors: []
            }
        },
        methods: {
            getAssociatedLeagues: function(shortid) {
                var self = this;
                if (shortid) {
                    api().get('/profile/associatedLeagues', {
                        params: {
                            shortid: shortid
                        }
                    }).then(result => {
                            self.associatedLeagues = result.data.leagues;
                        },
                        err => {
                            if (err.response.data.message) {
                                self.errors.push(err.response.data.message);
                            } else {
                                self.errors.push("Error creating associated leagues");
                            }
                        })
                }
            }
        }
    }
</script>

<style>
    .text-bold {
        font-weight: bold;
    }
</style>