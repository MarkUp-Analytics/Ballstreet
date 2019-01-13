<template>
    <div class="row pt-3 pr-5 pl-5 pb-5 mx-auto text-center bg-light">
        <div class="container">
        <h1 class="text-violet mt-1 mb-3">Sign Up</h1>
        <div class="row">
            <div v-if="errors.length" class="alert alert-danger alert-dismissible fade show w-100" role="alert">
					<span v-for="error in errors">
                    <strong>Error!</strong> {{error}}<br>
					</span>
					<button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				</div>
                <div class="col-sm-6 bg-index-sign-up"></div>
                <div class="col-sm-6">
                <div class="form-group px-2">
                    <input type="text" class="form-control" v-model="firstname" placeholder="Firstname*">
                </div>
                <div class="form-group px-2">
                    <input type="text" class="form-control" v-model="lastname" placeholder="Lastname*">
                </div>
                <div class="form-group px-2">
                    <input type="email" class="form-control" v-model="email" placeholder="Email*">
                </div>
                <div class="form-group px-2">
                    <input type="password" class="form-control" v-model="password" placeholder="Password*">
                </div>
                <div class="form-group px-2">
                    <input type="password" class="form-control" v-model="repeatpassword" placeholder="Repeat Password*">
                </div>
                <div class="form-group mt-4 px-2">
                    <div class="col-sm-12">
                        <button class="btn btn-dark bg-red border-0 w-100 font-weight-bold" @click="checkForm()">Create User</button>
                    </div>
                </div>
                </div>
            </div>
        </div>
        </div>
</template>

<script>
import api from '@/services/api';
import commonServices from '@/services/commonServices';
    export default {
        name: 'NewUser',
        data: function() {
            return {
                firstname: null,
                lastname: null,
                email: null,
                password: null,
                repeatpassword: null,
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
                    
                    api().post('/auth/signup', formData).then(result=>{
		                console.log(result.data.message);
                        localStorage.setItem('userDetails', JSON.stringify(result.data.userDetails)); // Store the user details in browser local storage
                        this.$router.push({
                            name: 'Profile', 
                        })
                    },
                    err => {
                        this.errors = [];
                        localStorage.removeItem('userDetails');
                        this.errors.push(err.response.data.message);
                    })
                }
    
            }
        }
    }
</script>

<style scoped>
    .loginInput {
        border: 0;
        border-bottom: 1px solid #dddedf;
        padding: 4px 8px;
        margin: 4px;
    }
</style>