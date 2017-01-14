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
					input( type="number" v-model="recipesheet.servings" min="0" )
					span 人前
		section.editer-section
			h2.editer-section-title 材料
			section.input-item( v-for="food,index in recipesheet.foods" )
				p.input-item-title
					input( type="checkbox", name="food.title", v-model="food.use" )
					label( for="food.title", class="checkbox" ) {{food.title}}
				p.input-item-value
					input( type="number" v-model="food.num" min="0")
					span 個
					input( type="number" v-model="food.price" min="0")
					span 円/個
				svg( width="100" height="100" )
					g
						polygon( :points="points(food.nutrients)")
						circle( cx="50" cy="50" r="40" )
						axis-label( v-for="(nutrient, index) in food.nutrients",
							:stat="nutrient",
							:index="index",
							:total="food.nutrients.length")
		section.editer-section
			h2.editer-section-title 作業工程
			section.input-item( v-for="step in recipesheet.steps" )
				p.input-item-title {{step.title}}
				p.input-item-value
					input( type="number" v-model="step.time" min="0")
					span 分
		section.editer-section
			h2.editer-section-title 合計
			ul
				li 調理時間：{{recipesheet.calcSumTime()}} 分
				li 栄養バランス：
					svg( width="100" height="100" )
						g
							polygon( :points="points( recipesheet.calcTotalNutrients() )")
							circle( cx="50" cy="50" r="40" )
							axis-label( v-for="(nutrient, index) in recipesheet.calcTotalNutrients()",
								:stat="nutrient",
								:index="index",
								:total="recipesheet.calcTotalNutrients().length")
				li 1食あたりの値段：{{recipesheet.calcSumPricePerOneServe()}}
</template>

<script lang="coffee">
	Recipesheet = require "./../../models/recipesheet.coffee"
	module.exports =
		props: ["recipesheet"]
		mounted: ->
			return
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

		# data: ->
		# 	return {
		# 		recipesheet: new Recipesheet()
		# 	}
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
