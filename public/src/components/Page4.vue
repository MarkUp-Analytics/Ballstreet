<template>
    <div>
        <section class="p-5 text-center" id="Profile">
            <h1 class="text-violet mt-1 mb-1">ZW5215</h1>
            <h4 class="text-violet mt-1 mb-4">Your Profile</h4>
            <div class="row mx-auto mb-2">
                <div class="col-md"></div>
                <div class="col-md">
                    <form class="text-left">
                        <div class="alert alert-danger alert-dismissible fade show w-100 mb-4 px-5" role="alert">    
                            <strong>Error!</strong>                        
                            <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="form-group mt-4">
                            <label>Enter Name</label>
                            <input class="form-control" type="text" placeholder="Ex: MithSi" value="" />
                        </div>
                        <div class="form-group mt-4">
                            <label>Enter Email</label>
                            <input class="form-control" type="email" placeholder="Ex: mithsi@ballstreet.com" value="" />
                        </div>
                        <div class="form-group mt-4">
                            <label>Enter Mobile Number</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">+91</span>
                                </div>
                                <input type="text" class="form-control" placeholder="Ex: 1234567890" value="" />
                            </div>                        
                        </div>
                        <div class="form-group mt-4">
                            <label>Choose Preferred Games</label>
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck1">
                                    <label class="form-check-label" for="defaultCheck1">
                                        Cricket
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck2" >
                                    <label class="form-check-label" for="defaultCheck2">
                                        Football
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="defaultCheck2" >
                                    <label class="form-check-label" for="defaultCheck2">
                                        Hockey
                                    </label>
                                </div>
                            </div>                        
                        </div>
                        <div class="row">
                            <div class="col-lg mt-5">
                                <a href="" class="btn btn-dark bg-violet border-0 w-100">Save Changes</a><br/>
                            </div>
                        </div>
                        <div class="row text-center">
                            <div class="col-lg mt-2">
                                <a href="" class="text-violet mt-5">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md"></div>
            </div>
        </section>
        <section class="p-5 text-center" id="Password">
            <h1 class="text-violet mt-1 mb-4">Password</h1>
            <div class="row mx-auto mb-2">
                <div class="col-md"></div>
                <div class="col-md">
                    <form class="text-left">
                        <div class="alert alert-danger alert-dismissible fade show w-100 mb-4 px-5" role="alert">    
                            <strong>Error!</strong>                        
                            <button type="button" class="close" data-dismiss="alert" @click="errors = [];" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="form-group mt-4">
                            <label>Current Password</label>
                            <input class="form-control" type="text" placeholder="Ex: MithSi" value="" />
                        </div>
                        <div class="form-group mt-4">
                            <label>New Password</label>
                            <input class="form-control" type="email" placeholder="Ex: mithsi@ballstreet.com" value="" />
                        </div>
                        <div class="form-group mt-4">
                            <label>New Password</label>
                            <input type="text" class="form-control" placeholder="Ex: 1234567890" value="" />   
                        </div>
                        <div class="form-group text-center mt-4">
                            <a href="#/discover" class="text-violet">
                                <h6 class="mb-5 px-5">Click here to reset your password</h6>
                            </a>  
                        </div>
                        <div class="row">
                            <div class="col-lg mt-2">
                                <a href="" class="btn btn-dark bg-violet border-0 w-100">Save Changes</a><br/>
                            </div>
                        </div>
                        <div class="row text-center">
                            <div class="col-lg mt-2">
                                <a href="" class="text-violet mt-5">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md"></div>
            </div>
        </section>
        <div class="container px-5 pt-4 pb-5">
            <a href="#/discover" class="text-violet">
                <h6 class="mb-5 px-5">Click here to open your past and current P&L</h6>
            </a>
        </div>
    </div>  
</template>

<script>
    export default {
        name: 'Page4',
    }
</script>

<style>

</style>