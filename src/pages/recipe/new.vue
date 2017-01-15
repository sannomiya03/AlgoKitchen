<template lang="pug">
	section.page
		div.page-info
			div.meta
				p.label 献立名
					input( type="text" v-model="menusheet.title")
			div.meta
				p.label 単価：
					span.value {{menusheet.calcSumPricePerOneServe()}}
					span.unit 円/1食
				p.label 合計：
					span.value {{menusheet.calcSumPrice()}}
					span.unit 円
				p.label 時間：
					span.value {{menusheet.calcSumTime()}}
					span.unit 分
			div.meta
				p.label 1食あたりの栄養バランス
					rader( :width="200", :height="200", :arr="calcTotalNutrients", :showLabel="true" )
		main.page-body
			div.recipesheets.lay-scroll-y-parent
				recipesheet.lay-scroll-y-child( v-for="recipesheet, index in menusheet.recipesheets", :recipesheet="recipesheet", :index="index", @remove="remove")
				div.newRecipeSheet.lay-scroll-y-child
					div.inner
						div.selectbox
							select( name="selectedRecipe" v-model="selectedRecipeIndex")
								option(v-for="recipe,index in menusheet.recipes", :value="index") {{recipe.title}}
						p.label( @click="menusheet.addRecipe(selectedRecipeIndex)" ) このメニューを追加

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
			selectedRecipeIndex: 0
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
			font-size: 11pt
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
		.inner
			display: flex
			flex-direction: column
			align-items: center
			.label
				color: $Gray600
				font-size: 9pt
				margin-top: 1em
				cursor: pointer
				+animate()
				&:hover
					color: $Blue400
</style>