<template>
    <div>
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
							<label>Email address</label>
							<input type="email" class="form-control" v-model="email" aria-describedby="emailHelp" placeholder="Enter email">
						</div>
						<div class="form-group mt-3 px-2 mb-4">
							<label>Password</label>
							<input type="password" class="form-control" v-model="password" placeholder="Password">
							<small><a href="#" class="form-text text-dark">Forgot Password?</a></small>
						</div>
						<div class="form-group mt-5 px-2">
							<a href="" class="btn btn-dark bg-violet border-0 w-100" @click.prevent="login()">Sign In</a>
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<a href="" @click.prevent="redirectPage('AboutBallstreet')" class="text-violet">
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
		name: 'Signin',
		components: {
        	LoadingSpinner
    	},
        data: function() {
            return {
                email: null,
				password: null,
				showLoadingIcon: false,
                errors: []
            }
        },
        created() {
            if(localStorage.getItem('userDetails')){ //If user is already logged in, it takes it to home page
                this.$router.push({
                            name: 'Home', 
                        })
            }
        },
        methods: {
			redirectPage: function(componentName){
				this.$router.push({
					name: componentName,
				})
			},
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
                        console.log(result.data.message);
                        localStorage.setItem('userDetails', JSON.stringify(result.data.userDetails)); // Store the user details in browser local storage
                        this.$router.push({
                            name: 'Home', 
                        })
                    },
                    err => {
						this.errors = [];
						this.showLoadingIcon = false;
                        localStorage.removeItem('userDetails');
                        this.errors.push(err.response.data.message);
                    })
            }
        }
    }
</script>

<style>

</style>