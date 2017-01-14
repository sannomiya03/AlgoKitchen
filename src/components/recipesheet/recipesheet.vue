<!-- template for the polygraph component. -->

<template lang="pug">
	section.recipesheet
		section.editer-section
			h2.editer-section-title 基本情報
			section.input-item
				p.input-item-title メニュー名
				p.input-item-value {{recipesheet.title}}
			section.input-item
				p.input-item-title 人数
				p.input-item-value 
					input( type="number" v-model="recipesheet.servings" )
					span 人前
		section.editer-section
			h2.editer-section-title 材料
			section.input-item( v-for="food,index in recipesheet.foods" )
				p.input-item-title {{food.title}}
				p.input-item-value
					input( type="number" v-model="food.num")
					span 個
				p.input-item-value
					input( type="number" v-model="food.price")
					span 円/個
				
				svg( width="200" height="200" )
					g
						polygon( :points="points(food.nutrients)")
						circle( cx="100" cy="100" r="80" )
						axis-label( v-for="(nutrient, index) in food.nutrients",
							:stat="nutrient",
							:index="index",
							:total="food.nutrients.length")
		section.editer-section
			h2.editer-section-title 作業工程
			section.input-item( v-for="step in recipesheet.steps" )
				p.input-item-title {{step.title}}
				p.input-item-value
					input( type="number" v-model="step.time")
					span 分
		section.editer-section
			h2.editer-section-title 合計
			ul
				li 調理時間：{{calcSumTime(recipesheet.steps)}}
				li 栄養バランス：{{calcTotalNutrients(recipesheet.foods)}}
				li 1食あたりの値段：{{calcSumPricePerOneServe(recipesheet)}}
</template>

<script lang="coffee">
	module.exports =
		mounted: ->
			return
		methods:
			points: (nutrients)->
				total = nutrients.length
				points = ""
				for nutrient, index in nutrients
					value = nutrient.value
					x = 0
					y = -value * 0.8
					angle = Math.PI * 2 / total * index
					cos = Math.cos(angle)
					sin = Math.sin(angle)
					tx = x * cos - y * sin + 100
					ty = x * sin + y * cos + 100
					points += tx+","+ty
					if index < nutrients.length - 1 then points += ","
				return points

			calcSumTime: (steps, sumTime=0) ->
				for step in steps then sumTime+=step.time
				return sumTime
			calcTotalNutrients: (foods) ->
				totalNutrients =
					calorie: 0
					ash: 0
					cholesterol: 0
					protein: 0
					water: 0
					fiber: 0
					fat: 0
					carb: 0
				# for food in foods
				# 	totalNutrients.calorie += food.nutrients.calorie
				# 	totalNutrients.ash += food.nutrients.ash
				# 	totalNutrients.cholesterol += food.nutrients.cholesterol
				# 	totalNutrients.protein += food.nutrients.protein
				# 	totalNutrients.water += food.nutrients.water
				# 	totalNutrients.fiber += food.nutrients.fiber
				# 	totalNutrients.fat += food.nutrients.fat
				# 	totalNutrients.carb += food.nutrients.carb
				return totalNutrients
			calcSumPrice: (foods, sumFoods=0) ->
				for food in foods then sumFoods += food.num * food.price
				return sumFoods
			calcSumPricePerOneServe: (recipesheet) ->
				return this.calcSumPrice(recipesheet.foods) / recipesheet.servings

		data: ->
			return {
				recipesheet:
					title: "カレーライス"
					servings: 2
					foods: [
						{
							title: "じゃがいも"
							nutrients: [
								{ label: "calorie", value: 100 }
								{ label: "ash", value: 90 }
								{ label: "cholesterol", value: 80 }
								{ label: "protein", value: 70 }
								{ label: "water", value: 60 }
								{ label: "fiber", value: 50 }
								{ label: "fat", value: 40 }
								{ label: "carb", value: 10 }
							]
							num: 1
							price: 100
						}
						{
							title: "にんじん"
							nutrients: [
								{ label: "calorie", value: 100 }
								{ label: "ash", value: 100 }
								{ label: "cholesterol", value: 100 }
								{ label: "protein", value: 100 }
								{ label: "water", value: 100 }
								{ label: "fiber", value: 100 }
								{ label: "fat", value: 100 }
								{ label: "carb", value: 100 }
							]
							num: 1
							price: 100
						}
						{
							title: "たまねぎ"
							nutrients: [
								{ label: "calorie", value: 100 }
								{ label: "ash", value: 100 }
								{ label: "cholesterol", value: 100 }
								{ label: "protein", value: 100 }
								{ label: "water", value: 100 }
								{ label: "fiber", value: 100 }
								{ label: "fat", value: 100 }
								{ label: "carb", value: 100 }
							]
							num: 1
							price: 100
						}
						{
							title: "カレールウ"
							nutrients: [
								{ label: "calorie", value: 100 }
								{ label: "ash", value: 100 }
								{ label: "cholesterol", value: 100 }
								{ label: "protein", value: 100 }
								{ label: "water", value: 100 }
								{ label: "fiber", value: 100 }
								{ label: "fat", value: 100 }
								{ label: "carb", value: 100 }
							]
							num: 1
							price: 100
						}
					]
					steps: [
						{
							title: "切る"
							foods: ["じゃがいも","にんじん","たまねぎ"]
							time: 5
						}
						{
							title: "炒める"
							time: 5
						}
						{
							title: "煮る"
							time: 10
						}
						{
							title: "煮込む"
							time: 15
						}
					]
			}
</script>

<style lang="sass">
	@import "./../../sass/colors"
	.recipesheet
		position: relative
		width: 640px
		margin: 0 20px
		padding: 20px
		background-color: #fff
		// border: 1px solid #AF8727

	.editer-section
		width: 100%
		margin-bottom: 0px
		padding: 20px

	.editer-section-title
		font-size: 10pt
		font-weight: bold
		color: $Gray700
		// border-top: 2px solid $Gray700
		margin-bottom: 0.5em

	polygon
		fill: #42b983
		opacity: .75
	circle
		fill: transparent
		stroke: #999
	text
		font-family: Helvetica Neue, Arial, sans-serif
		font-size: 10px
		fill: #666
	label
		display: inline-block
		margin-left: 10px
		width: 20px
</style>
