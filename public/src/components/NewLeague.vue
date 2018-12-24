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
                    <a href="" title="click to create a new league for this tournament" class="btn btn-sm btn-success">Create League</a>
                </td>
            </tr>
        </tbody>
    </table>
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
            upcomingTours:[]
        }
    },
    methods: {
        getTournamentList: function(){
            api().get('/tournament/upcomingTournaments').then(result=>{
                this.upcomingTours = result.data.tours;
            },
            err=>{

            })
        }
    }
}

</script>

<style>

</style>