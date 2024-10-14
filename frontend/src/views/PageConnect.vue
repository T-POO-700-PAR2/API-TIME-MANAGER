<template>
    <Navbar></Navbar>
    <div class="auth-container">
        <!-- Bascule entre le formulaire de connexion et d'inscription -->
        <h2>{{ isLogin ? "Connexion" : "Créer un compte" }}</h2>

        <!-- Formulaire de connexion -->
        <form v-if="isLogin" @submit.prevent="handleLogin">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" v-model="loginForm.email" placeholder="Entrez votre email" required />
            </div>
            <div class="form-group">
                <label for="password">Mot de passe</label>
                <input type="password" id="password" v-model="loginForm.password"
                    placeholder="Entrez votre mot de passe" required />
            </div>
            <button type="submit">Se connecter</button>
        </form>

        <!-- Formulaire de création de compte -->
        <form v-else @submit.prevent="handleRegister">
            <div class="form-group">
                <label for="username">Nom d'utilisateur</label>
                <input type="text" id="username" v-model="registerForm.username"
                    placeholder="Entrez un nom d'utilisateur" required />
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" v-model="registerForm.email" placeholder="Entrez votre email" required />
            </div>
            <div class="form-group">
                <label for="password">Mot de passe</label>
                <input type="password" id="password" v-model="registerForm.password"
                    placeholder="Entrez votre mot de passe" required />
            </div>
            <button type="submit">Créer un compte</button>
        </form>

        <!-- Lien pour basculer entre connexion et création de compte -->
        <p @click="toggleForm">
            {{ isLogin ? "Pas encore de compte ? Créer un compte" : "Déjà un compte ? Se connecter" }}
        </p>
    </div>
</template>

<script>
import Navbar from '@/loyouts/Navbar.vue';

export default {
    name: "AuthComponent",
    data() {
        return {
            isLogin: true, // Permet de basculer entre connexion et inscription
            loginForm: {
                email: "",
                password: ""
            },
            registerForm: {
                username: "",
                email: "",
                password: ""
            }
        };
    },
    methods: {
        // Méthode pour basculer entre connexion et inscription
        toggleForm() {
            this.isLogin = !this.isLogin;
        },

        // Méthode pour gérer la soumission du formulaire de connexion
        handleLogin() {
            console.log("Connexion avec", this.loginForm);
            // Appelle une fonction pour gérer la logique de connexion, par ex. API
            alert(`Connexion réussie pour ${this.loginForm.email}`);
        },

        // Méthode pour gérer la soumission du formulaire de création de compte
        handleRegister() {
            console.log("Création de compte avec", this.registerForm);
            // Appelle une fonction pour gérer la logique d'inscription, par ex. API
            alert(`Compte créé pour ${this.registerForm.username}`);
        }
    },
    components: {
        Navbar
    }
};
</script>

<style scoped>
.auth-container {
    max-width: 400px;
    margin: auto;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 10px;
    background-color: #f9f9f9;
    text-align: center;
    margin-top: 50px;
}

h2 {
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 15px;
    text-align: left;
    margin-right: 23px;
}

label {
    display: block;
    margin-bottom: 5px;
}

input {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

button {
    width: 100%;
    padding: 10px;
    background-color: #5cb85c;
    border: none;
    color: white;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #4cae4c;
}

p {
    color: #007bff;
    cursor: pointer;
}

p:hover {
    text-decoration: underline;
}
</style>