<template>
    <div>
        <nav class="navbar navbar-light bg-light shadow-sm w-100 z-index-3">
            <div class=" px-5 mx-auto">
                <nav class="nav nav-secondary justify-content-center">
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-none d-sm-block">Reports</span>
                    </a>
                    <a class="nav-link text-secondary" href="#">
                        <span class="d-none d-sm-block">Inputs</span>
                    </a>
                </nav>
            </div>
        </nav>
        <div class="p-5 mx-auto text-center bg-light">
            <h1 class="text-violet mb-4">Inputs</h1>
            
            <div class="container h-100 py-2">
                <ul class="nav nav-pills nav-fill mt-3">
                    <li class="nav-item teams-pill">
                        <a class="nav-link active" data-toggle="tab" href="#teams-tab">Teams</a>
                    </li>
                    <li class="nav-item tournaments-pill">
                        <a class="nav-link" data-toggle="tab" href="#tournaments-tab">Tournaments</a>
                    </li>
                    <li class="nav-item calendar-pill">
                        <a class="nav-link" data-toggle="tab" href="#calendar-tab">Schedule</a>
                    </li>
                    <li class="nav-item results-pill">
                        <a class="nav-link" data-toggle="tab" href="#results-tab">Results</a>
                    </li>
                </ul>

                <div class="tab-content mt-3">
                    <div class="tab-pane fade show active" id="teams-tab" role="tabpanel">
                        <div class="row mx-auto mt-4">
                            <div class="col-lg"></div>
                            <div class="col-lg">
                                <form class="text-left">
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
                            <div class="col-lg"></div>
                        </div>
                        <hr class="my-5"/>
                        <h1 class="text-violet mb-5">Created Players/Teams</h1>
                        <div class="row mx-auto">
                            <div class="col-lg"></div>
                            <div class="col-lg">
                                <input class="form-control form-control-md mt-4 mb-3" type="text" placeholder="Search for Teams/Players"/>
                                <div class="w-100 max-height-90vh table-responsive mt-2 mb-4">
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
                                        </tbody>
                                    </table>                    
                                </div> 
                            </div>  
                            <div class="col-lg"></div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="tournaments-tab" role="tabpanel">
                        <div class="row mx-auto mt-4">
                            <div class="col-lg"></div>
                            <div class="col-lg">
                                <form class="text-left">
                                    <div class="form-group mt-4">
                                        <img src="../../static/assets/images/ipl.png" class="rounded border mb-2" width="50px" height="50px" /><br/>
                                        <label>Choose Image</label>
                                        <input type="file" class="form-control-file">
                                    </div>
                                    <div class="form-group mt-4">
                                        <label>Tournament Name</label>
                                        <input class="form-control" type="email" placeholder="Ex: IPL 2018" value="IPL 2018" />
                                    </div>
                                    <div class="form-group mt-4">
                                        <label>From Dates</label>
                                        <input class="form-control" type="email" placeholder="DD/MMM/YYYY: 29/Apr/2018" value="29/Apr/2018" />
                                    </div>
                                    <div class="form-group mt-4">
                                        <label>To Dates</label>
                                        <input class="form-control" type="email" placeholder="DD/MMM/YYYY: 29/Apr/2018" value="29/Apr/2018" />
                                    </div>
                                    <div class="form-group mt-4">
                                        <label># Games</label>
                                        <input class="form-control" type="email" placeholder="No. of Games" value="32" />
                                    </div>
                                    <div class="form-group mt-4">
                                        <label>Teams</label>
                                        <input class="form-control" type="email" placeholder="Multi-select Teams" value="A, B, C" />
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
                            <div class="col-lg"></div>
                        </div>
                        <hr class="my-5"/>
                        <h3 class="text-violet mb-3">Created Tournaments</h3>
                        <div class="row mx-auto">
                            <div class="col-lg">
                                <input class="form-control form-control-md mt-4 mb-3" type="text" placeholder="Search for Teams/Players"/>
                                <div class="w-100 max-height-90vh table-responsive mt-2 mb-4">
                                    <table class="table sortable">
                                        <thead>
                                            <tr class="text-violet">
                                                <th scope="col"><b>Image</b></th>
                                                <th scope="col">Tournament Name</th>
                                                <th scope="col">From Date</th>
                                                <th scope="col">To Date</th>
                                                <th scope="col"># Games</th>
                                                <th scope="col">Teams</th>
                                                <th scope="col">Links</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="align-middle">
                                                    <img src="../../static/assets/images/ipl.png" class="rounded border" width="50px" height="50px" />
                                                </td>
                                                <td class="align-middle">
                                                    Chennai Super Kings
                                                </td>
                                                <td class="align-middle">
                                                    29/Mar/2018
                                                </td>
                                                <td class="align-middle">
                                                    29/Jul/2018
                                                </td>
                                                <td class="align-middle">
                                                    32
                                                </td>
                                                <td class="align-middle">
                                                    A, B, C
                                                </td>
                                                <td class="align-middle">
                                                    <a href="#" class="text-violet">Edit</a>
                                                </td>
                                            </tr>                                          
                                        </tbody>
                                    </table>                    
                                </div> 
                            </div>                            
                        </div>
                    </div>
                    <div class="tab-pane fade" id="calendar-tab" role="tabpanel">
                        <div class="row mx-auto mt-4">
                            <div class="col-lg">
                                <div class="w-100 max-height-90vh table-responsive mt-2 mb-4">
                                    <table class="table sortable">
                                        <thead>
                                            <tr class="text-violet">
                                                <th scope="col">Date</th>
                                                <th scope="col">Time</th>
                                                <th scope="col">A</th>
                                                <th scope="col">B</th>
                                                <th scope="col">Venue</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <select class="form-control my-0 py-0">
                                                            <option>1</option>
                                                            <option>2</option>
                                                            <option>3</option>
                                                            <option>4</option>
                                                            <option>5</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <select class="form-control my-0 py-0">
                                                            <option>1</option>
                                                            <option>2</option>
                                                            <option>3</option>
                                                            <option>4</option>
                                                            <option>5</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <select class="form-control my-0 py-0">
                                                            <option>1</option>
                                                            <option>2</option>
                                                            <option>3</option>
                                                            <option>4</option>
                                                            <option>5</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <select class="form-control my-0 py-0">
                                                            <option>1</option>
                                                            <option>2</option>
                                                            <option>3</option>
                                                            <option>4</option>
                                                            <option>5</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <input class="form-control my-0 py-0" type="text" placeholder="Default input">
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="row mt-2">
                                        <div class="col-lg">
                                        </div>
                                        <div class="col-lg">
                                        </div>
                                        <div class="col-lg">
                                            <div class="row">
                                                <div class="col-lg">
                                                    <a href="" class="btn btn-dark bg-violet border-0 w-100">Save Changes</a><br/>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg mt-2">
                                                    <a href="" class="text-violet mt-5">Cancel</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>                  
                                </div> 
                            </div>
                        </div>
                        <hr class="my-5"/>
                        <h3 class="text-violet mb-3">Schedule</h3>
                        <div class="row mx-auto">
                            <div class="col-lg">
                                <input class="form-control form-control-md mt-4 mb-3" type="text" placeholder="Search for Teams/Players"/>
                                <div class="w-100 max-height-90vh table-responsive mt-2 mb-4">
                                    <table class="table sortable">
                                        <thead>
                                            <thead>
                                            <tr class="text-violet">
                                                <th scope="col"><b>Image</b></th>
                                                <th scope="col">Tournament Name</th>
                                                <th scope="col">From Date</th>
                                                <th scope="col">To Date</th>
                                                <th scope="col"># Games</th>
                                                <th scope="col">Teams</th>
                                                <th scope="col">Links</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="align-middle">
                                                    <img src="../../static/assets/images/ipl.png" class="rounded border" width="50px" height="50px" />
                                                </td>
                                                <td class="align-middle">
                                                    Chennai Super Kings
                                                </td>
                                                <td class="align-middle">
                                                    29/Mar/2018
                                                </td>
                                                <td class="align-middle">
                                                    29/Jul/2018
                                                </td>
                                                <td class="align-middle">
                                                    32
                                                </td>
                                                <td class="align-middle">
                                                    A, B, C
                                                </td>
                                                <td class="align-middle">
                                                    <a href="#" class="text-violet">Edit</a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>                    
                                </div> 
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="results-tab" role="tabpanel">
                        <div class="row mx-auto mt-4">
                            <div class="col-lg">
                                <div class="w-100 max-height-90vh table-responsive mt-2">
                                    <table class="table sortable">
                                        <thead>
                                            <tr class="text-violet">
                                                <th scope="col">Date</th>
                                                <th scope="col">Time</th>
                                                <th scope="col">A</th>
                                                <th scope="col">B</th>
                                                <th scope="col">Venue</th>
                                                <th scope="col">Result</th>
                                                <th scope="col">Submit</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        29/Jan/2019
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        17:30 hrs
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    Chennai Super Kings
                                                </td>
                                                <td class="align-middle">
                                                    Royal Challengers Bangalore
                                                </td>
                                                <td class="align-middle">
                                                    Krishnaswamy Stadium, Bangalore, India
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <select class="form-control my-0 py-0">
                                                            <option>Chennai Super Kings</option>
                                                            <option>Royal Challengers Bangalore</option>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group my-0 py-0">
                                                        <a href="" class="btn btn-dark bg-violet border-0 w-100">Submit</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>                 
                                </div> 
                            </div>
                        </div>
                        <hr class="my-5"/>
                        <h3 class="text-violet mb-3">Results</h3>
                        <div class="row mx-auto">
                            <div class="col-lg">
                                <input class="form-control form-control-md mt-4 mb-3" type="text" placeholder="Search for Teams/Players"/>
                                <div class="w-100 max-height-90vh table-responsive mt-2 mb-4">
                                    <table class="table sortable">
                                        <thead>
                                            <thead>
                                            <tr class="text-violet">
                                                <th scope="col">Date</th>
                                                <th scope="col">Time</th>
                                                <th scope="col">A</th>
                                                <th scope="col">B</th>
                                                <th scope="col">Venue</th>
                                                <th scope="col">Result</th>
                                                <th scope="col">Link</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="align-middle">
                                                    29/Mar/2018
                                                </td>
                                                <td class="align-middle">
                                                    2039 Hrs
                                                </td>
                                                <td class="align-middle">
                                                    Chennai Super Kings
                                                </td>
                                                <td class="align-middle">
                                                    Royal Challengers Bangalore
                                                </td>
                                                <td class="align-middle">
                                                    Chinnaswamy Stadium, Bangalore, India
                                                </td>
                                                <td class="align-middle">
                                                    Royal Challengers Bangalore
                                                </td>
                                                <td class="align-middle">
                                                    <a href="#" class="text-violet">
                                                        Click
                                                    </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="align-middle">
                                                    29/Mar/2018
                                                </td>
                                                <td class="align-middle">
                                                    2039 Hrs
                                                </td>
                                                <td class="align-middle">
                                                    Chennai Super Kings
                                                </td>
                                                <td class="align-middle">
                                                    Royal Challengers Bangalore
                                                </td>
                                                <td class="align-middle">
                                                    Chinnaswamy Stadium, Bangalore, India
                                                </td>
                                                <td class="align-middle">
                                                    TBU
                                                </td>
                                                <td class="align-middle">
                                                    <a href="#" class="text-violet">
                                                        Click
                                                    </a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>                    
                                </div> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>            
        </div>
    </div>
</template>

<script>
    export default {
        name: 'Page10',
    }
</script>

<style>
    .nav-pills .teams-pill .nav-link:not(.active) {
        background-color: #fafafa;
        color: #462446;
    }

    .nav-pills .tournaments-pill .nav-link:not(.active) {
        background-color: #fafafa;
        color: #462446;
    }

    .nav-pills .calendar-pill .nav-link:not(.active) {
        background-color: #fafafa;
        color: #462446;
    }

    .nav-pills .results-pill .nav-link:not(.active) {
        background-color: #fafafa;
        color: #462446;
    }

    .nav-pills .teams-pill .nav-link {        
        background-color: #462446;
        color: #ffffff;
    }

    .nav-pills .tournaments-pill .nav-link {
        background-color: #462446;
        color: #ffffff;
    }

    .nav-pills .calendar-pill .nav-link {
        background-color: #462446;
        color: #ffffff;
    }

    .nav-pills .results-pill .nav-link {
        background-color: #462446;
        color: #ffffff;
    }
</style>