<template>
    <div>
        <div class="text-center bg-light">
            <nav class="navbar sticky-top navbar-light bg-white shadow-sm w-100 z-index-3 border-top">
                <div class=" px-1 mx-auto">
                    <nav class="nav nav-secondary justify-content-center">
                        <a class="nav-link text-secondary b-0" href="#/inputteam">
                            <span class="d-sm-none" title="Team">Te</span>
                            <span class="d-none d-sm-block">Team</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/inputtournament">
                            <span class="d-sm-none" title="Tournament">To</span>
                            <span class="d-none d-sm-block">Tournament</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/inputschedule">
                            <span class="d-sm-none" title="Schedule">Sc</span>
                            <span class="d-none d-sm-block">Schedule</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/inputresult">
                            <span class="d-sm-none" title="Live">Re</span>
                            <span class="d-none d-sm-block">Result</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/reportacquisition">
                            <span class="d-sm-none" title="Acquisition">Ac</span>
                            <span class="d-none d-sm-block">Acquisition</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/reporthealth">
                            <span class="d-sm-none" title="Health">He</span>
                            <span class="d-none d-sm-block">Health</span>
                        </a>
                        <a class="nav-link text-secondary b-0" href="#/reporttransaction">
                            <span class="d-sm-none" title="reporttransaction">Tr</span>
                            <span class="d-none d-sm-block">Transaction</span>
                        </a>
                    </nav>
                </div>
            </nav>     
            <div class="container mx-auto bg-light p-5">
                <h1 class="text-violet mx-auto">Report</h1>
                <h4 class="text-violet mx-auto mb-5">Health</h4>

                <form class="form-row mt-5 mb-3">
                    <div class="col-sm">
                        <select class="form-control my-2">
                            <option>Minute</option>
                            <option>Hour</option>
                            <option>Day</option>
                            <option selected>Week</option>
                            <option>Month</option>
                            <option>Year</option>
                        </select>
                    </div>
                    <div class="col-sm">
                        <input type="text" class="form-control my-2" placeholder="Ex: 1" value="1">
                    </div>
                    <div class="col-sm">
                        <input type="text" class="form-control my-2" placeholder="Ex: 3" value="3">
                    </div>
                    <div class="col-sm">
                        <input type="text" class="form-control my-2" placeholder="Ex: 6" value="6">
                    </div>
                    <div class="col-sm">
                        <input type="text" class="form-control my-2" placeholder="Ex: 12" value="12">
                    </div>
                    <div class="col-sm">
                        <button class="btn btn-dark bg-violet w-100 my-2">Update</button>
                    </div>
                </form>
                <hr class="my-3" />
                <div class="w-100 table-responsive mt-4 px-0">
                    <b-table 
                        stacked="md"
                        :items="items"
                        :fields="fields"
                        show-empty
                        class="w-100 align-middle"
                    >
                        <template slot="empty" slot-scope="scope">
                            <h4>{{ scope.emptyText }}</h4>
                        </template>
                        <template slot="emptyfiltered" slot-scope="scope">
                            <h4>{{ scope.emptyFilteredText }}</h4>
                        </template>
                    </b-table>
                </div>
            </div>
            <hr />
            <div class="container mx-auto bg-light p-5">
                <h4 class="text-violet mx-auto mb-5">Health Dump Download</h4>
                <section class="pb-5">
                    <form class="text-left">
                        <div class="form-group row my-2">
                            <div class="col-sm">
                                <input type="text" class="form-control my-2" placeholder="From: DD/MM/YYYY">
                            </div>
                        </div>
                        <div class="form-group row my-2">
                            <div class="col-sm">
                                <input type="text" class="form-control my-2" placeholder="To: DD/MM/YYYY">
                            </div>
                        </div>                            
                        <div class="form-group row my-3">
                            <div class="col-sm">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="Metric1">
                                    <label class="form-check-label" for="Metric1">
                                        Metric 1
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="Metric2">
                                    <label class="form-check-label" for="Metric2">
                                        Metric 2
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="Metric3">
                                    <label class="form-check-label" for="Metric3">
                                        Metric 3
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="Metric4">
                                    <label class="form-check-label" for="Metric4">
                                        Metric 4
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="Metric5">
                                    <label class="form-check-label" for="Metric5">
                                        Metric 5
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row mt-5">
                            <div class="col-sm">
                                <button type="submit" class="btn btn-dark bg-violet w-100">Download</button>
                            </div>
                        </div>
                    </form>
                </section>
            </div>
        </div>
    </div>            
</template>

<script>
    export default {
        name: 'ReportHealth',
        data() {
            return {
                items: [
                    { fieldName: "Players", one: "12", two: "10", three: "6", four: "2" },
                    { fieldName: "Unique Players", one: "12", two: "10", three: "6", four: "2" },
                    { fieldName: "Tournaments", one: "12", two: "10", three: "6", four: "2" },
                    { fieldName: "Games", one: "12", two: "10", three: "6", four: "2" },
                    { fieldName: "Admins", one: "12", two: "10", three: "6", four: "2" },
                    { fieldName: "Value", one: "12", two: "10", three: "6", four: "2" },
                    { fieldName: "Discount", one: "12", two: "10", three: "6", four: "2" }
                ],
                fields: [
                    { key: 'fieldName', label: 'Field', isRowHeader: 'true' },
                    { key: 'one', label: '1 Week Avg' },
                    { key: 'two', label: '3 Week Avg' },
                    { key: 'three', label: '6 Week Avg' },
                    { key: 'four', label: '12 Week Avg' }
                ]
            }
        }
    }
</script>

<style>
</style>