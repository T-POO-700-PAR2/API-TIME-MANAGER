<!-- src/layouts/MainLayout.vue -->
<template>
    <div>
        <header>
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
export default {
    name: 'MainLayout',
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
</style>