Vue = require "vue"
Menusheet = require "./models/menusheet.coffee"

module.exports = new Vue(
	data: ->
		menusheet = new Menusheet()
		menusheet.loadRecipes()
		return {
			menusheet: menusheet
		}
)