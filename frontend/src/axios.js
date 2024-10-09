import axios from 'axios';

const axiosInstance = axios.create({
  baseURL: 'http://localhost:4000/api', // URL de base de ton backend Phoenix
  timeout: 1000, // Tu peux ajuster le timeout si nécessaire
  headers: {
    'Content-Type': 'application/json', // Ajouter d'autres headers si besoin
  },
});

export default axiosInstance;
