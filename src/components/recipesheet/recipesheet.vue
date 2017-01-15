<template lang="pug">
	section.recipesheet
		section.editer-section.header-section
			h2.editer-section-title レシピ
			div.editer-section-body
				h3.recipe-title {{recipesheet.title}}
				p.input-item
					span.label 量：
					input( type="number" v-model="recipesheet.servings" min="0" )
					span.unit 人前
		
		section.editer-section
			h2.editer-section-title 材料
			div.editer-section-body
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
								span.unit 円/{{food.num}}個
						//- td.diagram
						//- 	rader( :width="getDiagramSize(food.use)", :height="getDiagramSize(food.use)", :arr="food.nutrients" )
		
		section.editer-section
			h2.editer-section-title 作り方
			div.editer-section-body
				table.steps
					tr.step( v-for="step,index in recipesheet.steps", :class="{ disabled: !step.use }" )
						td.icon
							input( type="checkbox", name="step.title", v-model="step.use" )
							label( for="step.title", class="checkbox" )
							div.img-container( @click="stepActivate(step) ")
								img( src="http://localhost:8080/static/images/nife.svg" width="60px" height="60px")
						td.info
							h3.step-title() {{step.title}}
							p.source {{getActiveSources(step)}}
						td.time
							p.input-item
								span.label 時間：
								input( type="number" v-model="step.time" min="0")
								span.unit 分
		
		section.editer-section.result-section
			h2.editer-section-title 合計
			div.editer-section-body
				section.results
					div.time-and-price
						div.result
							span.label 時間：
							span.value {{recipesheet.calcSumTime()}}
							span.unit 分
						div.result
							span.label 単価：
							span.value {{recipesheet.calcSumPricePerOneServe()}}
							span.unit 円/1食
					div.diagram
						h3.result
							span.label 栄養バランス：
						rader( :width="100", :height="100", :arr="recipesheet.calcTotalNutrients()" )
					

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
			stepActivate: (step) ->
				step.use = !step.use
			getActiveSources: (step,sources=[],str="") ->
				for source in step.foods
					for food in this.recipesheet.foods
						if source == food.title && food.use then sources.push source
				for source, index in sources
					str += source
					if index < sources.length-1 then str += ", "
				return str
</script>

<style lang="sass">
	@import "./../../sass/colors"
	@import "./../../sass/mixins"
	.recipesheet
		position: relative
		width: 600px
		margin: 0 20px
		background-color: #fff

	.editer-section
		width: 100%
		margin-bottom: 0px
		padding: 20px
		display: flex

	.editer-section-title
		font-size: 10pt
		font-weight: bold
		color: $Gray700
		margin-bottom: 0.5em
		width: 90px
		padding-right: 40px
		text-align: right
	
	.editer-section-body
		width: 400px
		padding-right: 20px
		flex-grow: 1

	.foods
		.food
			+animate()
			border-top: 1px solid $Gray200
			&:last-child
				border-bottom: 1px solid $Gray200
			td:first-child
				width: 1.5em
				position: relative
				top: 0.6em
			td:last-child
				width: 80px
			td.info
				width: 140px
		.unit
			width: 5em
		.food-title
			+animate()
			font-size: 12pt
			cursor: pointer
		.diagram
			text-align: center
	.input-item
		+animate()
		opacity: 1
		font-size: 8pt
		color: $Gray700
		margin-bottom: 1px
		.label
			width: 4em
			text-align: right
	input[type="number"]
		font-size: 9pt
		height: 2.2em
		width: 2em
	.food.disabled
		.food-title
			font-size: 8pt
			color: $Gray300
		.input-item
			opacity: 0
			font-size: 4pt
		input[type="number"]
			height: 0em
	.step
		border-top: 1px solid $Gray200
		td:first-child
			width: 80px
		td:last-child
			width: 120px
		.source
			font-size: 8pt
			color: $Gray600
		.icon
			position: relative
			width: 80px
			height: 80px
			cursor: pointer
			input
				position: relative
				z-index: 9999
			.img-container
				position: absolute
				top: 0
				left: 0
				width: 80px
				height: 80px
				padding: 15px
				img
					width: 100%
					height: 100%
	.step.disabled
		img
			+animate()
			opacity: 0.2
		.step-title
			color: $Gray300
		.source
			color: $Gray200
		.input-item
			opacity: 0
			font-size: 4pt
		input[type="number"]
			height: 0em
	.results
		display: flex
		.time-and-price,.diagram
			width: 50%
		.time-and-price
			vertical-align: top
		.diagram
			display: flex
			align-items: top
		.result
			display: flex
			align-items: center
			.label
				color: $Gray800
				font-size: 10pt
			.unit
				color: $Gray800
				width: 8em
		.diagram .result
			align-items: flex-start

	.result-section
		border-top: 1px solid $Gray400
	.header-section
		align-items: flex-end
		padding-top: 30px
		padding-bottom: 10px
		.editer-section-body
			display: flex
			justify-content: space-between
			.input-item
				width: 120px
		.recipe-title
			font-size: 16pt
</style>
