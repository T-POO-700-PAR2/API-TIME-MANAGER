<template>
    <div>
        <router-link :to="link" v-if="link">
            <button>
                <img src="../../public/icons/profil.png" alt="">
                <span>Connect</span>
            </button>
        </router-link>
    </div>
</template>

<script>
export default {
    name: 'ButtonConnectComponent',
    props: {
        link: {
            type: String,
            required: false,
            default: null
        }
    }
};
</script>

<style>
img{
    width: 15px;
    margin-right: 5px;
    position: relative;
    top: 2px;
}
span{
    line-height: 1px;
}
</style>