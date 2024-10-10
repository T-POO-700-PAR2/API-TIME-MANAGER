import { createApp } from 'vue';
import App from './App.vue';
import router from './router';  // Import du routeur
import axios from 'axios';

// Crée une instance de l'application Vue
const app = createApp(App);

// Configurer Axios globalement (app.config.globalProperties.$axios = axios)
app.config.globalProperties.$axios = axios;

// Utiliser le routeur
app.use(router);

// Monter l'application
app.mount('#app');