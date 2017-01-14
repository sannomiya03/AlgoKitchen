<template lang="pug">
	section
		input-selecter( :values="getSelecterValue", :activeIndex="getActiveIndex", @select="change", :direction="'sidebyside'", :option="'block'" )
</template>
<script lang="coffee">
	Recipe = require "../../models/data_type/Recipe.coffee"
	OrderSheet = require "./../../models/data_type/OrderSheet.coffee"
	bus = require "./../../scripts/bus.coffee"

	module.exports =
		components: { InputSelecter: require "./../input_modules/InputSelecter" }
		props: ["part"]
		data: ->
			recipes = Recipe.collection.newObjects()
			recipe =  recipes[0]
			for recipe, index in recipes
				if this.part is "body" and bus.ordersheet.recipes.body.title is recipe.title
					recipe = recipes[index]
					bus.ordersheet.recipes.body = recipe
					break
				if this.part is "lid" and bus.ordersheet.recipes.lid.title is recipe.title
					recipe = recipes[index]
					bus.ordersheet.recipes.lid = recipe
					break
			return {
				recipe: recipe
				recipes: recipes
			}
		
		methods:
			change: (msg) ->
				this.recipe = this.recipes[msg.index]
				this.recipe.run()
				if this.part is "body"
					bus.ordersheet.recipes.body = this.recipe
				else
					bus.ordersheet.recipes.lid = this.recipe

		computed:
			getSelecterValue: ->
				_recipes = []
				for recipe, index in this.recipes
					_recipes.push {
						title: recipe.title,
						pcost: "手間賃 : @" + Recipe.calc.taskCost(recipe).toFixed(1) + "円"
						rcost: "材料費 : @" + Recipe.calc.paperCost(recipe, this.part, bus.ordersheet).toFixed(1) + "円"
					}
				return _recipes

			getActiveIndex: ->
				for recipe, index in this.recipes
					if this.recipe.title is recipe.title then return index
				return -1
</script>
<style lang="sass" scoped>
	@import "./../../sass/colors"
	@import "./../../sass/mixins"
</style>