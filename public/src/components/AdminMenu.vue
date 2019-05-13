<template>
    <nav class="navbar sticky-top navbar-light bg-white shadow-sm w-100 z-index-3 border-top">
                <div class=" px-1 mx-auto">
                    <nav class="nav nav-secondary justify-content-center">
                        <a class="nav-link text-secondary b-0" href="" @click.prevent="redirectPage('Input Team')">
                            <span class="d-sm-none" :class="{'textBold': $route.name === 'Input Team'}" title="Team">Te</span>
                            <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'Input Team'}">Team</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="" @click.prevent="redirectPage('Input Tournament')">
                            <span class="d-sm-none" :class="{'textBold': $route.name === 'Input Tournament'}" title="Tournament">To</span>
                            <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'Input Tournament'}">Tournament</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="" @click.prevent="redirectPage('Input Schedule2')">
                            <span class="d-sm-none" :class="{'textBold': $route.name === 'Input Schedule2'}" title="Schedule">Sc</span>
                            <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'Input Schedule2'}">Schedule</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="" @click.prevent="redirectPage('Input Result')">
                            <span class="d-sm-none" :class="{'textBold': $route.name === 'Input Result'}" title="Live">Re</span>
                            <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'Input Result'}">Result</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="" @click.prevent="redirectPage('Report Acquisition')">
                            <span class="d-sm-none" :class="{'textBold': $route.name === 'Report Acquisition'}" title="Acquisition">Ac</span>
                            <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'Report Acquisition'}">Acquisition</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="" @click.prevent="redirectPage('Report Health')">
                            <span class="d-sm-none" :class="{'textBold': $route.name === 'Report Health'}" title="Health">He</span>
                            <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'Report Health'}">Health</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="" @click.prevent="redirectPage('Report Transaction')">
                            <span class="d-sm-none" :class="{'textBold': $route.name === 'Report Transaction'}" title="reporttransaction">Tr</span>
                            <span class="d-none d-sm-block" :class="{'textBold': $route.name === 'Report Transaction'}">Transaction</span>
                        </a>
                    </nav>
                </div>
            </nav> 
</template>

<script>
export default{
    name: 'AdminMenu',
    data() {
        return {
            
        }
    },
    methods: {
        redirectPage: function(componentName){
				this.$router.push({
					name: componentName,
				})
			},
    }
}

</script>

<style>

</style>