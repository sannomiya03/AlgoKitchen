<template lang="pug">
	section.page
		header
			div.meta
				p 献立名：
					input( type="text" v-model="menusheet.title")
			div.result
				p 合計値
					p 一食あたりの栄養バランス
					rader( :width="200", :height="200", :arr="calcTotalNutrients", :showLabel="true" )
		main
			div.recipesheets.lay-scroll-y-parent
				recipesheet.lay-scroll-y-child( v-for="recipesheet in menusheet.recipesheets", :recipesheet="recipesheet")
				div.newRecipeSheet.lay-scroll-y-child( @click="menusheet.addRecipe()" )
					div.inner
						p.label メニューを加える
						p.symbol +

</template>
<script lang="coffee">
	bus = require "./../../bus.coffee"
	Recipesheet = require "./../../models/recipesheet.coffee"
	module.exports =
		components:
			recipesheet: require "./../../components/recipesheet/recipesheet"
			rader: require "./../../components/rader"
		data: ->
			menusheet: bus.menusheet
		computed:
			calcTotalNutrients: ->
				return this.menusheet.calcTotalNutrients()

</script>
<style lang="sass">
	@import "./../../sass/mixins"
	@import "./../../sass/colors"

	.page
		padding: 40px 0
		header
			padding: 0 40px
			display: flex
	.meta
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

	.newRecipeSheet
		width: 150px
		height: 200px
		background-color: $Gray200
		.inner
			display: flex
			flex-direction: column
			align-items: center
			justify-content: center
			padding-top: 60px
			.label
				color: $Gray600
				font-size: 10pt
			.symbol
				font-size: 21pt
				color: $Gray600
		+animate()
		cursor: pointer
		&:hover
			background-color: $White
			.label
				color: $LightBlue400
			.symbol
				color: $LightBlue400
</style>