<template>
    <div>
        <div class="p-5 mx-auto text-center bg-light">
            <h1 class="text-violet mb-4">P&L</h1>            
            <div class="container h-100 py-2">
                <ul class="nav nav-pills nav-fill mt-3">
                    <li class="nav-item current-investments-pill">
                        <a class="nav-link active" data-toggle="tab" href="#current-investments-tab">Current P&L</a>
                    </li>
                    <li class="nav-item past-investments-pill">
                        <a class="nav-link" data-toggle="tab" href="#past-investments-tab">Past P&L</a>
                    </li>
                </ul>

                <div class="tab-content mt-3">
                    <div class="tab-pane fade show active" id="current-investments-tab" role="tabpanel">                        
                        <table class="table table-md mt-4 mb-4">
                            <thead>
                                <tr class="text-violet">
                                    <th scope="col">Tournament</th>
                                    <th scope="col">Id</th>
                                    <th scope="col">Admin</th>
                                    <th scope="col"># Players</th>
                                    <th scope="col">Contr. INR</th>
                                    <th scope="col">Curr. Value INR</th>
                                    <th scope="col">P&L</th>
                                    <th scope="col">Link</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        2018/07/20 1730 Hrs
                                    </td>
                                    <td>
                                        Chennai, India
                                    </td>
                                    <td>
                                        Chennai Super Kings
                                    </td>
                                    <td>
                                        Royal Challengers Bangalore
                                    </td>
                                    <td>
                                        34
                                    </td>
                                    <td>
                                        10903
                                    </td>
                                    <td>
                                        Chennai Super Kings
                                    </td>
                                    <td>
                                        <a href="#" class="text-violet">Click</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        2018/07/20 1730 Hrs
                                    </td>
                                    <td>
                                        Chennai, India
                                    </td>
                                    <td>
                                        Chennai Super Kings
                                    </td>
                                    <td>
                                        Royal Challengers Bangalore
                                    </td>
                                    <td>
                                        34
                                    </td>
                                    <td>
                                        10902
                                    </td>
                                    <td>
                                        Chennai Super Kings
                                    </td>
                                    <td>
                                        <a href="#" class="text-violet">Click</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        2018/07/20 1730 Hrs
                                    </td>
                                    <td>
                                        Chennai, India
                                    </td>
                                    <td>
                                        Chennai Super Kings
                                    </td>
                                    <td>
                                        Royal Challengers Bangalore
                                    </td>
                                    <td>
                                        34
                                    </td>
                                    <td>
                                        10901
                                    </td>
                                    <td>
                                        Chennai Super Kings
                                    </td>
                                    <td>
                                        <a href="#" class="text-violet">Click</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="past-investments-tab" role="tabpanel">
                        <div class="w-100 max-height-90vh table-responsive-xl mt-4 mb-4">
                            <table class="table table-md sortable">
                                <thead>
                                    <tr class="text-violet">
                                        <th scope="col">Tournament</th>
                                        <th scope="col">Id</th>
                                        <th scope="col">Admin</th>
                                        <th scope="col"># Players</th>
                                        <th scope="col">Contr. INR</th>
                                        <th scope="col">Curr. Value INR</th>
                                        <th scope="col">P&L</th>
                                        <th scope="col">Link</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            2018/07/20 1730 Hrs
                                        </td>
                                        <td>
                                            Chennai, India
                                        </td>
                                        <td>
                                            Chennai Super Kings
                                        </td>
                                        <td>
                                            Royal Challengers Bangalore
                                        </td>
                                        <td>
                                            34
                                        </td>
                                        <td>
                                            1003
                                        </td>
                                        <td>
                                            Chennai Super Kings
                                        </td>
                                        <td>
                                            <a href="#" class="text-violet">Click</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            2018/07/20 1730 Hrs
                                        </td>
                                        <td>
                                            Chennai, India
                                        </td>
                                        <td>
                                            Chennai Super Kings
                                        </td>
                                        <td>
                                            Royal Challengers Bangalore
                                        </td>
                                        <td>
                                            34
                                        </td>
                                        <td>
                                            1090
                                        </td>
                                        <td>
                                            Chennai Super Kings
                                        </td>
                                        <td>
                                            <a href="#" class="text-violet">Click</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            2018/07/20 1730 Hrs
                                        </td>
                                        <td>
                                            Chennai, India
                                        </td>
                                        <td>
                                            Chennai Super Kings
                                        </td>
                                        <td>
                                            Royal Challengers Bangalore
                                        </td>
                                        <td>
                                            34
                                        </td>
                                        <td>
                                            10903
                                        </td>
                                        <td>
                                            Chennai Super Kings
                                        </td>
                                        <td>
                                            <a href="#" class="text-violet">Click</a>
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

<script type="text/javascript">
    export default {
        name: 'p&l',
        created() {
            oTable = $('.table').DataTable( {
                scrollY:'75vh',
                "scrollX": true,
                scrollCollapse: true,
                paging: false,
                dom: '<<t><"small text-center"i>>',
                fixedheader: true
            });
        }
    };
</script>

<style>
    .nav-pills .current-investments-pill .nav-link:not(.active) {
        background-color: #fafafa;
        color: #462446;
    }

    .nav-pills .past-investments-pill .nav-link:not(.active) {
        background-color: #fafafa;
        color: #462446;
    }

    .nav-pills .current-investments-pill .nav-link {        
        background-color: #462446;
        color: #ffffff;
    }

    .nav-pills .past-investments-pill .nav-link {
        background-color: #462446;
        color: #ffffff;
    }
</style>