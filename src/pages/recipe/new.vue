<template lang="pug">
	section.page
		header
			div.meta
				p 献立名：
					input( type="text" v-model="menusheet.title")
			div.result
				p 合計値
					p 一食あたりの栄養バランス
					svg( width="200" height="200" )
						g
							polygon( :points="points( calcTotalNutrients, 1 )")
							circle( cx="100" cy="100" r="40" )
							text( v-for="(value,key) in calcTotalNutrients", :x="getPoint(value,key).x", :y="getPoint(value,key).y" ) {{key}}
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
			points: (nutrients, size) ->
				total = 8
				points = ""
				index = 0
				for key, value of nutrients
					x = 0
					y = -value * 0.8 * size
					angle = Math.PI * 2 / total * index
					cos = Math.cos(angle)
					sin = Math.sin(angle)
					tx = x * cos - y * sin + 100 * size
					ty = x * sin + y * cos + 100 * size
					points += tx+","+ty
					if index < total - 1 then points += ","
					index++
				return points
			getIndex: (value) ->
				if value is "calorie" then return 0
				if value is "ash" then return 1
				if value is "cholesterol" then return 2
				if value is "protein" then return 3
				if value is "water" then return 4
				if value is "fiber" then return 5
				if value is "fat" then return 6
				if value is "carb" then return 7
				return 0
			
			getPoint: (value, key) ->
				index = this.getIndex key
				total = 8
				x = 0
				y = -110 * 0.4
				angle = Math.PI * 2 / total * index
				cos = Math.cos(angle)
				sin = Math.sin(angle)
				tx = x * cos - y * sin + 100
				ty = x * sin + y * cos + 100
				if index > 3
					tx -= 20
				return { x: tx, y: ty }
			
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