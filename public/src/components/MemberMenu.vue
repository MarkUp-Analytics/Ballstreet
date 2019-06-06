<template>
    <nav class="navbar navbar-light bg-white shadow-sm w-100 z-index-1000000 border-top">
            <div class=" px-5 mx-auto">
                <nav class="nav nav-secondary justify-content-center">
                    <a class="nav-link text-secondary" href="" @click.prevent="redirectPage('LeagueDashboard')">
                        <span class="" :class="{'textBold': $route.name === 'LeagueDashboard'}" title="Dashboard"><i class="fas fa-door-open"></i></span>
                        <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'LeagueDashboard'}">Dashboard</span>
                    </a>
                    <a class="nav-link text-secondary" :class="memberInLeague ? '' : 'disabled'" href="" @click.prevent="redirectPage('LeaguePreferences')">
                        <span class="" :class="{'textBold': $route.name === 'LeaguePreferences'}" title="Preferences"><i class="fas fa-th-list"></i></span>
                        <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'LeaguePreferences'}">Preferences</span>
                    </a>
                    <a class="nav-link text-secondary" :class="memberInLeague ? '' : 'disabled'" href="" @click.prevent="redirectPage('LeaguePicks')">
                        <span class="" :class="{'textBold': $route.name === 'LeaguePicks'}" title="Picks"><i class="fas fa-check-double"></i></span>
                        <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'LeaguePicks'}">Picks</span>
                    </a>
                    <a class="nav-link text-secondary" :class="memberInLeague ? '' : 'disabled'" href="" @click.prevent="redirectPage('LeagueResults')">
                        <span class="" :class="{'textBold': $route.name === 'LeagueResults'}" title="Results"><i class="fas fa-poll-h"></i></span>
                        <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'LeagueResults'}">Results</span>
                    </a>
                    <a class="nav-link text-secondary" :class="memberInLeague ? '' : 'disabled'" href="" @click.prevent="redirectPage('LeagueStatistics')">
                        <span class="" :class="{'textBold': $route.name === 'LeagueStatistics'}" title="Statistics"><i class="fas fa-chart-line"></i></span>
                        <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'LeagueStatistics'}">Statistics</span>
                    </a>
                    <a class="nav-link text-secondary" :class="memberInLeague ? '' : 'disabled'" href="" @click.prevent="redirectPage('LeaguePlayers')">
                        <span class="" :class="{'textBold': $route.name === 'LeaguePlayers'}" title="Players"><i class="fas fa-user-friends"></i></span>
                        <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'LeaguePlayers'}">Players</span>
                    </a>
                </nav>
            </div>
        </nav>
</template>

<script>
export default {
    name: 'MemberMenu',
    props:['league', 'memberInLeague'],
    created() {
        
    },
    data() {
        return {
            
        }
    },
    methods: {
        redirectPage: function(componentName){
            var self = this;
            if(componentName == 'LeagueDashboard'|| self.memberInLeague){
                    this.$router.push({
                    name: componentName,
                    query:{
                        league: self.league
                    }
			    })
            }
		},
    }
}

</script>

<style>

</style>