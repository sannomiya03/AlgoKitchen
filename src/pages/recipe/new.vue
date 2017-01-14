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
	.page
		padding: 40px 0
		header
			padding: 0 40px
			display: flex
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