<template>
    <div class="container bg-white py-5 px-5 shadow-sm w-95">
        <h3>Create your Ballstreet account</h3>
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <p v-if="errors.length" style="color:red;">
                    <b>Please correct the following error(s):</b>
                    <ul>
                        <li v-for="error in errors">{{ error }}</li>
                    </ul>
                </p>
                <div style="margin:5px;">
                    <label>FIRST NAME*</label>
                    <input type="text" class="form-control loginInput" v-model="firstname">
                </div>
                <div style="margin:5px;">
                    <label>LAST NAME*</label>
                    <input type="text" class="form-control loginInput" v-model="lastname">
                </div>
                <div style="margin:5px;">
                    <label>EMAIL ADDRESS*</label>
                    <input type="email" class="form-control loginInput" v-model="email">
                </div>
                <div style="margin:5px;">
                    <label>PASSWORD*</label>
                    <input type="password" class="form-control loginInput" v-model="password">
                </div>
                <div style="margin:5px;">
                    <label>REPEAT PASSWORD*</label>
                    <input type="password" class="form-control loginInput" v-model="repeatpassword">
                </div>
                <div class="row" style="margin-left:5px; margin-top:10px; text-align:center">
                    <div class="col-sm-12">
                        <button class="btn btn-danger" @click="checkForm()">Create User</button>
                    </div>
                </div>
            </div>
            <div class="col-md-2"></div>
    
        </div>
    </div>
</template>

<script>
import api from '@/services/api';

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
                } else if (!this.validEmail(this.email)) {
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
	                })
                }
    
            },
            validEmail: function(email) {
                var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return re.test(email);
            }
        }
    }
</script>

<style>
    
</style>