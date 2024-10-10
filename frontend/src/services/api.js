// src/services/api.js
import axios from 'axios';

const apiClient = axios.create({
  baseURL: 'http://localhost:4000/api',
  headers: {
    'Content-Type': 'application/json'
  }
});

export default {
  getUsers() {
    return apiClient.get('/users');
  },
  // Ajoute d'autres méthodes selon tes besoins
};