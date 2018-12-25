<template>
    <div class="container bg-white py-5 px-5 shadow-sm w-95">
        <div v-if="upcomingTours && upcomingTours.length === 0">
        <div class="card bg-light">
            <div class="card-body">
                <b>No upcoming tours</b>
            </div>
        </div>
    </div>
    <div v-if="upcomingTours.length > 0">
    <h3 style="margin-bottom:15px;">Upcoming tournaments</h3>
    <table class="table table-border">
        <thead>
            <tr>
                <th></th>
                <th>
                    Tournament name
                </th>
                <th>
                    Sport name
                </th>
                <th>
                    Start date
                </th>
                <th>
                    End date
                </th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="(tour, index) in upcomingTours">
                <td>
                    {{index + 1}}
                </td>
                <td>
                    {{tour.tournament_name}}
                </td>
                <td>
                    {{tour.sport_name}}
                </td>
                <td>
                    {{tour.tournament_start_date | formatDate}}
                </td>
                <td>
                    {{tour.tournament_end_date | formatDate}}
                </td>
                <td>
                    <button title="click to create a new league for this tournament" @click="newLeagueDialog(tour)" class="btn btn-sm btn-success">Create League</button>
                </td>
            </tr>
        </tbody>
    </table>
    </div>
    <div v-if="newLeague" class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">New League</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
            <div class="row" style="margin-bottom:5px;">
                <div class="col-md-4" style="text-align: right;">
                    <label>Tournament:</label>
                </div>
                <div class="col-md-8">
                    <span>{{newLeague.tournament_name}}</span>
                </div>
            </div>
            <div class="row" style="margin-bottom:5px;">
                <div class="col-md-4" style="text-align: right;">
                <label>League Name:</label>
                </div>
                <div class="col-md-8">
                <input type="text" class="form-control" v-model="newLeague.league_name">
                </div>
            </div>
            <div class="row" style="margin-bottom:5px;">
                <div class="col-md-4" style="text-align: right;">
                <label>Minimum bet:</label>
                </div>
                <div class="col-md-8">
                <input type="number" class="form-control" v-model="newLeague.minimum_bet">
                </div>
            </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
            <button type="button" class="btn btn-success">Save</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
    </div>
</template>

<script>
import api from '@/services/api';
export default{
    name: 'NewLeague',
    created() {
        this.getTournamentList();
    },
    data() {
        return {
            upcomingTours:[],
            newLeague: {}
        }
    },
    methods: {
        getTournamentList: function(){
            api().get('/tournament/upcomingTournaments').then(result=>{
                this.upcomingTours = result.data.tours;
            },
            err=>{
                console.log(err)
            })
        },
        newLeagueDialog: function(tour){
            this.newLeague = {};
            this.newLeague.tournament_name = tour.tournament_name;
            $('#myModal').modal();
        }
    }
}

</script>

<style>

</style>