Vue = require "vue"
Menusheet = require "./models/menusheet.coffee"

module.exports = new Vue(
	data: ->
		return {
			menusheet: new Menusheet()
		}
)