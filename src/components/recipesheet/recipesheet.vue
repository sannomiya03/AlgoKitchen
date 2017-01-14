<template lang="pug">
	section.recipesheet
		section.editer-section
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
			table.foods
				tr.food( v-for="food,index in recipesheet.foods", :class="{ disabled: !food.use }" )
					td.checkbox
						input( type="checkbox", name="food.title", v-model="food.use" )
						label( for="food.title", class="checkbox" )
					td.title
						h3.food-title( @click="foodActivate(food) ") {{food.title}}
					td.info
						p.input-item
							span.label 1人前：
							input( type="number" v-model="food.num" min="0" v-bind:disabled="!food.use")
							span.unit 個
						p.input-item
							span.label 単価：
							input( type="number" v-model="food.price" min="0" v-bind:disabled="!food.use")
							span.unit 円/個
					td.diagram
						rader( :width="getDiagramSize(food.use)", :height="getDiagramSize(food.use)", :arr="food.nutrients" )
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
		methods:
			getDiagramSize: (use) ->
				if use then return 70
				else return 30
			foodActivate: (food) ->
				food.use = !food.use
</script>

<style lang="sass">
	@import "./../../sass/colors"
	@import "./../../sass/mixins"
	.recipesheet
		position: relative
		width: 540px
		margin: 0 20px
		padding: 20px
		background-color: #fff

	.editer-section
		width: 100%
		margin-bottom: 0px
		padding: 20px

	.editer-section-title
		font-size: 10pt
		font-weight: bold
		color: $Gray700
		margin-bottom: 0.5em
	
	.foods
		.food
			+animate()
			border-top: 1px solid $Gray200
			&:last-child
				border-bottom: 1px solid $Gray200
			td:nth-child(1)
				width: 1.5em
				position: relative
				top: 0.6em
			td:nth-child(4)
				width: 80px
			td:nth-child(3)
				width: 130px
		.food-title
			+animate()
			font-size: 12pt
			cursor: pointer
		.input-item
			+animate()
			opacity: 1
			font-size: 8pt
			color: $Gray700
			margin-bottom: 2px
			.label
				width: 4em
				text-align: right
		input[type="number"]
			font-size: 9pt
			height: 2.2em
			width: 2em
		.diagram
			text-align: center
	.food.disabled
		.food-title
			font-size: 8pt
			color: $Gray300
		.input-item
			opacity: 0
			font-size: 4pt
		input[type="number"]
			height: 0em
</style>
