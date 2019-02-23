<template>
    <div class="m-5">
        <b-row>
            <b-col md="6" class="my-1">
                <b-form-group label-cols-sm="3" label="Filter" class="mb-0">
                    <b-input-group>
                    <b-form-input v-model="filter" placeholder="Type to Search" />
                        <b-input-group-append>
                            <b-button :disabled="!filter" @click="filter = ''">Clear</b-button>
                        </b-input-group-append>
                    </b-input-group>
                </b-form-group>
            </b-col>
            <b-col md="6" class="my-1">
                <b-form-group label-cols-sm="3" label="Sort" class="mb-0">
                    <b-input-group>
                        <b-form-select v-model="sortBy" :options="sortOptions">
                            <option slot="first" :value="null">-- none --</option>
                        </b-form-select>
                        <b-form-select :disabled="!sortBy" v-model="sortDesc" slot="append">
                            <option :value="false">Asc</option> <option :value="true">Desc</option>
                        </b-form-select>
                    </b-input-group>
                </b-form-group>
            </b-col>
        </b-row>

        <b-table 
            responsive="md"
            stacked="md"
            :items="items"
            :fields="fields"
            :filter="filter"
            :sort-by.sync="sortBy"
            :sort-desc.sync="sortDesc"
            :sort-direction="sortDirection"
            :thead-tr-class="textDanger"
            @filtered="onFiltered"
        >
        </b-table>
    </div>
</template>

<script>
    export default {
        name: 'Page3',
        data() {
            return {
                items: [
                    { isActive: true, age: 40, name: 'Dickerson' },
                    { isActive: false, age: 21, name: 'Shaw' },
                    { isActive: false, age: 9, name: 'Mini' },
                    { isActive: false, age: 89, name: 'Geneva' },
                    { isActive: true, age: 38, name: 'Carney' }
                ],
                fields: [
                    { key: 'name', label: 'Person Full name', sortable: true, sortDirection: 'desc', _cellVariants: { class: 'text-danger' } },
                    { key: 'age', label: 'Person age', sortable: true, class: 'text-center' },
                    { key: 'isActive', label: 'is Active' }
                ],
                sortBy: null,
                sortDesc: false,
                sortDirection: 'asc',
                filter: null,
                modalInfo: { title: '', content: '' },
                textDanger: 'text-violet'
            }
        },
        computed: {
            sortOptions() {
                // Create an options list from our fields
                return this.fields
                .filter(f => f.sortable)
                .map(f => {
                    return { text: f.label, value: f.key }
                })
            }
        },
        methods: {
            onFiltered(filteredItems) {
                // Trigger pagination to update the number of buttons/pages due to filtering
                this.totalRows = filteredItems.length
                this.currentPage = 1
            }
        }
    }
</script>