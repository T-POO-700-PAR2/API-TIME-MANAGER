<template>
    <div>
        <h1>La Méteo</h1>
        <div v-if="selectedCity">
            <h2>{{ selectedCity.city }}</h2>
            <span>{{ selectedCity.temperature }}°</span>
        </div>
        <div>
            <button @click="showRandomCity">Voir plus</button>
            <button><RouterLink to="/meteo">Rechercher une ville</RouterLink></button>
        </div>
    </div>
</template>

<script>
import { getAllDataMeteo, getNameContry } from '@/services/api';

export default {
    name: 'MeteoComponent',
    data() {
        return {
            cities: [],     
            nomCities: [],  
            selectedCity: null
        };
    },
    mounted() {
        const allDataCities = getAllDataMeteo();
        const nameCities = getNameContry();

        this.cities = allDataCities.cities;
        this.nomCities = nameCities;
        this.showRandomCity();
    },
    methods: {
        showRandomCity() {
            if (this.nomCities.length > 0 && this.cities.length > 0) {
                const randIndex = Math.floor(Math.random() * this.nomCities.length);
                const randomCityName = this.nomCities[randIndex];
                const foundCity = this.cities.find(city => city.city === randomCityName);

                if (foundCity) {
                    this.selectedCity = foundCity;
                }
            }
        },
    }
};
</script>

<style>
button {
cursor: pointer;
}
    </style>