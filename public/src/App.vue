<template>
  <div id="app">
    <!-- <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
      <div class="container px-5">
        <a class="navbar-brand" href="#/">
          <img src="@/assets/Ballstreet.png" width="25" />
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
  				<span class="navbar-toggler-icon"></span>
  			</button>
  
        <div class="collapse navbar-collapse" id="navbarsExample09">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <a class="nav-link active" href="#/">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Discover</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Create</a>
            </li>
          </ul>
          <ul class="navbar-nav" v-if="['Login', 'NewUser'].indexOf($route.name) == -1">
					<li class="nav-item">
						<a class="nav-link" href="#">Investments</a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							{{userDetails.email}}
						</a>
						<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">
								<span class="text-secondary">Ballstreet ID</span><br/>
								{{userDetails.shortid}}
							</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="#">
								<span class="text-secondary">Funds</span><br/>
								INR 739
							</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="" @click="logout()">Log Out</a>
						</div>
					</li>
				</ul>
        </div>
      </div>
    </nav> -->
    <div class="d-flex flex-column flex-md-row align-items-center p-2 px-md-4 mb-1 bg-white container">
		<div class="ballstreet-logo-full mr-md-auto font-weight-normal"></div>
		<nav class="mr-md-3">
			<a class="p-2 text-red font-weight-bold" href="">Get Started</a>
			<a class="p-2 text-red font-weight-bold" href="">Sign In</a>
			<a class="mx-2 btn btn-dark bg-red border-0 font-weight-bold" href="">Sign Up</a>
		</nav>
	  </div>
    <router-view/>
    <!-- <footer class="container px-5 py-4">
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
    </footer> -->
    <footer class="p-5 mx-auto text-center bg-violet">
		<div class="container">
			<div class="row">
				<div class="col-12 mb-4 col-md">
			    	<div class="ballstreet-logo-only mr-md-auto font-weight-normal w-100"></div>
			    	<h6 class="d-block text-yellow">2019 &copy; Ballstreet</h6>
			 	</div>
				<div class="col-sm-4 mb-4 col-md">
						 <h6 class="text-yellow font-weight-bold">Company</h6>
						 <ul class="list-unstyled font-size-12pc">
							 <li><a class="text-white" href="">About</a></li>
							 <li><a class="text-white" href="">Careers</a></li>
							 <li><a class="text-white" href="">Brand Center</a></li>
							 <li><a class="text-white" href="">Privacy & Terms</a></li>
							 <li><a class="text-white" href="">Returns & Refunds</a></li>
							 <li><a class="text-white" href="">Get In Touch</a></li>
						 </ul>
				 </div>
					<div class="col-sm-4 mb-2 col-md">
					 <h6 class="text-yellow font-weight-bold">Ballstreet</h6>
						 <ul class="list-unstyled font-size-12pc">
							 <li><a class="text-white" href="">Features</a></li>
							 <li><a class="text-white" href="">Security</a></li>
							 <li><a class="text-white" href="">Downloads</a></li>
							 <li><a class="text-white" href="">Games of Skill</a></li>
							 <li><a class="text-white" href="">How it Works</a></li>
						 </ul>
					</div>
			 <div class="col-sm-4 mb-4 col-md">
				 <h6 class="text-yellow font-weight-bold">Help</h6>
				 <ul class="list-unstyled font-size-12pc">
					 <li><a class="text-white" href="">FAQs</a></li>
					 <li><a class="text-white" href="#">Blog</a></li>
					 <li><a class="text-white" href="#">Facebook</a></li>
					 <li><a class="text-white" href="#">Twitter</a></li>
					 <li><a class="text-white" href="#">LinkedIn</a></li>

				 </ul>
			 </div>
		 </div>
			<div class="row">
				<div class="col font-size-12pc">
					<a href="https://www.freepik.com/free-photos-vectors/background" class="text-white">Background vector created by Freepik</a>
				</div>
			</div>
		</div>
	</footer>
  </div>
</template>

<script>
  export default {
    name: 'App',
    created() {
    
    },
    computed:{
      // loggedIn(){
      //   if(localStorage.getItem('userDetails')){ 
      //       return true;
      //   }
      //   else{
      //     return false;
      //   }
      // },
      // userDetails() {
      //   if(localStorage.getItem('userDetails')){
      //       return JSON.parse(localStorage.getItem('userDetails'));
      //   }
      // }
    },
    data() {
      return{
        get userDetails() {
          if(localStorage.getItem('userDetails')){
            return JSON.parse(localStorage.getItem('userDetails'));
          }
      }
      }
    },
    methods: {
      logout: function(){
        localStorage.removeItem('userDetails');
      }
    }
  }
</script>

<style>
  
</style>
