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
                    <!-- <label>FIRST NAME*</label> -->
                    <input type="text" class="form-control loginInput" v-model="firstname" placeholder="Firstname*">
                </div>
                <div style="margin:5px;">
                    <!-- <label>LAST NAME*</label> -->
                    <input type="text" class="form-control loginInput" v-model="lastname" placeholder="Lastname*">
                </div>
                <div style="margin:5px;">
                    <!-- <label>EMAIL ADDRESS*</label> -->
                    <input type="email" class="form-control loginInput" v-model="email" placeholder="Email*">
                </div>
                <div style="margin:5px;">
                    <!-- <label>PASSWORD*</label> -->
                    <input type="password" class="form-control loginInput" v-model="password" placeholder="Password*">
                </div>
                <div style="margin:5px;">
                    <!-- <label>REPEAT PASSWORD*</label> -->
                    <input type="password" class="form-control loginInput" v-model="repeatpassword" placeholder="Repeat Password*">
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