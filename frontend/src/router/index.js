// router/index.js
import { createRouter, createWebHistory } from 'vue-router';
import Home from '@/views/Home.vue';
import Manager from '@/views/Manager.vue';
import MeteoVue from '@/views/Meteo.vue';
import Connect from '../views/PageConnect.vue'

const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/manager', name: 'Manager', component: Manager },
  { path: '/meteo', name: 'Meteo', component: MeteoVue },
  { path: '/connect', name: 'Connect', component: Connect }


];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;