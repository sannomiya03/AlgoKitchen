<template lang="pug">
	section.editer-section
		h2.editer-section-title 追加工程
		table.inputOption
			tr( v-for="(option, index) in options" )
				td.labelColumn( @click="changeActivity(index)", :class="{ active: option.active }" )
					input( type="checkbox", name="option.name", v-model="option.active" )
					label( for="option.name", class="checkbox" ) {{option.title}}
				td.expressionColumn( v-show="option.active" )
					input.value( type="number", v-model="option.price", :id="'option-'+index", :part="'price'", :index="index" )
					span.unit 円
					span.operator ×
					input.value( type="number", v-model="option.num", :id="'option-'+index", :part="'num'", :index="index" )
					span.unit 点
					span.operator =
					span.result {{cost(option)}}
			tr
				td.labelColumn
				td.expressionColumn
					p 合計
					p @{{sum}}
</template>
<script lang="coffee">
	Option = require "./../../models/data_type/Option.coffee"
	bus = require "./../../scripts/bus.coffee"
	module.exports =
		data: -> return { options: bus.ordersheet.options }
		methods:
			changeActivity: (index) -> return this.options[index].active = not this.options[index].active
			cost: (option) -> return Option.calc.cost(option)
		computed: 
			sum: -> Option.calc.sumCost(this.options)
</script>
<style lang="sass" scoped>
	@import "./../../sass/colors"
	
	.editer-section
		margin-bottom: 0
	
	tr
		display: flex
		border-top: 1px solid #ddd
		height: 50px
		padding: 5px 0
		td
			display: flex
			align-items: center
	.labelColumn
		width: 40%
		cursor: pointer
	.expressionColumn
		width: 60%
		
	.value
		width: 80px
	.operator
		width: 2em
		text-align: center
	.result
		width: 3em

	label
		padding-left: 0.5em
		color: $Gray500
		cursor: pointer
		&:hover
			color: $Gray700
	td.active label
		color: $Black

	tr:last-child
		padding: 0
		.expressionColumn
			position: relative
			top: -1px
			border-top: 2px solid #ccc
			font-size: 10pt
			color: $BlueGray700
		.expressionColumn p
			width: 100%
			&:last-child
				text-align: right
</style>