<template>
    <div class="meteo-container">
        <!-- Navigation -->
        <Navbar></Navbar>

        <!-- Titre principal -->
        <h1>Metéo</h1>

        <!-- Barre de recherche -->
        <input type="text" v-model="searchQuery" placeholder="Rechercher une ville" />

        <!-- Affichage des villes et de leurs informations filtrées -->
        <ul class="cities-grid" v-if="filteredCities.length">
            <li v-for="city in filteredCities" :key="city.city">
                <h3>{{ city.city }}</h3>
                <p class="text">Température : <span class="temperature">{{ city.temperature }}°C</span></p>
                <p class="text">Humidité : {{ city.humidity }}%</p>
                <p class="text">Vitesse du vent : {{ city.wind_speed }} km/h</p>
                <p class="text">Condition : {{ city.condition }}</p>

                <!-- Affichage de la prévision sur plusieurs jours -->
                <h4>Prévisions :</h4>
                <ul class="forecast-grid">
                    <li v-for="forecast in city.forecast" :key="forecast.day" class="forecast-item">
                        <p class="text center">{{ forecast.day }}</p>
                        <p class="text">Température :</p><p> {{ forecast.temperature }}°C</p>
                        <p class="text">Condition : {{forecast.condition }}</p>
                    </li>
                </ul>
            </li>
        </ul>

        <!-- Message si aucune ville ne correspond à la recherche -->
        <p v-else>Aucune ville trouvée</p>
    </div>
</template>

<script>
import Navbar from '../loyouts/Navbar.vue';
import { getAllDataMeteo } from '@/services/api';

export default {
    name: 'MeteoComponent',
    data() {
        return {
            cities: [],
            searchQuery: ''
        };
    },
    components: {
        Navbar
    },
    mounted() {
        const allDataCities = getAllDataMeteo();
        this.cities = allDataCities.cities;
    },
    computed: {
        filteredCities() {
            return this.cities.filter(city =>
                city.city.toLowerCase().includes(this.searchQuery.toLowerCase())
            );
        }
    }
};
</script>

<style scoped>
/* Conteneur principal de la page météo */
.meteo-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    background-color: #f4f6f9;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* Barre de recherche */
input {
    padding: 12px;
    margin-bottom: 20px;
    width: 100%;
    max-width: 500px;
    border-radius: 8px;
    border: 1px solid #ddd;
    box-sizing: border-box;
    font-size: 1rem;
    transition: border-color 0.3s ease;
}
.text{
    color: black;
}

input:focus {
    outline: none;
    border-color: #42b983;
    box-shadow: 0 0 5px rgba(66, 185, 131, 0.5);
}

/* Liste des villes en mode grid avec flexbox */
.cities-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    /* Espace égal entre les blocs */
    gap: 20px;
    /* Espacement entre les blocs */
    align-content: flex-start;
    /* Aligner le contenu au début */
}

li {
    background-color: white;
    padding: 15px;
    width: calc(33.33% - 20px);
    /* 3 blocs côte à côte avec un espace de 20px */
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s, box-shadow 0.2s;
    display: flex;
    flex-direction: column;
    margin-bottom: 20px;
    /* Espacement entre les lignes */
}

li:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* Style pour les informations des villes */
h3 {
    font-size: 1.2rem;
    color: #333;
    margin-bottom: 10px;
    text-align: center;
}

p {
    font-size: 0.9rem;
    color: #555;
    margin: 5px 0;
}

.temperature {
    font-weight: bold;
    color: #ff5722;
}

/* Prévisions météorologiques */
h4 {
    font-size: 1rem;
    margin-top: 10px;
    color: #42b983;
}

.forecast-item {
    background-color: #f9fbfd;
    padding: 8px;
    margin-bottom: 8px;
    border-radius: 5px;
    font-size: 0.9rem;
    color: #666;
    width: 113px;
}

/* Message pour aucune ville trouvée */
p {
    text-align: center;
    font-size: 1.1rem;
    color: #ff5722;
    margin-top: 20px;
}

/* Style pour la liste des prévisions */
.forecast-grid {
    display: grid;
    /* Utilisation de Grid Layout */
    grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
    /* Crée des colonnes flexibles */
    gap: 10px;
    /* Espacement entre les éléments */
    margin-top: 10px;
    /* Marge au-dessus de la liste des prévisions */
}

.forecast-item {
    background-color: #f9fbfd;
    /* Couleur de fond des éléments de prévision */
    padding: 10px;
    /* Espacement à l'intérieur des éléments */
    border-radius: 8px;
    /* Coins arrondis */
    text-align: center;
    /* Centrer le texte */
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    /* Ombre légère pour le style */
    transition: transform 0.2s;
    /* Animation de transition pour le survol */
}

.forecast-item:hover {
    transform: translateY(-3px);
    /* Légère élévation lors du survol */
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    /* Ombre plus marquée lors du survol */
}

/* Réglages pour responsive design */
@media (max-width: 1024px) {
    li {
        width: calc(50% - 20px);
        /* 2 blocs côte à côte sur tablette */
    }
}

@media (max-width: 768px) {
    li {
        width: 100%;
        /* Un bloc par ligne sur mobile */
    }
}
</style>