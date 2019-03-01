<template>
    <div>
        <nav class="navbar navbar-light bg-light shadow-sm w-100 z-index-3">
            <div class=" px-5 mx-auto">
                <nav class="nav nav-secondary justify-content-center">
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Dashboard">Dash</span>
                        <span class="d-none d-sm-block">Dashboard</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Preferences">Pref</span>
                        <span class="d-none d-sm-block">Preferences</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Results">Resu</span>
                        <span class="d-none d-sm-block">Results</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Statistics">Stat</span>
                        <span class="d-none d-sm-block">Statistics</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Statistics">Play</span>
                        <span class="d-none d-sm-block">Players</span>
                    </a>
                </nav>
            </div>
        </nav>
        <div class="p-5 mx-auto text-center bg-light" id="update-preferences">
            <div class="container">
                <h1 class="text-violet mt-1 mb-5">Preferences</h1>
                <div class="row mt-4">   
                    <div class="col-2"></div>                     
                    <div class="col-2 text-right">
                        <a href="" class="btn btn-light bg-light my-1"><i class="fas fa-angle-up"></i></a><br/>
                        <a href="" class="btn btn-light bg-light my-1"><i class="fas fa-angle-down"></i></a>
                    </div>
                    <div class="col-6 text-left">
                        <img src="../../static/assets/images/rcb.jpg" class="rounded border mb-2" width="95px" height="95px" />
                        <h5>
                            ROYAL CHALLENGERS BANGALORE
                        </h5>
                    </div>
                    <div class="col-2"></div>
                </div>
                <div class="row mt-4">     
                    <div class="col-2"></div>                   
                    <div class="col-2 text-right">
                        <a href="" class="btn btn-light bg-light my-1"><i class="fas fa-angle-up"></i></a><br/>
                        <a href="" class="btn btn-light bg-light my-1"><i class="fas fa-angle-down"></i></a>
                    </div>
                    <div class="col-6 text-left">
                        <img src="../../static/assets/images/csk.jpg" class="rounded border mb-2" width="95px" height="95px" />
                        <h5>
                            CHENNAI SUPER KINGS
                        </h5>
                    </div>
                    <div class="col-2"></div>
                </div>
                <div class="row mt-5">
                    <div class="col-md text-center">
                    </div>
                    <div class="col-md">
                        <div class="row">
                            <div class="col-lg mt-2">
                                <a href="" class="btn btn-dark bg-violet border-0 w-100">Save Changes</a><br/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg mt-2">
                                <a href="" class="text-violet mt-5">Cancel</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md">
                    </div>
                </div>
            </div>
        </div>
        <div class="p-5 mx-auto text-center bg-white">
            <div class="container pb-5">
                <h3 class="text-violet mt-1 mb-1">Upcoming Games</h3>
                <h6 class="mt-1 mb-5">
                    <a href="#" class="text-violet mx-2">3 Games</a> <a href="#" class="text-violet mx-2">5 Games</a> <a href="#" class="text-violet mx-2">7 Games</a> <a href="#" class="text-violet mx-2">14 Games</a> <span class="mx-2">|</span> <a href="#" class="text-violet mx-2">3 Days</a> <a href="#" class="text-violet mx-2">5 Days</a> <a href="#" class="text-violet mx-2">7 Days</a> <a href="#" class="text-violet mx-2">14 Days</a>
                </h6>
                
                <div class="card-columns">
					<div class="card bg-white">
						<div class="card-body">
							<form class="text-left p-1">
                                <div class="form-group">
                                    <label>Indian Premier League 2019</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>29/Mar/2019 01:20 Hrs</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>Stadium, Chennai</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>Preference:</label>
                                    <select class="form-control">
                                        <option>Chennai Super Kings</option>
                                        <option>Royal Challengers Namgalore</option>
                                        <option>Tie</option>
                                    </select>
                                </div>
                                <div class="form-group mt-2">
                                    <small><a href="" v-scroll-to="'#update-preferences'" class="text-violet">Override is applicable only for this game. To update preferences for all games, click here.</a></small>
                                </div>
                                <div class="row">
                                    <div class="col-lg mt-4">
                                        <a href="" class="btn btn-dark bg-violet border-0 w-100">Save</a><br/>
                                    </div>
                                </div>
                                <div class="row text-center">
                                    <div class="col-lg mt-2">
                                        <a href="" class="text-violet mt-5">Cancel</a>
                                    </div>
                                </div>
                            </form>
						</div>
					</div>
                    <div class="card bg-white">
						<div class="card-body">
							<form class="text-left p-1">
                                <div class="form-group">
                                    <label>Indian Premier League 2019</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>29/Mar/2019 01:20 Hrs</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>Stadium, Chennai</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>Preference:</label>
                                    <select class="form-control">
                                        <option>Chennai Super Kings</option>
                                        <option>Royal Challengers Namgalore</option>
                                        <option>Tie</option>
                                    </select>
                                </div>
                                <div class="form-group mt-2">
                                    <small><a href="" v-scroll-to="'#update-preferences'" class="text-violet">Override is applicable only for this game. To update preferences for all games, click here.</a></small>
                                </div>
                                <div class="row">
                                    <div class="col-lg mt-4">
                                        <a href="" class="btn btn-dark bg-violet border-0 w-100">Save</a><br/>
                                    </div>
                                </div>
                                <div class="row text-center">
                                    <div class="col-lg mt-2">
                                        <a href="" class="text-violet mt-5">Cancel</a>
                                    </div>
                                </div>
                            </form>
						</div>
					</div>
                    <div class="card bg-white">
						<div class="card-body">
							<form class="text-left p-1">
                                <div class="form-group">
                                    <label>Indian Premier League 2019</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>29/Mar/2019 01:20 Hrs</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>Stadium, Chennai</label>                                    
                                </div>
                                <div class="form-group mt-2">
                                    <label>Preference:</label>
                                    <select class="form-control">
                                        <option>Chennai Super Kings</option>
                                        <option>Royal Challengers Namgalore</option>
                                        <option>Tie</option>
                                    </select>
                                </div>
                                <div class="form-group mt-2">
                                    <small><a href="" v-scroll-to="'#update-preferences'" class="text-violet">Override is applicable only for this game. To update preferences for all games, click here.</a></small>
                                </div>
                                <div class="row">
                                    <div class="col-lg mt-4">
                                        <a href="" class="btn btn-dark bg-violet border-0 w-100">Save</a><br/>
                                    </div>
                                </div>
                                <div class="row text-center">
                                    <div class="col-lg mt-2">
                                        <a href="" class="text-violet mt-5">Cancel</a>
                                    </div>
                                </div>
                            </form>
						</div>
					</div>
				</div>  
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'Page6',
    }
</script>

<style>
</style>