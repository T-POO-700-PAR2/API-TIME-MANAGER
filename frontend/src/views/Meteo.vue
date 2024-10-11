<template>
    <div>
        <div>
                <h1>Metéo</h1>
                <input type="text" v-model="searchQuery" placeholder="Rechercher une ville" />
        </div>
        
        <!-- Affichage des villes et de leurs informations filtrées -->
        <ul v-if="filteredCities.length">
            <li v-for="city in filteredCities" :key="city.city">
                <h3>{{ city.city }}</h3>
                <p>Température : {{ city.temperature }}°C</p>
                <p>Humidité : {{ city.humidity }}%</p>
                <p>Vitesse du vent : {{ city.wind_speed }} km/h</p>
                <p>Condition : {{ city.condition }}</p>

                <!-- Affichage de la prévision sur plusieurs jours -->
                <h4>Prévisions :</h4>
                <ul>
                    <li v-for="forecast in city.forecast" :key="forecast.day">
                        <p>{{ forecast.day }} - Température : {{ forecast.temperature }}°C, Condition : {{
                            forecast.condition }}</p>
                    </li>
                </ul>
            </li>
        </ul>

        <!-- Message si aucune ville ne correspond à la recherche -->
        <p v-else>Aucune ville trouvée</p>
    </div>
</template>

<script>
import { getAllDataMeteo } from '@/services/api';

export default {
    name: 'MeteoComponent',
    data() {
        return {
            cities: [],
            searchQuery: ''
        };
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
/* Style simple pour la barre de recherche */
input {
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    width: 100%;
    box-sizing: border-box;
}

ul {
    list-style-type: none;
    padding: 0;
}

li {
    padding: 10px 0;
    border-bottom: 1px solid #ddd;
}

h3,
h4 {
    margin: 0;
    font-size: 18px;
}

p {
    margin: 5px 0;
}
</style>