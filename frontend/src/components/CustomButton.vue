<!-- src/components/CustomButton.vue -->
<template>
    <!-- Si un lien est fourni -->
    <router-link :to="link" v-if="link">
        <button @click="handleClick">
            <slot></slot>
        </button>
    </router-link>

    <!-- Si aucun lien n'est fourni -->
    <button v-else @click="handleClick">
        <slot></slot>
    </button>
</template>

<script>
export default {
    name: 'CustomButton',
    props: {
        link: {
            type: String,
            required: false,
            default: null
        },
        // La fonction @click est optionnelle, elle peut être définie par le parent
        handleClick: {
            type: Function,
            required: false,
            default: null
        }
    }
};
</script>

<style scoped>
button {
    background-color: #42b983;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #369d72;
}
</style>