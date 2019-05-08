<template>
    <nav class="navbar navbar-light bg-light shadow-sm w-100 z-index-3">
            <div class=" px-5 mx-auto">
                <nav class="nav nav-secondary justify-content-center">
                    <a class="nav-link text-secondary" href="" @click.prevent="redirectPage('LeagueDashboard')">
                        <span class="d-sm-none" :class="{'textBold': $route.name === 'LeagueDashboard'}" title="Dashboard">Dash</span>
                        <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'LeagueDashboard'}">Dashboard</span>
                    </a>
                    <a class="nav-link text-secondary" :class="memberInLeague ? '' : 'disabled'" href="" @click.prevent="redirectPage('LeaguePreferences')">
                        <span class="d-sm-none" :class="{'textBold': $route.name === 'LeaguePreferences'}" title="Preferences">Pref</span>
                        <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'LeaguePreferences'}">Preferences</span>
                    </a>
                    <a class="nav-link text-secondary" :class="memberInLeague ? '' : 'disabled'" href="" @click.prevent="redirectPage('LeagueResults')">
                        <span class="d-sm-none" :class="{'textBold': $route.name === 'LeagueResults'}" title="Results">Resu</span>
                        <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'LeagueResults'}">Results</span>
                    </a>
                    <a class="nav-link text-secondary" :class="memberInLeague ? '' : 'disabled'" href="" @click.prevent="redirectPage('LeagueStatistics')">
                        <span class="d-sm-none" :class="{'textBold': $route.name === 'LeagueStatistics'}" title="Statistics">Stat</span>
                        <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'LeagueStatistics'}">Statistics</span>
                    </a>
                    <a class="nav-link text-secondary" :class="memberInLeague ? '' : 'disabled'" href="" @click.prevent="redirectPage('LeaguePlayers')">
                        <span class="d-sm-none" :class="{'textBold': $route.name === 'LeaguePlayers'}" title="Players">Play</span>
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