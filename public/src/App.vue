<template>
	<div id="app">
		<div v-if="!userDetails" class="d-flex flex-column flex-md-row align-items-center p-2 px-md-4 mb-1 bg-white container">
			<div class="ballstreet-logo-full mr-md-auto font-weight-normal cursorPointer" @click="redirectPage('Index')"></div>
			<div>
				<a class="p-2 text-red" href="" @click.prevent="redirectPage('AboutBallstreet')">Get Started</a>
				<a class="p-2 text-red" href="" @click.prevent="redirectPage('Signin')">Sign In</a>
				<a class="mx-2 btn btn-dark bg-red border-0" href="" @click.prevent="redirectPage('SignUp')">Sign Up</a>
			</div>
		</div>
		<nav v-if="userDetails" class="navbar navbar-expand-lg navbar-light bg-white font-size-16">
				<div class="container pr-2">
					<div class="ballstreet-logo-small mr-md-auto cursorPointer" @click.prevent="redirectPage('Home')"></div>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
						<small><span class="navbar-toggler-icon text-violet"></span></small>
					</button>
					<div v-if="userDetails" class="collapse navbar-collapse" id="navbarsExample09">
						<ul class="navbar-nav mr-auto">
						</ul>
						<ul class="navbar-nav">
							<li v-if="userDetails.roleName === 'ADMIN'" class="nav-item m-2">
								<a class="text-red" href="" @click.prevent="redirectPage('Input Team')" :class="{'textBold': $route.name.indexOf('Input') != -1}">Admin Menu</a>
							</li>
							<li class="nav-item m-2">
								<a class="text-red" href="" @click.prevent="redirectPage('Discover')" :class="{'textBold': $route.name === 'Discover'}">Discover</a>
							</li>
							<li class="nav-item m-2">
								<a class="text-red" href="" @click.prevent="redirectPage('Create')" :class="{'textBold': $route.name === 'Create'}">Create</a>
							</li>
							<li class="nav-item m-2">
								<a class="text-red" href="" @click.prevent="redirectPage('p&l')" :class="{'textBold': $route.name === 'p&l'}">P&L</a>
							</li>
							<li class="nav-item dropdown">
								<a class="text-red text-center nav-link dropdown-toggle" href="" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span class="text-red">{{userDetails.firstname}}</span>
								</a>
								<div class="dropdown-menu dropdown-menu-right text-center" aria-labelledby="navbarDropdown">
									<a class="dropdown-item" href="" @click.prevent="redirectPage('Profile')" :class="{'textBold': $route.name === 'Profile'}">
										<span class="text-red">Ballstreet ID</span><br/> <span class="text-dark">{{userDetails.shortid}}</span>
									</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="#">
										<span class="text-red">Funds</span><br/> <span class="text-dark">INR 739</span>
									</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="" @click.prevent="logout(); redirectPage('Index');">
										<span class="text-red">Log Out</span>
									</a>
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
							<li><a class="text-white" @click="scrollToTop(); redirectPage('AboutBallstreet')" href="">About</a></li>
							<li><a class="text-white" @click="scrollToTop(); redirectPage('Careers')" href="">Careers</a></li>
							<li><a class="text-white" @click="scrollToTop(); redirectPage('BrandCenter')" href="">Brand Center</a></li>
							<li><a class="text-white" @click="scrollToTop(); redirectPage('Privacy')" href="">Privacy & Terms</a></li>
							<li><a class="text-white" @click="scrollToTop(); redirectPage('Refund')" href="">Returns & Refunds</a></li>
							<li><a class="text-white" @click="scrollToTop(); redirectPage('Contact')" href="">Get In Touch</a></li>
						</ul>
					</div>
					<div class="col-sm-4 mb-2 col-md">
						<h6 class="text-yellow font-weight-bold">Ballstreet</h6>
						<ul class="list-unstyled font-size-14pc">
							<li><a class="text-white" @click="scrollToTop(); redirectPage('Features')" href="">Features</a></li>
							<li><a class="text-white" @click="scrollToTop(); redirectPage('Security')" href="">Security</a></li>
							<li><a class="text-white" @click="scrollToTop(); redirectPage('Downloads')" href="">Downloads</a></li>
							<li><a class="text-white" @click="scrollToTop(); redirectPage('GamesOfSkill')" href="">Games of Skill</a></li>
							<li><a class="text-white" @click="scrollToTop(); redirectPage('HowBallstreetWorks')" href="">How it Works</a></li>
						</ul>
					</div>
					<div class="col-sm-4 mb-4 col-md">
						<h6 class="text-yellow font-weight-bold">Help</h6>
						<ul class="list-unstyled font-size-14pc">
							<li><a class="text-white" @click="scrollToTop(); redirectPage('FAQS')" href="">FAQs</a></li>
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
import api from '@/services/api';
import commonServices from '@/services/commonServices';
import LoadingSpinner from '@/components/LoadingSpinner';
	export default {
		name: 'App',
		created() {
			// if (localStorage.getItem('userDetails')) {
            //     this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
            // }
			
		},
		computed: {
		
		},
		data() {
			return {
				showLoadingIcon: false,
				errors: [],
				userDetails: null,
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
