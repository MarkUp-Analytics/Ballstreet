import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Login from '@/components/Login'
import NewUser from '@/components/NewUser'
import Profile from '@/components/Profile'
import NewLeague from '@/components/NewLeague'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
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
      path: '/newLeague',
      name: 'NewLeague',
      component: NewLeague
    }
  ]
})
