<template>
    <div class="meteo-container">
        <div v-if="selectedCity" class="city-info">
            <h2>{{ selectedCity.city }}</h2>
            <span class="temperature">{{ selectedCity.temperature }}°C</span>
            <p class="condition">Condition: {{ selectedCity.condition }}</p>
            <p class="details">Humidité: {{ selectedCity.humidity }}% | Vent: {{ selectedCity.wind_speed }} km/h</p>
        </div>
        <div class="buttons">
            <CustomButton @click="showRandomCity">
                Changer la ville
            </CustomButton>
            <CustomButton link="/meteo">
                Rechercher une ville spécifique
            </CustomButton>
        </div>
    </div>
</template>

<script>
import { getAllDataMeteo, getNameContry } from '@/services/api';
import CustomButton from '../components/CustomButton.vue';

export default {
    name: 'MeteoComponent',
    data() {
        return {
            cities: [],
            nomCities: [],
            selectedCity: null
        };
    },
    components: {
        CustomButton
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
        }
    }
};
</script>

<style scoped>
.meteo-container {
    max-width: 500px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 10px;
    background-color: #f9f9f9;
    text-align: center;
}

h1 {
    margin-bottom: 20px;
    font-size: 2rem;
}

.city-info {
    margin-bottom: 20px;
}

.city-info h2 {
    font-size: 1.8rem;
    margin-bottom: 30px;
}

.temperature {
    font-size: 2.5rem;
    color: #ff5722;
}

.condition {
    font-size: 1.2rem;
    margin-bottom: 10px;
}

.details {
    font-size: 1rem;
    color: #777;
}

.buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
}

button {
    background-color: #5cb85c;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1rem;
}

button:hover {
    background-color: #4cae4c;
}
</style>