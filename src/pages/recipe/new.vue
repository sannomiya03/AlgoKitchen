<template lang="pug">
	section.page
		header
			div.meta
				p 献立名：
					input( type="text" v-model="menusheet.title")
		main
			div.recipesheets.lay-scroll-y-parent
				recipesheet.lay-scroll-y-child( v-for="recipesheet in menusheet.recipesheets")
</template>
<script lang="coffee">
	module.exports =
		components:
			recipesheet: require "./../../components/recipesheet/recipesheet"
		data: ->
			menusheet:
				title: "さとしの素敵晩御飯！"
				recipesheets: [
					{ title: "メニュー1" }
					{ title: "メニュー1" }
				]
</script>
<style lang="sass">
	.page
		padding: 40px 0
		header
			padding: 0 40px
	.meta
		// border-bottom: 1px solid #AF8727
		input[type="text"]
			width: 240px

	.lay-scroll-y-parent
		width: 100%
		overflow: hidden
		padding: 20px 40px
		overflow-x: auto
		white-space: nowrap

	.lay-scroll-y-child
		display: inline-block
		vertical-align: top
		white-space: normal
</style>