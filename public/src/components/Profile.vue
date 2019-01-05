<template>
<div class="container bg-white py-5 px-5 shadow-sm w-95">
    <div v-if="associatedLeagues && associatedLeagues.length === 0">
        <div class="card bg-light">
            <div class="card-body">
                <b>You are not associated with any league. You can create a new league or you can join your friend's league</b>
            </div>
        </div>
        <div class="row" style="margin: 15px 0px;">
            <div class="col-lg-6 col-sm-6 col-6" style="padding: 0px;">
                <a href="#/newLeague" class="btn btn-sm btn-info pull-left">Create New League</a>
            </div>
            <div class="col-lg-6 col-sm-6 col-6" style="padding: 0px;">
                <a href="" class="btn btn-sm btn-success pull-right">Join League</a>
            </div>
        </div>
    </div>
    <table v-if="associatedLeagues.length > 0" class="table table-border">
        <thead>
            <tr>
                <th></th>
                <th>
                    League name
                </th>
                <th>
                    Created Date
                </th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="(league, index) in associatedLeagues">
                <td>
                    {{index + 1}}
                </td>
                <td>
                    {{league.league_name}}
                </td>
                <td>
                    {{league.league_created_on | formatDate}}
                </td>
            </tr>
        </tbody>
    </table>
</div>
</template>

<script>
import api from '@/services/api';
export default{
    name: 'Profile',
    created() {
        if(localStorage.getItem('userDetails')){
            this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
            this.getAssociatedLeagues(this.userDetails.shortid);
        }
        else{
            this.$router.push({
                name: 'Login', 
            })
        }
        
    },
    data: function(){
        return{
            userDetails: null,
            associatedLeagues: []
        }
    },
    methods:{
        getAssociatedLeagues: function(shortid){
            var self = this;
            if(shortid){
                api().get('/profile/associatedLeagues', {
                    params: {
                        shortid: shortid
                    }
                }).then(result=>{
                    self.associatedLeagues = result.data.leagues;
                },
                err=>{
                    console.log(err);
                })
            }
        }
    }
}
</script>

<style>

</style>