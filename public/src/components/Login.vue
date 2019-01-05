<template>
    <div class="container bg-white py-5 px-5 shadow-sm w-95">
        <h3>Sign into Ballstreet</h3>
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
                <p v-if="errors.length" style="color:red;">
                    <b v-for="error in errors"><i class="fa fa-warning" style="margin-right:5px;"></i>{{ error}}</b>
                </p>
                <div style="margin:5px; margin-bottom: 15px;">
                    <input type="email" class="form-control loginInput" v-model="email" placeholder="Email">
                </div>
                <div style="margin:5px; margin-bottom: 15px;">
                    <input type="password" class="form-control loginInput" v-model="password" placeholder="Password">
                </div>
                <div class="row" style="margin-left:5px; margin-top:10px;">
                    <div class="col-6">
                        <button class="btn btn-sm btn-danger" @click="login()">Sign in</button>
                    </div>
                    <div class="col-6">
                        <a href="/#/newuser" class="btn btn-sm btn-primary">New User?</a>
                    </div>
                </div>
            </div>
            <div class="col-2"></div>
    
        </div>
    </div>
</template>

<script>
    import api from '@/services/api';
    import commonServices from '@/services/commonServices';
    export default {
        name: 'Login',
        data: function() {
            return {
                email: null,
                password: null,
                errors: []
            }
        },
        created() {
            if(localStorage.getItem('userDetails')){ //If user is already logged in, it takes it to profile page
                this.$router.push({
                            name: 'Profile', 
                        })
            }
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
                var formData = {
                    username: this.email,
                    password: this.password
                }
                api().post('/auth/', formData).then(result => {
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
</script>

<style scoped>
    .loginInput {
        max-width: 450px;
        border: 0;
        border-bottom: 1px solid #dddedf;
        padding: 4px 8px;
        margin: 4px;
    }
</style>