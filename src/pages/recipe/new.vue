<template lang="pug">
	section.page
		header
			div.meta
				p 献立名：
					input( type="text" v-model="menusheet.title")
			div.result
				p 合計値
					p 一食あたりの栄養バランス
					p {{calcTotalNutrients}}
					svg( width="100" height="100" )
						g
							polygon( :points="points( calcTotalNutrients )")
							circle( cx="50" cy="50" r="40" )
							axis-label( v-for="(nutrient, index) in calcTotalNutrients",
								:stat="nutrient",
								:index="index",
								:total="calcTotalNutrients.length")
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
		data: ->
			menusheet: bus.menusheet
		computed:
			calcTotalNutrients: ->
				totalNutrients =
					calorie: 0
					ash: 0
					cholesterol: 0
					protein: 0
					water: 0
					fiber: 0
					fat: 0
					carb: 0
				for recipesheet in this.menusheet.recipesheets
					totalNutrients.calorie += recipesheet.calcTotalNutrients().calorie
					totalNutrients.ash += recipesheet.calcTotalNutrients().ash
					totalNutrients.cholesterol += recipesheet.calcTotalNutrients().cholesterol
					totalNutrients.protein += recipesheet.calcTotalNutrients().protein
					totalNutrients.water += recipesheet.calcTotalNutrients().water
					totalNutrients.fiber += recipesheet.calcTotalNutrients().fiber
					totalNutrients.fat += recipesheet.calcTotalNutrients().fat
					totalNutrients.carb += recipesheet.calcTotalNutrients().carb
				return totalNutrients
		methods:
			points: (nutrients)->
				total = 8
				points = ""
				index = 0
				for key, value of nutrients
					x = 0
					y = -value * 0.4
					angle = Math.PI * 2 / total * index
					cos = Math.cos(angle)
					sin = Math.sin(angle)
					tx = x * cos - y * sin + 50
					ty = x * sin + y * cos + 50
					points += tx+","+ty
					if index < total - 1 then points += ","
					index++
				return points
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