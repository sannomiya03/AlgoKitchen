<template lang="pug">
	div.flowEditer
		table
			tr
				th 工程名
				th 時間
				th 人数
				th 時給
				th 手間賃
			tr( v-for="task in getFlow.tasks")
				td {{task.title}}
				td
					input( type="number" v-model="task.aveTime" step="0.1" )
				td
					input( type="number" v-model="task.avePersons" )
				td
					input( type="number" v-model="task.hourlyWage" )
				td {{ cost(task).toFixed(1) }}
			tr
				td 合計
				td 
				td 
				td 
				td @{{ sum.toFixed(1) }}
		button( @click="reset()" ) RESET
</template>
<script lang="coffee">
	Task = require "../../models/data_type/Task.coffee"
	Flow = require "../../models/data_type/first_class/Flow.coffee"
	bus = require "./../../scripts/bus.coffee"
	
	module.exports =
		components: { InputNumber: require "./InputNumber" }
		props: ["part"]

		methods:
			reset: ->
				if not this.flow.tasks? then return
				for task, index in this.flow.tasks
					task.reset()

			cost: (task) -> return Task.calc.cost(task)

		computed:
			getFlow: ->
				if this.part is "body" then return bus.ordersheet.recipes.body.flow
				else return bus.ordersheet.recipes.lid.flow
			
			sum: -> return Task.calc.sumCost this.getFlow.tasks
</script>
<style lang="sass" scoped>
	@import "./../../sass/colors"
	@import "./../../sass/mixins"

	table
		width: 100%
		tr
			&:first-child
				border-bottom: 2px solid #ccc
			&:not(:first-child)
				border-top: 1px solid #ddd
			&:last-child
				border-top: 2px solid #ccc
		th
			color: $BlueGray600
			&:not(:first-child)
				text-align: center
		td, th
			font-size: 10pt
			&:nth-child(2)
				width: 4em
			&:nth-child(3)
				width: 4em
			&:nth-child(4)
				width: 5em
			&:last-child
				width: 4em
				color: $BlueGray700
				text-align: center
		td
			padding: 0.3em 0
			font-size: 10pt
			input
				width: 100%
				text-align: center
				background-color: transparent
				border: none
				outline: none
				&:focus
					border: none

	input[type="number"]
		&:hover
			border: none
		&:not(:disabled):focus
			border: none
</style>