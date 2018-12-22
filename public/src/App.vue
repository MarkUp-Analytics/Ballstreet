<template>
  <div id="app">
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
      <div class="container px-5">
        <a class="navbar-brand" href="#">
          <img src="@/assets/Ballstreet.png" width="25" />
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
  				<span class="navbar-toggler-icon"></span>
  			</button>
  
        <div class="collapse navbar-collapse" id="navbarsExample09">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <a class="nav-link active" href="#">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Discover</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Create</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <router-view/>
    <footer class="container px-5 py-4">
      <ul class="list-inline">
        <li class="list-inline-item mr-3"><a href="#">About</a></li>
        <li class="list-inline-item mr-3"><a href="#">How it works</a></li>
        <li class="list-inline-item mr-3"><a href="#">Blog</a></li>
        <li class="list-inline-item mr-3"><a href="#">Terms</a></li>
        <li class="list-inline-item mr-3"><a href="#">Privacy</a></li>
        <li class="list-inline-item mr-3"><a href="#">Disclosures</a></li>
        <li class="list-inline-item mr-3"><a href="#">Contact</a></li>
      </ul>
      <p class="text-secondary">&copy; Ballstreet. All rights reserved.</p>
    </footer>
  </div>
</template>

<script>
  export default {
    name: 'App'
  }
</script>

<style>
  
</style>
