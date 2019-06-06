<template>
    <div>
        <nav class="navbar navbar-light bg-white shadow-sm w-100 z-index-1000000 border-top" id="profile-navbar">
            <div class=" px-5 mx-auto">
                <nav class="nav nav-secondary justify-content-center">
                    <a class="nav-link text-secondary b-0" href="" v-scroll-to="'#user'">
                        <span class="" title="User-Info"><i class="fas fa-user-tag"></i></span>
                        <span class="d-none d-sm-block">User Info</span>
                    </a>
                    <a class="nav-link text-secondary b-0" href="" v-scroll-to="'#password'">
                        <span class="" title="Password"><i class="fas fa-key"></i></span>
                        <span class="d-none d-sm-block">Password</span>
                    </a>
                    <a class="nav-link text-secondary b-0" href="" v-scroll-to="'#log'">
                        <span class="" title="Password"><i class="fas fa-warehouse"></i></span>
                        <span class="d-none d-sm-block">Actions Log</span>
                    </a>
                </nav>
            </div>
        </nav>
        <div data-spy="scroll" data-target="#profile-navbar" data-offset="0" class="bg-light">
            <section class="p-5 text-center" id="user">
                <h1 class="text-violet mt-3 mb-1">ZW5215</h1>
                <h4 class="text-violet mt-1 mb-4">Profile</h4>
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
            <hr/>
            <section class="p-5 text-center" id="password">
                <h1 class="text-violet mt-3 mb-4">Password</h1>
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
                                    <h6 class="mb-5">Click here to reset your password</h6>
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
            <hr/>
            <section class="p-5 text-center" id="log">
                <h1 class="text-violet mt-3 mb-4">Actions Log</h1>
                <div class="row mx-auto mb-2">
                    <div class="col-md"></div>
                    <div class="col-md">
                        <p>Action 1: Mithun</p>
                        <p>Action 1: Mithun</p>
                        <p>Action 1: Mithun</p>
                        <p>Action 1: Mithun</p>
                    </div>
                    <div class="col-md"></div>
                </div>
            </section>
        </div>
    </div>  
</template>

<script>
    export default {
        name: 'Profile',
    }
</script>

<style>

</style>