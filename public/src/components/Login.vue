<template>
    <div class="container bg-white py-5 px-5 shadow-sm w-95">
        <h3>Sign into Ballstreet</h3>
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div style="margin:5px;">
                    <label>EMAIL ADDRESS</label>
                    <input type="email" class="form-control loginInput" v-model="email">
                </div>
                <div style="margin:5px;">
                    <label>PASSWORD</label>
                    <input type="password" class="form-control loginInput" v-model="password">
                </div>
                <div class="row" style="margin-left:5px; margin-top:10px;">
                    <div class="col-sm-6">
                        <button class="btn btn-danger" @click="login()">Sign in</button>
                    </div>
                    <div class="col-sm-6">
                        <a href="/#/newuser" class="btn btn-primary">New User?</a>
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
        name: 'Login',
        data: function() {
            return {
                email: null,
                password: null
            }
        },
        methods:{
            login: function(){
                var formData = {
                    username: this.email,
                    password: this.password
                }
                api().post('/auth/', formData).then(result=>{
		                console.log(result.data.message);
	                })
            }
        }
    }
</script>

<style scoped>
    .loginInput {
        max-width: 450px;
    }
</style>