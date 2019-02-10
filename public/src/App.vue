<template>
	<div id="app">
		<div v-if="!userDetails" class="d-flex flex-column flex-md-row align-items-center p-2 px-md-4 mb-1 bg-white container">
			<div class="ballstreet-logo-full mr-md-auto font-weight-normal cursorPointer" @click="redirectPage('Index')"></div>
			<div>
				<a class="p-2 text-red" href="#/getstarted">Get Started</a>
				<a class="p-2 text-red" href="#/signin">Sign In</a>
				<a class="mx-2 btn btn-dark bg-red border-0" href="#/signup">Sign Up</a>
			</div>
		</div>
		<nav v-if="userDetails" class="navbar navbar-expand-lg navbar-light bg-white font-size-16">
				<div class="container pr-2">
					<div class="ballstreet-logo-small mr-md-auto cursorPointer" @click.prevent="redirectPage('Profile')"></div>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
						<small><span class="navbar-toggler-icon text-violet"></span></small>
					</button>
					<div v-if="userDetails" class="collapse navbar-collapse" id="navbarsExample09">
						<ul class="navbar-nav mr-auto">
						</ul>
						<ul class="navbar-nav">
							<li class="nav-item m-2">
								<a class="text-red" href="" @click.prevent="redirectPage('Discover')" :class="{'textBold': $route.name === 'Discover'}">Discover</a>
							</li>
							<li class="nav-item m-2">
								<a class="text-red" href="" @click.prevent="redirectPage('Create')" :class="{'textBold': $route.name === 'Create'}">Create</a>
							</li>
							<li class="nav-item m-2">
								<a class="text-red" href="" @click.prevent="redirectPage('Page3')" :class="{'textBold': $route.name === 'Page3'}">P&L</a>
							</li>
							<li class="nav-item dropdown m-2">
								<a class="text-red dropdown-toggle" href="" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								{{userDetails.firstname}}
							</a>
								<div class="dropdown-menu dropdown-menu-right text-center" aria-labelledby="navbarDropdown">
									<a class="dropdown-item" href="" @click.prevent="redirectPage('Page4')" :class="{'textBold': $route.name === 'Page4'}">
										<span class="text-red">Ballstreet ID</span><br/> {{userDetails.shortid}}
									</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="#">
										<span class="text-red">Funds</span><br/> INR 739
									</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item text-red" href="" @click.prevent="logout(); redirectPage('Index');">Log Out</a>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</nav>
		<router-view/>
		<footer class="p-5 mx-auto text-center bg-violet" id="footer-links">
			<div class="container">
				<div class="row">
					<div class="col-12 mb-4 col-md">
						<div class="ballstreet-logo-only mr-md-auto font-weight-normal w-100"></div>
						<h6 class="d-block text-yellow">2019 &copy; Ballstreet</h6>
					</div>
					<div class="col-sm-4 mb-4 col-md">
						<h6 class="text-yellow font-weight-bold">Company</h6>
						<ul class="list-unstyled font-size-14pc">
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted">About</a></li>
							<li><a class="text-white" @click="scrollToTop()" href="#">Careers</a></li>
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted/brandCenter">Brand Center</a></li>
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted/privacy">Privacy & Terms</a></li>
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted/refund">Returns & Refunds</a></li>
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted/contact">Get In Touch</a></li>
						</ul>
					</div>
					<div class="col-sm-4 mb-2 col-md">
						<h6 class="text-yellow font-weight-bold">Ballstreet</h6>
						<ul class="list-unstyled font-size-14pc">
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted/features">Features</a></li>
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted/security">Security</a></li>
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted/downloads">Downloads</a></li>
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted/gamesOfSkill">Games of Skill</a></li>
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted/howBallstreetWorks">How it Works</a></li>
						</ul>
					</div>
					<div class="col-sm-4 mb-4 col-md">
						<h6 class="text-yellow font-weight-bold">Help</h6>
						<ul class="list-unstyled font-size-14pc">
							<li><a class="text-white" @click="scrollToTop()" href="#/getstarted/FAQS">FAQs</a></li>
							<li><a class="text-white" href="#">Blog</a></li>
							<li><a class="text-white" href="#">Facebook</a></li>
							<li><a class="text-white" href="#">Twitter</a></li>
							<li><a class="text-white" href="#">LinkedIn</a></li>
	
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col font-size-12pc">
						<a href="https://www.freepik.com/free-photos-vectors/background" class="text-white">Background vector created by Freepik</a>
					</div>
				</div>
			</div>
		</footer>
	</div>
</template>

<script>
	export default {
		name: 'App',
		created() {
			if(localStorage.getItem('userDetails')){ //If user is already logged in, it takes it to profile page
                this.$router.push({
                            name: 'Profile', 
                        })
            }
		},
		computed: {
		
		},
		data() {
			return {
				get userDetails() {
					if (localStorage.getItem('userDetails')) {
						return JSON.parse(localStorage.getItem('userDetails'));
					}
				}
			}
		},
		methods: {
			logout: function() {
				localStorage.removeItem('userDetails');
			},
			redirectPage: function(componentName){
				this.$router.push({
					name: componentName,
				})
			},
			scrollToTop() {
                window.scrollTo(0,0);
           }
		}
	}
</script>

<style>
	
</style>
