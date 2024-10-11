<!-- src/views/Home.vue -->
<template>
    <Navbar>
        <div>
            <h1>Bienvenue sur la page Manager</h1>
            <p>Ceci est la page Manager de l'application Vue.js</p>
        </div>
    </Navbar>
    <BarChart></BarChart>
</template>

<script>
import Navbar from '../loyouts/Navbar.vue';
import BarChart from '../components/BarChart.vue'

export default {
    name: 'ManagerPage',
    components: {
        Navbar,
        BarChart
    }
};
</script>

<style scoped>
h1 {
    color: #2c3e50;
}
</style>