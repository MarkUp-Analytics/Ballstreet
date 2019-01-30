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
                        <span class="d-sm-none" title="Players">Play</span>
                        <span class="d-none d-sm-block">Players</span>
                    </a>
                </nav>
            </div>
        </nav>
        <div class="p-5 mx-auto text-center bg-light">
            <div class="container">
                <h1 class="text-violet mt-1 mb-5">Players</h1>
                <div class="row mx-auto mb-2">
                    <div class="col-md"></div>
                    <div class="col-md">
                        <input class="form-control form-control-md mt-4 mb-3" type="text" placeholder="Search for Names"/>
                        <div class="w-100 max-height-90vh table-responsive mt-2 mb-4">
                            <table class="table sortable">
                                <thead>
                                    <tr class="text-violet">
                                        <th scope="col"><b>Name</b></th>
                                        <th scope="col">Net INR</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="align-middle">
                                            AA
                                        </td>
                                        <td class="align-middle">
                                            45
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            BB
                                        </td>
                                        <td class="align-middle">
                                            12
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            CC
                                        </td>
                                        <td class="align-middle">
                                            -57
                                        </td>
                                    </tr>
                                </tbody>
                            </table>                    
                        </div> 
                    </div>  
                    <div class="col-md"></div>
                </div>
            </div>
        </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'Page9',
    }
</script>

<style>
</style>