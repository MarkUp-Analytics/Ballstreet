import Vue from 'vue'
import Router from 'vue-router'
import BootstrapVue from 'bootstrap-vue'
import Index from '@/components/Index'
import Signin from '@/components/Signin'
import SignUp from '@/components/SignUp'
import Home from '@/components/Home'
import Create from '@/components/Create'
import Discover from '@/components/Discover'
import LeagueDashboard from '@/components/LeagueDashboard'
import GetStarted from '@/components/GetStarted'
import AboutBallstreet from '@/components/GetStartedComponents/AboutBallstreet'
import HowBallstreetWorks from '@/components/GetStartedComponents/HowBallstreetWorks'
import GamesOfSkill from '@/components/GetStartedComponents/GamesOfSkill'
import Features from '@/components/GetStartedComponents/Features'
import Security from '@/components/GetStartedComponents/Security'
import Downloads from '@/components/GetStartedComponents/Downloads'
import BrandCenter from '@/components/GetStartedComponents/BrandCenter'
import Privacy from '@/components/GetStartedComponents/Privacy'
import Refund from '@/components/GetStartedComponents/Refund'
import FAQS from '@/components/GetStartedComponents/FAQS'
import Contact from '@/components/GetStartedComponents/Contact'
import Page1 from '@/components/Page1'
import Page2 from '@/components/Page2'
import Page3 from '@/components/Page3'
import PandL from '@/components/p&l'
import Page4 from '@/components/Page4'
import Page5 from '@/components/Page5'
import Page6 from '@/components/Page6'
import Page7 from '@/components/Page7'
import Page8 from '@/components/Page8'
import Page9 from '@/components/Page9'
import Page10 from '@/components/Page10'
import Page11 from '@/components/Page11'
import Profile from '@/components/Profile'
import InputTeam from '@/components/InputTeam'
import InputTournament from '@/components/InputTournament'
import InputResult from '@/components/InputResult'
import InputSchedule from '@/components/InputSchedule'
import ReportTransaction from '@/components/ReportTransaction'
import ReportAcquisition from '@/components/ReportAcquisition'
import ReportHealth from '@/components/ReportHealth'

Vue.use(Router)
Vue.use(BootstrapVue)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Index',
      component: Index
    },
    {
      path: '/signin',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'SignUp',
      component: SignUp
    },
    {
      path: '/home',
      name: 'Home',
      component: Home
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
    },
    {
      path: '/getstarted',
      name: 'GetStarted',
      component: GetStarted,
      children:[
        {
          path:'',
          name: 'AboutBallstreet',
          component: AboutBallstreet
        },
        {
          path:'howBallstreetWorks',
          name: 'HowBallstreetWorks',
          component: HowBallstreetWorks
        },
        {
          path:'gamesOfSkill',
          name: 'GamesOfSkill',
          component: GamesOfSkill
        },
        {
          path:'features',
          name: 'Features',
          component: Features
        },
        {
          path:'security',
          name: 'Security',
          component: Security
        },
        {
          path:'downloads',
          name: 'Downloads',
          component: Downloads
        },
        {
          path:'brandCenter',
          name: 'BrandCenter',
          component: BrandCenter
        },
        {
          path:'privacy',
          name: 'Privacy',
          component: Privacy
        },
        {
          path:'refund',
          name: 'Refund',
          component: Refund
        },
        {
          path:'FAQS',
          name: 'FAQS',
          component: FAQS
        },
        {
          path:'contact',
          name: 'Contact',
          component: Contact
        }
      ]
    },
    {
      path: '/dashboard',
      name: 'LeagueDashboard',
      component: LeagueDashboard
    },
    {
      path: '/page1',
      name: 'Page1',
      component: Page1
    },
    {
      path: '/page2',
      name: 'Page2',
      component: Page2
    },
    {
      path: '/page3',
      name: 'page3',
      component: Page3
    },
    {
      path: '/p&l',
      name: 'p&l',
      component: PandL
    },
    {
      path: '/page4',
      name: 'Page4',
      component: Page4
    },
    {
      path: '/page5',
      name: 'Page5',
      component: Page5
    },
    {
      path: '/page6',
      name: 'Page6',
      component: Page6
    },
    {
      path: '/page7',
      name: 'Page7',
      component: Page7
    },
    {
      path: '/page8',
      name: 'Page8',
      component: Page8
    },
    {
      path: '/page9',
      name: 'Page9',
      component: Page9
    },
    {
      path: '/page10',
      name: 'Page10',
      component: Page10
    },
    {
      path: '/page11',
      name: 'Page11',
      component: Page11
    },
    {
      path: '/profile',
      name: 'Profile',
      component: Profile
    },
    {
      path: '/inputTeam',
      name: 'Input Team',
      component: InputTeam
    },
    {
      path: '/inputTournament',
      name: 'Input Tournament',
      component: InputTournament
    },
    {
      path: '/inputSchedule',
      name: 'Input Schedule',
      component: InputSchedule
    },
    {
      path: '/inputResult',
      name: 'Input Result',
      component: InputResult
    },
    {
      path: '/reportAcquisition',
      name: 'Report Acquisition',
      component: ReportAcquisition
    },
    {
      path: '/reportTransaction',
      name: 'Report Transaction',
      component: ReportTransaction
    },
    {
      path: '/reportHealth',
      name: 'Report Health',
      component: ReportHealth
    }
  ]
})
