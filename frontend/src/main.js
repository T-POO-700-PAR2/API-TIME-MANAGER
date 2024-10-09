import { createApp } from 'vue';
import App from './App.vue';
import axios from './axios'; // Importe ton fichier axios configuré

const app = createApp(App);

// Associe l'instance Axios à l'application Vue
app.config.globalProperties.$axios = axios;

app.mount('#app');

