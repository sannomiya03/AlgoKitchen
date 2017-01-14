<template lang="pug">
	section#app
		app-header
		main.app-body
			router-view.app-body
</template>
<script lang="coffee">
	module.exports =
		components:
			AppHeader: require "./components/header"
</script>
<style lang="sass">
	@import "./sass/colors"
	@import "./sass/base"
	@import "./sass/module"
	
	$app-bg-color: #F7F3E8
	$headerHeight: 50px

	html, body, #app
		position: relative
		width: 100%
		height: 100%
		background-color: $app-bg-color

	.app-body
		position: relative
		width: 100%
		height: 100%
		padding-top: $headerHeight
		overflow-x: hidden
</style>
