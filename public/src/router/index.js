import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Login from '@/components/Login'
import NewUser from '@/components/NewUser'
import Profile from '@/components/Profile'
import Create from '@/components/Create'
import Discover from '@/components/Discover'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/newuser',
      name: 'NewUser',
      component: NewUser
    },
    {
      path: '/profile',
      name: 'Profile',
      component: Profile
    },
    {
      path: '/create',
      name: 'Create',
      component: Create
    },
    {
      path: '/discover',
      name: 'Discover',
      component: Discover
    }
  ]
})
