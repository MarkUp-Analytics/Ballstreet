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
        <div class="p-5 mx-auto text-center bg-light">
            <div class="container">
                <h1 class="text-violet mt-1 mb-5">Dashboard</h1>
                <div class="row text-left">
                    <div class="col-lg-9">
                        <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px"/>
                        <h4 class="mb-2"><span class="text-violet">India's tour of Australia, 2018-19</span> | <span class="text-violet">Cricket</span></h4>
                        <h5 class="mb-4">India, Australia, England, Newzealand, Pakistan, Srilanka</h5>
                        <div class="row">
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-calendar-day text-violet"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-violet">Dates</span><br/>
                                        <span>11-Jun to 12-Jan, 2018-19</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-id-badge text-violet"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-violet">Admin</span><br/>
                                        <span>MithSi</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-glass-cheers text-violet"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-violet"># Players</span><br/>
                                        <span>278</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-credit-card text-violet"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-violet">Value</span><br/>
                                        <span>INR 10.00</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <i class="fas fa-sitemap text-violet"></i>
                                    </div>
                                    <div class="col-sm-11">
                                        <span class="text-violet"># Games</span><br/>
                                        <span>92</span><br/><br/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr class="d-md-none mt-5 mb-5"/>
                    </div>

                    <div class="col-lg-3 text-center">
                        <form class="py-5">
                            <label for="FormControlGamePin" class="mb-2 text-violet font-weight-bold">GAME ID: 1AF4H0</label>
                            <input type="Text" class="form-control form-control-md rounded-1 w-100 mb-3" id="GamePin" aria-describedby="emailHelp" placeholder="Game Pin">
                            <button type="submit" class="btn btn-dark bg-violet rounded-1 w-100">Enter</button>
                        </form>
                    </div>
                </div>    
            </div>
        </div>
        <div class="p-5 mx-auto text-center bg-white">
            <div class="container">
                <h1 class="text-violet mt-1 mb-3">Overview</h1>
                <div class="row my-4">
                    <div class="col-lg my-3">
                        <i class="fas fa-dice-d6 text-yellow fa-4x"></i>
                    </div>
                    <div class="col-lg my-3">
                        <span class="text-secondary">Contribution, INR</span><br/>
                        <h3>450.00</h3>
                    </div>
                    <div class="col-lg my-3">
                        <span class="text-secondary">Curr. Value, INR</span><br/>
                        <h3>652.69</h3>
                    </div>
                    <div class="col-lg my-3">
                        <span class="text-secondary">P&L</span><br/>
                        <h3 class="text-success">45.04%</h3>
                    </div>
                </div>              
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'Page5',
    }
</script>

<style>
</style>