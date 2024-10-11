<!-- src/views/Home.vue -->
<template>
    <Navbar>
        <template #default>
            <div>
                <h1>Bienvenue sur la page d'accueil</h1>
                <p>Ceci est la page d'accueil de notre application Vue.js</p>
            </div>
        </template>
    </Navbar>
    <Meteo/>
     
</template>

<script>
import Navbar from '../loyouts/Navbar.vue';
import Meteo from '../components/Meteo.vue';

export default {
    name: 'HomePage',
    components: {
        Navbar,
        Meteo
    }
};
</script>