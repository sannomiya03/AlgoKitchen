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
				rader( :width="100", :height="100", :arr="food.nutrients" )
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
					rader( :width="100", :height="100", :arr="recipesheet.calcTotalNutrients()" )
				li 1食あたりの値段：{{recipesheet.calcSumPricePerOneServe()}}
</template>

<script lang="coffee">
	Recipesheet = require "./../../models/recipesheet.coffee"
	module.exports =
		props: ["recipesheet"]
		components:
			rader: require "./../rader"
		mounted: ->
			return
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
	
</style>
