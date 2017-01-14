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
			section.input-item( v-for="food in recipesheet.foods" )
				p.input-item-title {{food.title}}
				p.input-item-value
					input( type="number" v-model="food.num")
					span 個
				p.input-item-value
					input( type="number" v-model="food.price")
					span 円/個
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
		methods:
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
				for food in foods
					totalNutrients.calorie += food.nutrients.calorie
					totalNutrients.ash += food.nutrients.ash
					totalNutrients.cholesterol += food.nutrients.cholesterol
					totalNutrients.protein += food.nutrients.protein
					totalNutrients.water += food.nutrients.water
					totalNutrients.fiber += food.nutrients.fiber
					totalNutrients.fat += food.nutrients.fat
					totalNutrients.carb += food.nutrients.carb
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
							nutrients:
								calorie: 18
								ash: 0.8
								cholesterol: 0
								protein: 2.2
								water: 93.2
								fiber: 2.4
								fat: 0.1
								carb: 3.4
							num: 1
							price: 100
						}
						{
							title: "にんじん"
							nutrients:
								calorie: 18
								ash: 0.8
								cholesterol: 0
								protein: 2.2
								water: 93.2
								fiber: 2.4
								fat: 0.1
								carb: 3.4
							num: 1
							price: 100
						}
						{
							title: "たまねぎ"
							nutrients:
								calorie: 18
								ash: 0.8
								cholesterol: 0
								protein: 2.2
								water: 93.2
								fiber: 2.4
								fat: 0.1
								carb: 3.4
							num: 1
							price: 100
						}
						{
							title: "カレールウ"
							nutrients:
								calorie: 18
								ash: 0.8
								cholesterol: 0
								protein: 2.2
								water: 93.2
								fiber: 2.4
								fat: 0.1
								carb: 3.4
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
					result:
						times: 0
						nutrients:
							calorie: 0
							ash: 0
							cholesterol: 0
							protein: 0
							water: 0
							fiber: 0
							fat: 0
							carb: 0
						price: 0
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
</style>
