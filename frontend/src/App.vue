<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <HelloWorld msg="Welcome to Your Vue.js App"/>
  <div>
      <h1>Données de l'API</h1>
      <pre>{{ data }}</pre>
    </div>
</template>

    <!-- <script>
    import HelloWorld from './components/HelloWorld.vue'

    export default {
      name: 'App',
      components: {
        HelloWorld
      }
    }
    </script>
-->
<script>
export default {
  data() {
    return {
      data: null,
    };
  },
  mounted() {
    this.$axios.get('http://localhost:4000/api/users')
      .then(response => {
        this.data = response.data;
        console.log('Réponse de l\'API:', response.data);
      })
      .catch(error => {
        console.error('Erreur lors de la récupération des données:', error);
      });
  },
};
</script>


<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
