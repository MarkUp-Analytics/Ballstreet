<template>
    <div>
        <div class="row p-5 mx-auto text-center container">
            <div class="col-md-3">
                <div class="nav flex-column nav-pills mb-5" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                    <a href="#/getstarted/" :class="$route.name === 'AboutBallstreet' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">About Ballstreet</a>
                    <a href="#/getstarted/howBallstreetWorks" :class="$route.name === 'HowBallstreetWorks' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">How Ballstreet Works</a>
                    <a href="#/getstarted/gamesOfSkill" :class="$route.name === 'GamesOfSkill' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Games Of Skill</a>
                    <a href="#/getstarted/features" :class="$route.name === 'Features' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Features</a>
                    <a href="#/getstarted/security" :class="$route.name === 'Security' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Security</a>
                    <a href="#/getstarted/downloads" :class="$route.name === 'Downloads' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Downloads</a>
                    <a href="#/getstarted/brandCenter" :class="$route.name === 'BrandCenter' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Brand Center</a>
                    <a href="#/getstarted/privacy" :class="$route.name === 'Privacy' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Privacy & Terms</a>
                    <a href="#/getstarted/refund" :class="$route.name === 'Refund' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Returns & Refunds</a>
                    <a href="#/getstarted/FAQS" :class="$route.name === 'FAQS' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">FAQs</a>
                    <a href="#/getstarted/contact" :class="$route.name === 'Contact' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Get In Touch</a>
                </div>
            </div>
            <div class="col-md-9">
                <router-view></router-view>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'GetStarted',
        data: function() {
            return {
    
            }
        }
    }
</script>

<style>
    
</style>