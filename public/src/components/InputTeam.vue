<template>
    <div class="text-center bg-light">
        <nav class="navbar sticky-top navbar-light bg-light shadow-sm w-100 z-index-3">
            <div class=" px-1 mx-auto">
                <nav class="nav nav-secondary justify-content-center">
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Team">Te</span>
                        <span class="d-none d-sm-block">Team</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Tournament">To</span>
                        <span class="d-none d-sm-block">Tournament</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Schedule">Sc</span>
                        <span class="d-none d-sm-block">Schedule</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Result">Re</span>
                        <span class="d-none d-sm-block">Result</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Acquisition">Ac</span>
                        <span class="d-none d-sm-block">Acquisition</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-sm-none" title="Transaction">Tr</span>
                        <span class="d-none d-sm-block">Transaction</span>
                    </a>
                </nav>
            </div>
        </nav>

        <div class="container-lg bg-light">
            <h1 class="text-violet">Input</h1>
            <h4 class="text-violet">Tournament</h4>
            
            <div class="row">
                <div class="col-lg-3 border-right mx-0 w-100">
                    <form class="text-left pt-5 px-5">
                        <h4 class="text-violet mt-4">Create Players / Teams</h4>
                        <div class="form-group mt-4">
                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" /><br/>
                            <label>Choose Image</label>
                            <input type="file" class="form-control-file">
                        </div>
                        <div class="form-group mt-4">
                            <label>Team/Player Name</label>
                            <input class="form-control" type="email" placeholder="Ex: India/Roger Federer" value="" />
                        </div>
                        <div class="row">
                            <div class="col-lg mt-4">
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
                <div class="col-lg-9 mx-0 w-100">
                    <section class="text-left pt-5 px-5">
                        <h4 class="text-violet mt-4">Created Players / Teams</h4>
                        <input class="form-control form-control-md mt-4 mb-3" type="text" placeholder="Search for Teams/Players"/>
                        <div class="w-100 table-responsive mt-2">
                            <table class="table sortable">
                                <thead>
                                    <tr class="text-violet">
                                        <th scope="col"><b>Image</b></th>
                                        <th scope="col">Team Name/Player Name</th>
                                        <th scope="col">Links</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="align-middle">
                                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" />
                                        </td>
                                        <td class="align-middle">
                                            Chennai Super Kings
                                        </td>
                                        <td class="align-middle">
                                            <a href="#" class="text-violet">Edit</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" />
                                        </td>
                                        <td class="align-middle">
                                            Chennai Super Kings
                                        </td>
                                        <td class="align-middle">
                                            <a href="#" class="text-violet">Edit</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" />
                                        </td>
                                        <td class="align-middle">
                                            Chennai Super Kings
                                        </td>
                                        <td class="align-middle">
                                            <a href="#" class="text-violet">Edit</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" />
                                        </td>
                                        <td class="align-middle">
                                            Chennai Super Kings
                                        </td>
                                        <td class="align-middle">
                                            <a href="#" class="text-violet">Edit</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" />
                                        </td>
                                        <td class="align-middle">
                                            Chennai Super Kings
                                        </td>
                                        <td class="align-middle">
                                            <a href="#" class="text-violet">Edit</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" />
                                        </td>
                                        <td class="align-middle">
                                            Chennai Super Kings
                                        </td>
                                        <td class="align-middle">
                                            <a href="#" class="text-violet">Edit</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" />
                                        </td>
                                        <td class="align-middle">
                                            Chennai Super Kings
                                        </td>
                                        <td class="align-middle">
                                            <a href="#" class="text-violet">Edit</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" />
                                        </td>
                                        <td class="align-middle">
                                            Chennai Super Kings
                                        </td>
                                        <td class="align-middle">
                                            <a href="#" class="text-violet">Edit</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" />
                                        </td>
                                        <td class="align-middle">
                                            Chennai Super Kings
                                        </td>
                                        <td class="align-middle">
                                            <a href="#" class="text-violet">Edit</a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>                    
                        </div>
                    </section>
                </div>
            </div>
                   
        </div>
    </div>
</template>

<script>
    export default {
        name: 'InputTeam',
    }
</script>

<style>
</style>