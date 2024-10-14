<!-- src/layouts/MainLayout.vue -->
<template>
    <div>
        <header>
            <div class="Btn">
                <ButtonConnect link="/connect"></ButtonConnect>
            </div>
            <h1>Mon Application</h1>
            <nav>
                <router-link to="/">Accueil</router-link>
                <router-link to="/manager">Manager</router-link>
            </nav>
            
        </header>
        <main>
            <slot></slot> 
        </main>

    </div>
</template>

<script>
import ButtonConnect from '@/components/ButtonConnect.vue';

export default {
    name: 'MainLayout',
    components: {
        ButtonConnect
    }
};
</script>

<style scoped>
header {
    background-color: #42b983;
    padding: 1rem;
    text-align: center;
}

nav a {
    margin: 0 15px;
    color: white;
    text-decoration: none;
}

footer {
    margin-top: 20px;
    text-align: center;
}
.btn{
    position: relative;
    right: 0px;
}
</style>