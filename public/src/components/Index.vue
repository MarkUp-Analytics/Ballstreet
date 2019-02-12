<template>
	<div>
		<div class="p-5 mx-auto text-center bg-light">
			<div class="container">
				<div class="row">
					<div class="col-lg p-5 bg-game-of-skill"></div>
					<div class="col-lg text-center px-5 pb-5 d-none d-lg-block">
						<br/><br/>
						<h1 class="text-violet">A simple <a class="font-weight-bold text-violet" href="#/getstarted/gamesOfSkill">game of skill</a>, designed to engage</h1>
						<a class="mt-3 btn btn-dark bg-violet border-0" href="#know-more">Know More</a>
					</div>
					<div class="col-lg text-center px-5 pb-5 d-lg-none">
						<h1 class="text-violet">A simple <a class="font-weight-bold text-violet" href="#/getstarted/gamesOfSkill">game of skill</a>, designed to engage</h1>
						<a class="mt-3 btn btn-dark bg-violet border-0" href="#know-more">Know More</a>
					</div>
				</div>
			</div>
		</div>

		<div class="row p-5 mx-auto text-center bg-yellow" id="know-more">
			<div class="container">
				<a href="#know-more">
					<div class="ballstreet-logo-only-violet mr-md-auto font-weight-normal w-100"></div>
					<i class="fas fa-arrow-down text-violet"></i>
				</a>
				<br/>
				<br/>

				<div class="card-columns mb-5">
					<div class="card bg-light">
						<div class="card-body">
							<h5 class="card-title text-violet font-weight-bold">
									<i class="fas fa-hat-wizard fa-1x mb-2"></i><br/>
									Simplified Fantasy Sporting
								</h5>
							<p class="card-text">Simpler and unique games of skill, aided by superior intuitive interface!</p>
						</div>
					</div>

					<div class="card bg-light">
						<div class="card-body">
							<h5 class="card-title text-violet font-weight-bold">
									<i class="fas fa-calendar-day fa-1x mb-2"></i><br/>
									Play Alongside Live Events
								</h5>
							<p class="card-text">Ballstreet's tournaments are basis some real life contesting events.</p>
						</div>
					</div>

					<div class="card bg-light">
						<div class="card-body">
							<h5 class="card-title text-violet font-weight-bold">
									<i class="fas fa-chart-pie fa-1x mb-2"></i><br/>
									Powerful Statistics To Spice Up Conversations
								</h5>
							<p class="card-text">Statistics that engage and create conversations within the group.</p>
						</div>
					</div>

					<div class="card bg-light">
						<div class="card-body">
							<h5 class="card-title text-violet font-weight-bold">
									<i class="fab fa-creative-commons-zero fa-1x mb-2"></i><br/>
									Zero Sum Redistribution
								</h5>
							<p class="card-text">All the money collected for the torunament is redistributed, basis players' performance.</p>
						</div>
					</div>

					<div class="card bg-light">
						<div class="card-body">
							<h5 class="card-title text-violet font-weight-bold">
									<i class="fas fa-globe-asia fa-1x mb-2"></i><br/>
									Wherever And Whenever
								</h5>
							<p class="card-text">No limitations on devices, time or venue.</p>
						</div>
					</div>

					<div class="card bg-light">
						<div class="card-body">
							<h5 class="card-title text-violet font-weight-bold">
									<i class="fas fa-clock fa-1x mb-2"></i><br/>
									Real Time Results Updation
								</h5>
							<p class="card-text">Results are updated right after the underlying contest gets to a con.</p>
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<a href="#/getstarted/features" class="text-violet">
					<h6 class="mt-1 mb-5">Click here to know more on Ballstreet's features</h6>
				</a>
			</div>
		</div>

		<div class="row py-5 mx-auto text-center bg-light" id="how-it-works">
			<div class="container">
				<h1 class="text-violet mt-1 mb-5">How It Works</h1>
				<ul class="list-group px-5 mb-5">
					<li class="list-group-item border-left-0 border-right-0 bg-light">
						Ballstreet creates tournaments that comprises of games or events, mimicking real-life scenarios, for example: Indian Premier League, English Premier League and World Cup Men’s Cricket etc.
					</li>
					<li class="list-group-item border-left-0 border-right-0 bg-light">
						Users can create groups for their friends to play (the creator of the group becomes the admin of the group), basis any created tournaments by Ballstreet
					</li>
					<li class="list-group-item border-left-0 border-right-0 bg-light">
						Admin decides the amount to be played with for every game, and each of the players are required to deposit the money to play the tournament along with friends
					</li>
					<li class="list-group-item border-left-0 border-right-0 bg-light">
						Basis real time results, players scores are calculated, and at the end of the tournament the final calculated money is paid out to the players
					</li>
				</ul>
			</div>
			<div class="container">
				<a href="#/getstarted/howBallstreetWorks" class="text-violet">
					<h6 class="mt-1 mb-5 px-5">Click here to know more on how Ballstreet works</h6>
				</a>
			</div>
		</div>
		<div class="row p-5 mx-auto text-center bg-light" id="sign-in">
			<div class="container">
				<h1 class="text-violet mt-1 mb-3">Sign In</h1>
				<div class="row my-5">
					<div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100 mb-4 mx-4 px-5" role="alert">
						<span v-for="error in errors">
							<strong>Error!</strong> {{error}}
						</span>
						<button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<loading-spinner v-if="showLoadingIcon"></loading-spinner>
					<div class="col-sm-6 bg-index-sign-in"></div>
					<div class="col-sm-6">
						<div class="form-group px-2 mt-4 mb-4">
							<input type="email" class="form-control" id="exampleInputEmail1" v-model="email" aria-describedby="emailHelp" placeholder="Enter email">
						</div>
						<div class="form-group mt-3 px-2 mb-4">
							<input type="password" class="form-control" id="exampleInputPassword1" v-model="password" placeholder="Password">
								<small><a href="#" class="form-text text-dark">Forgot Password?</a></small>
						</div>
						<div class="form-group mt-5 px-2">
							<a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="login()">Sign In</a>
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<a href="#/getstarted/howBallstreetWorks" class="text-violet">
					<h6 class="mt-1 mb-5 px-5">Click here to know more on how Ballstreet works</h6>
				</a>
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
	import api from '@/services/api';
	import commonServices from '@/services/commonServices';
	import LoadingSpinner from '@/components/LoadingSpinner';
    export default {
		name: 'Index',
		components: {
        	LoadingSpinner
    	},
        data: function() {
            return {
				email: null,
				showLoadingIcon: false,
                password: null,
                errors: []
            }
        },
        created() {
			
            if(localStorage.getItem('userDetails')){ //If user is already logged in, it takes it to profile page
                this.$router.push({
                            name: 'Home', 
                        })
            }
		},
		mounted() {
			this.$nextTick(function () {
				this.$scrollTo('#app')
  			})
			
		},
        methods: {
            login: function() {
                if(!this.email || !this.password){
                    this.errors = [];
                    this.errors.push("Email/password cannot be empty");
                    return;
                }
                else if(!commonServices.validEmail(this.email)){
                    this.errors = [];
                    this.errors.push("Invalid email address");
                    return;
				}
				
				this.showLoadingIcon = true;
				
                var formData = {
                    username: this.email,
                    password: this.password
				}
                api().post('/auth/', formData).then(result => {
						this.showLoadingIcon = false;
                        localStorage.setItem('userDetails', JSON.stringify(result.data.userDetails)); // Store the user details in browser local storage
                        this.$router.push({
                            name: 'Home', 
                        })
                    },
                    err => {
						this.showLoadingIcon = false;
                        this.errors = [];
                        localStorage.removeItem('userDetails');
                        this.errors.push(err.response.data.message);
                    })
			},
        }
    }
</script>

<style>

</style>