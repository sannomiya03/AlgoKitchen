<template lang="pug">
	div
		section.input-item.input-item-pick-title( v-for="param in getActiveParams" v-if="getActiveValueIndex(param)!=-1" )
			p.input-item-title {{param.key}}
			p.input-item-value
				input-selecter(
					v-bind:target = "param"
					v-bind:values = "getParamSelecterValues(param)"
					v-bind:activeIndex = "getActiveValueIndex(param)"
					v-bind:direction = "'sidebyside'"
					v-bind:option = "'forkparam'"
					@select = "changeParam" )
</template>
<script lang="coffee">
	bus = require "./../../scripts/bus.coffee"

	module.exports =
		components: { InputSelecter: require "./InputSelecter" }
		props: ["part"]
		methods:
			changeParam: (msg) ->
				for param in this.getRecipe.flow.params
					if param is msg.target
						param.value = param.availableValues[msg.index]
				this.getRecipe.run()

			getParamSelecterValues: (param) ->
				values = []
				for value in param.availableValues
					values.push { label: value }
				return values

			getActiveValueIndex: (param) ->
				for val, index in param.availableValues
					if val is param.value then return index
				return -1

		computed:
			getRecipe: ->
				if this.part is "body" then return bus.ordersheet.recipes.body
				else return bus.ordersheet.recipes.lid
			getActiveParams: ->
				return this.getRecipe.getActiveParams()
</script>
<style lang="sass" scoped>
	@import "./../../sass/colors"
	@import "./../../sass/mixins"
</style>