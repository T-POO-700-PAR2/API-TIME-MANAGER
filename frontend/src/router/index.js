// router/index.js
import { createRouter, createWebHistory } from 'vue-router';
import Home from '@/views/Home.vue';
import Manager from '@/views/Manager.vue';
import MeteoVue from '@/views/Meteo.vue';

const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/manager', name: 'Manager', component: Manager },
  { path: '/meteo', name: 'Meteo', component: MeteoVue }

];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;