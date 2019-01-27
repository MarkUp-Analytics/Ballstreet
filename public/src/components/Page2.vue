<template>
    <div>
        <div class="p-5 mx-auto text-center bg-white">
            <h1 class="text-violet mb-4">Discover</h1>

            <div class="row mx-auto mb-5">
                <div class="col-md"></div>
                <div class="col-md">
                    <form>
                        <div class="form-group mt-3">
                            <label>Sport</label>
                            <select class="form-control" v-model="sportFilter">
                                <option v-for="sport in sportsList">
                                    {{ sport }}
                                </option>
                            </select>
                            
                        </div>
                        <div class="form-group mt-3">
                            <label>Tournament</label>
                            <select class="form-control" v-model="selectedTour" :disabled="!sportFilter">
                                <option v-for="tour in filteredUpcomingTours" :value="tour">
                                    {{ tour.tournament_name }}
                                </option>
                            </select>
                        </div>
                        <div class="row mt-5 mb-5 text-right">
                            <div class="col-lg">
                                <a href="" class="btn btn-dark bg-red border-0 w-100" @click.prevent="saveLeague()">Discover</a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md"></div>
            </div>
            
            <section id="search-results" class="container pb-3">
                <h5 class="mt-1">SEARCH RESULTS</h5>
                <i class="fas fa-arrow-down"></i>

                <div class="text-center container mt-5">
                    <div class="row mb-2">
                        <div class="col h3">
                            <a href="#" class="text-violet">Gavaskar-Border Trophy 2018</a> | <a href="#" class="text-violet">Men's Cricket</a>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-lg mb-2">
                            <img src="../../static/assets/images/ipl.png" class="rounded border" width="50px" height="50px"/>
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Teams</span><br/>
                            Austalia, England, India, Srilanka, Pakistan
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Dates</span><br/>
                            28-June-2018 to 31-December-2018
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Venue</span><br/>
                            Australia
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary"># Games</span><br/>
                            72
                        </div>
                    </div>
                    <form class="row mb-2">
                        <div class="col-lg">
                        </div>
                        <div class="col-lg form-group">
                            <input class="form-control" type="text" placeholder="Game Id/Admin Name" v-model="league_name">
                        </div>
                        <div class="col-lg form-group">
                            <a href="" class="btn btn-dark bg-violet border-0 w-100">Search Leagues</a>
                        </div>
                        <div class="col-lg">
                        </div>
                    </form>
                    <div class="w-100 max-height-90vh table-responsive-xl mb-2">
                        <table class="table sortable">
                            <thead>
                                <tr class="text-violet">
                                    <th scope="col-2">Game Id</th>
                                    <th scope="col-2">Created</th>
                                    <th scope="col-2"># Players</th>
                                    <th scope="col-2">Cash Per Game, INR</th>
                                    <th scope="col-2">Link</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="align-middle">
                                        2018/07/20 1730 Hrs
                                    </td>
                                    <td class="align-middle">
                                        Chennai, India
                                    </td>
                                    <td class="align-middle">
                                        Chennai Super Kings
                                    </td>
                                    <td class="align-middle">
                                        Royal Challengers Bangalore
                                    </td>
                                    <td class="align-middle">
                                        <a href="#" class="text-violet">Click</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-middle">
                                        2018/07/20 1730 Hrs
                                    </td>
                                    <td class="align-middle">
                                        Bhennai, India
                                    </td>
                                    <td class="align-middle">
                                        Chennai Super Kings
                                    </td>
                                    <td class="align-middle">
                                        Royal Challengers Bangalore
                                    </td>
                                    <td class="align-middle">
                                        <a href="#" class="text-violet">Click</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-middle">
                                        2018/07/20 1730 Hrs
                                    </td>
                                    <td class="align-middle">
                                        Ahennai, India
                                    </td>
                                    <td class="align-middle">
                                        Chennai Super Kings
                                    </td>
                                    <td class="align-middle">
                                        Royal Challengers Bangalore
                                    </td>
                                    <td class="align-middle">
                                        <a href="#" class="text-violet">Click</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="text-center container mt-5">
                    <div class="row mb-2">
                        <div class="col h3">
                            <a href="#" class="text-violet">Gavaskar-Border Trophy 2018</a> | <a href="#" class="text-violet">Men's Cricket</a>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-lg mb-2">
                            <img src="../../static/assets/images/ipl.png" class="rounded border" width="50px" height="50px"/>
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Teams</span><br/>
                            Austalia, England, India, Srilanka, Pakistan
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Dates</span><br/>
                            28-June-2018 to 31-December-2018
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary">Venue</span><br/>
                            Australia
                        </div>
                        <div class="col-lg mb-2">
                            <span class="text-secondary"># Games</span><br/>
                            72
                        </div>
                    </div>
                    <form class="row mb-2">
                        <div class="col-lg">
                        </div>
                        <div class="col-lg form-group">
                            <input class="form-control" type="text" placeholder="Game Id/Admin Name" v-model="league_name">
                        </div>
                        <div class="col-lg form-group">
                            <a href="" class="btn btn-dark bg-violet border-0 w-100">Search Leagues</a>
                        </div>
                        <div class="col-lg">
                        </div>
                    </form>
                    <div class="w-100 max-height-90vh table-responsive-xl mb-2">
                        <table class="table sortable">
                            <thead>
                                <tr class="text-violet">
                                    <th scope="col-2">Game Id</th>
                                    <th scope="col-2">Created</th>
                                    <th scope="col-2"># Players</th>
                                    <th scope="col-2">Cash Per Game, INR</th>
                                    <th scope="col-2">Link</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="align-middle">
                                        2018/07/20 1730 Hrs
                                    </td>
                                    <td class="align-middle">
                                        Chennai, India
                                    </td>
                                    <td class="align-middle">
                                        Chennai Super Kings
                                    </td>
                                    <td class="align-middle">
                                        Royal Challengers Bangalore
                                    </td>
                                    <td class="align-middle">
                                        <a href="#" class="text-violet">Click</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-middle">
                                        2018/07/20 1730 Hrs
                                    </td>
                                    <td class="align-middle">
                                        Bhennai, India
                                    </td>
                                    <td class="align-middle">
                                        Chennai Super Kings
                                    </td>
                                    <td class="align-middle">
                                        Royal Challengers Bangalore
                                    </td>
                                    <td class="align-middle">
                                        <a href="#" class="text-violet">Click</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-middle">
                                        2018/07/20 1730 Hrs
                                    </td>
                                    <td class="align-middle">
                                        Ahennai, India
                                    </td>
                                    <td class="align-middle">
                                        Chennai Super Kings
                                    </td>
                                    <td class="align-middle">
                                        Royal Challengers Bangalore
                                    </td>
                                    <td class="align-middle">
                                        <a href="#" class="text-violet">Click</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'Page2',
    }
</script>

<style>
</style>