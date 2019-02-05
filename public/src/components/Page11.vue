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
            <h1 class="text-violet mb-4">Reports</h1>
            
            <div class="container h-100 py-2">
                <ul class="nav nav-pills nav-fill mt-3">
                    <li class="nav-item acquisitions-pill">
                        <a class="nav-link active" data-toggle="tab" href="#acquisitions-tab">Acquisitions</a>
                    </li>
                    <li class="nav-item transactions-pill">
                        <a class="nav-link" data-toggle="tab" href="#transactions-tab">Transactions</a>
                    </li>
                </ul>

                <div class="tab-content mt-3">
                    <div class="tab-pane fade show active" id="acquisitions-tab" role="tabpanel">
                        <form>
                            <div class="form-row mt-5 mb-3">
                                <div class="col-sm">
                                    <input type="text" class="form-control" placeholder="From: DD/MM/YY">
                                </div>
                                <div class="col-sm">
                                    <input type="text" class="form-control" placeholder="To: DD/MM/YY">
                                </div>
                                <div class="col-sm">
                                    <button class="btn btn-dark bg-violet w-100">Download</button>
                                </div>
                            </div>
                        </form>
                        <hr class="my-2 d-sm-none"/>
                        <h6 class="mt-4 mb-5 row">
                            <a href="#" class="text-violet col-sm px-1">
                                1D
                                <h4 class="text-dark">23</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                3D
                                <h4 class="text-dark">123</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                1W
                                <h4 class="text-dark">223</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                2W
                                <h4 class="text-dark">323</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                1M
                                <h4 class="text-dark">423</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                3M
                                <h4 class="text-dark">523</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                6M
                                <h4 class="text-dark">623</h4>
                            </a>
                        </h6>
                        <input class="form-control form-control-md my-1" type="text" placeholder="Search for Names"/>
                        <div class="w-100 max-height-90vh table-responsive mt-3 mb-4">
                            <table class="table table-md sortable">
                                <thead>
                                    <tr>
                                        <th scope="col" class="align-middle">Date</th>
                                        <th scope="col" class="align-middle">Email</th>
                                        <th scope="col" class="align-middle">Name</th>
                                        <th scope="col" class="align-middle">Source</th>
                                        <th scope="col" class="align-middle">Campaign Code</th>
                                        <th scope="col" class="align-middle">Campaign Name</th>
                                        <th scope="col" class="align-middle">Promo Code</th>
                                        <th scope="col" class="align-middle">First Tournament</th>
                                        <th scope="col" class="align-middle">Recent Tournament</th>
                                        <th scope="col" class="align-middle">Frequency Tournament</th>
                                        <th scope="col" class="align-middle">Created Tournament</th>
                                        <th scope="col" class="align-middle">Money Per Tournament</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="align-middle">
                                            03/Jan/1990 22:54Hrs
                                        </td>
                                        <td class="align-middle">
                                            mithsi@ballstreet.com
                                        </td>
                                        <td class="align-middle">
                                            Mithun Sivagurunathan
                                        </td>
                                        <td class="align-middle">
                                            Google
                                        </td>
                                        <td class="align-middle">
                                            12930840
                                        </td>
                                        <td class="align-middle">
                                            Google SEO
                                        </td>
                                        <td class="align-middle">
                                            MITH90
                                        </td>
                                        <td class="align-middle">
                                            03/Jan/1990 22:54Hrs
                                        </td>
                                        <td class="align-middle">
                                            03/Jan/1990 22:54Hrs
                                        </td>
                                        <td class="align-middle">
                                            0
                                        </td>
                                        <td class="align-middle">
                                            90
                                        </td>
                                        <td class="align-middle">
                                            903
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            03/Jan/1990 22:54Hrs
                                        </td>
                                        <td class="align-middle">
                                            mithsi@ballstreet.com
                                        </td>
                                        <td class="align-middle">
                                            Mithun Sivagurunathan
                                        </td>
                                        <td class="align-middle">
                                            Google
                                        </td>
                                        <td class="align-middle">
                                            12930840
                                        </td>
                                        <td class="align-middle">
                                            Google SEO
                                        </td>
                                        <td class="align-middle">
                                            MITH90
                                        </td>
                                        <td class="align-middle">
                                            03/Jan/1990 22:54Hrs
                                        </td>
                                        <td class="align-middle">
                                            03/Jan/1990 22:54Hrs
                                        </td>
                                        <td class="align-middle">
                                            3
                                        </td>
                                        <td class="align-middle">
                                            0
                                        </td>
                                        <td class="align-middle">
                                            903
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="transactions-tab" role="tabpanel">
                        <form>
                            <div class="form-row mt-5 mb-3">
                                <div class="col-sm">
                                    <input type="text" class="form-control" placeholder="From: DD/MM/YY">
                                </div>
                                <div class="col-sm">
                                    <input type="text" class="form-control" placeholder="To: DD/MM/YY">
                                </div>
                                <div class="col-sm">
                                    <button class="btn btn-dark bg-violet w-100">Download</button>
                                </div>
                            </div>
                        </form>
                        <hr class="my-2 d-sm-none"/>
                        <h6 class="mt-4 mb-5 row">
                            <a href="#" class="text-violet col-sm px-1">
                                1D
                                <h4 class="text-dark">23</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                3D
                                <h4 class="text-dark">123</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                1W
                                <h4 class="text-dark">223</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                2W
                                <h4 class="text-dark">323</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                1M
                                <h4 class="text-dark">423</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                3M
                                <h4 class="text-dark">523</h4>
                            </a>
                            <a href="#" class="text-violet col-sm px-1">
                                6M
                                <h4 class="text-dark">623</h4>
                            </a>
                        </h6>
                        <input class="form-control form-control-md my-1" type="text" placeholder="Search for Names"/>
                        <div class="w-100 max-height-90vh table-responsive mt-3 mb-4">
                            <table class="table table-md sortable">
                                <thead>
                                    <tr>
                                        <th scope="col" class="align-middle">Date</th>
                                        <th scope="col" class="align-middle">Email ID</th>
                                        <th scope="col" class="align-middle">Name</th>
                                        <th scope="col" class="align-middle">Tournament</th>
                                        <th scope="col" class="align-middle">Group ID</th>
                                        <th scope="col" class="align-middle">Group Name</th>
                                        <th scope="col" class="align-middle">Entry Fee</th>
                                        <th scope="col" class="align-middle">Value Per Game</th>
                                        <th scope="col" class="align-middle">Total Value</th>
                                        <th scope="col" class="align-middle">Type</th>
                                        <th scope="col" class="align-middle">Expiry</th>
                                        <th scope="col" class="align-middle">Lock-In</th>
                                        <th scope="col" class="align-middle">Earnings</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="align-middle">
                                            03/Jan/1990 22:54Hrs
                                        </td>
                                        <td class="align-middle">
                                            mithsi@ballstreet.com
                                        </td>
                                        <td class="align-middle">
                                            Mithun Sivagurunathan
                                        </td>
                                        <td class="align-middle">
                                            IPL 2019
                                        </td>
                                        <td class="align-middle">
                                            129308
                                        </td>
                                        <td class="align-middle">
                                            Amigos
                                        </td>
                                        <td class="align-middle">
                                            10
                                        </td>
                                        <td class="align-middle">
                                            10
                                        </td>
                                        <td class="align-middle">
                                            520
                                        </td>
                                        <td class="align-middle">
                                            Credit
                                        </td>
                                        <td class="align-middle">
                                            05/Jan/1990 22:54Hrs
                                        </td>
                                        <td class="align-middle">
                                            5
                                        </td>
                                        <td class="align-middle">
                                            5*.08*520/12
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-middle">
                                            03/Jan/1990 22:54Hrs
                                        </td>
                                        <td class="align-middle">
                                            mithsi@ballstreet.com
                                        </td>
                                        <td class="align-middle">
                                            Mithun Sivagurunathan
                                        </td>
                                        <td class="align-middle">
                                            IPL 2019
                                        </td>
                                        <td class="align-middle">
                                            129308
                                        </td>
                                        <td class="align-middle">
                                            Amigos
                                        </td>
                                        <td class="align-middle">
                                            10
                                        </td>
                                        <td class="align-middle">
                                            10
                                        </td>
                                        <td class="align-middle">
                                            520
                                        </td>
                                        <td class="align-middle">
                                            Debit
                                        </td>
                                        <td class="align-middle">
                                            0
                                        </td>
                                        <td class="align-middle">
                                            0
                                        </td>
                                        <td class="align-middle">
                                            0
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
</template>

<script>
    export default {
        name: 'Page10',
    }
</script>

<style>
    .nav-pills .acquisitions-pill .nav-link:not(.active) {
        background-color: #fafafa;
        color: #462446;
    }

    .nav-pills .transactions-pill .nav-link:not(.active) {
        background-color: #fafafa;
        color: #462446;
    }

    .nav-pills .acquisitions-pill .nav-link {        
        background-color: #462446;
        color: #ffffff;
    }

    .nav-pills .transactions-pill .nav-link {
        background-color: #462446;
        color: #ffffff;
    }
</style>