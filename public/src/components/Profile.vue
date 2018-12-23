<template>
<div>
    <div>{{userDetails.firstname}}</div>
    <div>{{userDetails.lastname}}</div>
</div>
</template>

<script>
export default{
    name: 'Profile',
    created() {
        if(localStorage.getItem('userDetails')){
            this.userDetails = JSON.parse(localStorage.getItem('userDetails'));
        }
        else{
            this.$router.push({
                name: 'Login', 
            })
        }
        
    },
    data: function(){
        return{
            userDetails: null,
        }
    }
}
</script>

<style>

</style>