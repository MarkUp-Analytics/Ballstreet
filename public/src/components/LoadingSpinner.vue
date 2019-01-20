<template>
    <div class="overlay">
        <div class="centerAligned">
        <span>
            <i class="fa fa-spinner fa-2x rotate text-yellow"></i>
        </span>
        <h5 style="color:white">Loading....</h5>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'LoadingSpinner',
        data() {
            return {}
        },
    }
</script>

<style scoped>
    .rotate {
        animation: spin 2s linear infinite;
    }
    
    .overlay {
        position: fixed;
        /* Sit on top of the page content */
        display: block;
        /* Hidden by default */
        width: 100%;
        /* Full width (cover the whole page) */
        height: 100%;
        /* Full height (cover the whole page) */
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.5);
        /* Black background with opacity */
        z-index: 2;
        /* Specify a stack order in case you're using a different order for other elements */
    }

    .centerAligned{
        top: 35%;
        left: 0;
        right: 0;
        position: absolute;
    }
    
    @keyframes spin {
        0% {
            transform: rotate(0deg);
        }
        100% {
            transform: rotate(360deg);
        }
    }
</style>