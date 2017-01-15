<template lang="pug">
	section.page
		div.page-info
			div.meta
				p.label 献立名
					input( type="text" v-model="menusheet.title")
			div.meta
				p.label 1食あたりの栄養バランス
					rader( :width="200", :height="200", :arr="calcTotalNutrients", :showLabel="true" )
			div.meta
				p.label.big 単価：
					span.value 500
					span.unit 円
				p.label.big 単価：
					span.value 500
					span.unit 円
		main.page-body
			div.recipesheets.lay-scroll-y-parent
				recipesheet.lay-scroll-y-child( v-for="recipesheet, index in menusheet.recipesheets", :recipesheet="recipesheet", :index="index", @remove="remove")
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
		methods:
			remove: (index)->
				this.menusheet.deleteRecipe(index)

</script>
<style lang="sass">
	@import "./../../sass/mixins"
	@import "./../../sass/colors"

	.page
		display: flex
		.page-info
			padding: 0 40px
			width: 300px
			height: 100%
			background-color: $White
			border-right: 1px solid $Gray300
		.page-body
			width: 100px
			flex-grow: 1

	.meta
		padding-top: 40px
		input[type="text"]
			width: 240px
		.label
			font-size: 10pt
			color: $Gray800
		.label.big
			font-size: 13pt
			color: $Gray800

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