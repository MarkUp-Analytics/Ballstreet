<template>
    <div>
        <div class="bg-light">
            <div class="row p-5 mx-auto text-center container">
                <div class="col-md-3">
                    <div class="nav flex-column nav-pills mb-5" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a href="" @click.prevent="redirectPage('AboutBallstreet')" :class="$route.name === 'AboutBallstreet' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">About Ballstreet</a>
                        <a href="" @click.prevent="redirectPage('HowBallstreetWorks')" :class="$route.name === 'HowBallstreetWorks' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">How Ballstreet Works</a>
                        <a href="" @click.prevent="redirectPage('GamesOfSkill')" :class="$route.name === 'GamesOfSkill' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Games Of Skill</a>
                        <a href="" @click.prevent="redirectPage('Features')" :class="$route.name === 'Features' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Features</a>
                        <a href="" @click.prevent="redirectPage('Security')" :class="$route.name === 'Security' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Security</a>
                        <a href="" @click.prevent="redirectPage('Downloads')" :class="$route.name === 'Downloads' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Downloads</a>
                        <a href="" @click.prevent="redirectPage('BrandCenter')" :class="$route.name === 'BrandCenter' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Brand Center</a>
                        <a href="" @click.prevent="redirectPage('Privacy')" :class="$route.name === 'Privacy' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Privacy & Terms</a>
                        <a href="" @click.prevent="redirectPage('Refund')" :class="$route.name === 'Refund' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Returns & Refunds</a>
                        <a href="" @click.prevent="redirectPage('FAQS')" :class="$route.name === 'FAQS' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">FAQs</a>
                        <a href="" @click.prevent="redirectPage('Contact')" :class="$route.name === 'Contact' ? 'getStartedActive removeTextDecoration' : 'getStartedInactive removeTextDecoration'">Get In Touch</a>
                    </div>
                </div>
                <div class="col-md-9">
                    <router-view></router-view>
                </div>
            </div>
        </div>
        <div class="row py-5 mx-auto text-center bg-white" id="social-links">
			<div class="container">
				<ul class="nav nav-fill">
					<li class="nav-item">
						<a class="nav-link active text-violet" href="#">
							<i class="fa fa-briefcase fa-1x"></i><br/>
							<h6 class="mt-2">Careers</h6>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link active text-violet" href="#">
							<i class="fa fa-blog fa-1x"></i><br/>
							<h6 class="mt-2">Blog</h6>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link active text-violet" href="#">
							<i class="fab fa-facebook fa-1x"></i><br/>
							<h6 class="mt-2">Facebook</h6>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link active text-violet" href="#">
							<i class="fab fa-twitter fa-1x"></i><br/>
							<h6 class="mt-2">Twitter</h6>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link active text-violet" href="#">
							<i class="fab fa-linkedin fa-1x"></i><br/>
							<h6 class="mt-2">LinkedIn</h6>
						</a>
					</li>
				</ul>
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
		},
		methods:{
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