<template>
    <div>
        <div class="row p-5 mx-auto text-center bg-light">
            <div class="container">
                <h1 class="text-violet mt-1 mb-3">Sign Up</h1>
                <div class="row my-5">
                    <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100 mx-4 px-5 mb-4" role="alert">
                        <span v-for="error in errors">
                            <strong>Error!</strong> {{error}}<br>
                        </span>
                        <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <loading-spinner v-if="showLoadingIcon"></loading-spinner>
                    <div class="col-sm-6 bg-index-sign-up"></div>
                    <div class="col-sm-6">
                        <div class="form-group px-2 mt-4 mb-4">
                            <input type="text" class="form-control" v-model="firstname" placeholder="Firstname*">
                        </div>
                        <div class="form-group px-2 mb-4">
                            <input type="text" class="form-control" v-model="lastname" placeholder="Lastname*">
                        </div>
                        <div class="form-group px-2 mb-4">
                            <input type="email" class="form-control" v-model="email" placeholder="Email*">
                        </div>
                        <div class="form-group px-2 mb-4">
                            <input type="password" class="form-control" v-model="password" placeholder="Password*">
                        </div>
                        <div class="form-group px-2 mb-4">
                            <input type="password" class="form-control" v-model="repeatpassword" placeholder="Repeat Password*">
                        </div>
                        <div class="form-group px-2 mt-5">
                            <button class="btn btn-dark bg-red border-0 w-100" @click="checkForm()">Create User</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
				<a href="#/getstarted/features" class="text-violet">
					<h6 class="mt-1 mb-5">Click here to know about the features of Ballstreet</h6>
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
        name: 'SignUp',
        components: {
        	LoadingSpinner
    	},
        data: function() {
            return {
                firstname: null,
                lastname: null,
                email: null,
                password: null,
                repeatpassword: null,
                showLoadingIcon: false,
                errors: []
            }
        },
        methods: {
            checkForm: function() {
                this.errors = [];
                if (!this.firstname || !this.lastname || !this.email || !this.password || !this.repeatpassword) {
                    this.errors.push("Required fields are missing.");
                } else if (!commonServices.validEmail(this.email)) {
                    this.errors.push('Valid email required.');
                }
                if(this.password !== this.repeatpassword){
                    this.errors.push('Password did not match.');
                }else if(this.password.length < 6){
                    this.errors.push('Password must be of minimum 6 characters length.');
                }
    
                if (!this.errors.length) {
                    var formData = {};
                    formData.firstname = this.firstname;
                    formData.lastname = this.lastname;
                    formData.age = 28;
                    formData.sex = "Male";
                    formData.email = this.email;
                    formData.password = this.password;

                    this.showLoadingIcon = true;
                    
                    api().post('/auth/signup', formData).then(result=>{
                        this.showLoadingIcon = false;
		                console.log(result.data.message);
                        localStorage.setItem('userDetails', JSON.stringify(result.data.userDetails)); // Store the user details in browser local storage
                        this.$router.push({
                            name: 'Profile', 
                        })
                    },
                    err => {
                        this.showLoadingIcon = false;
                        this.errors = [];
                        localStorage.removeItem('userDetails');
                        this.errors.push(err.response.data.message);
                    })
                }
    
            }
        }
    }
</script>

<style>
</style>