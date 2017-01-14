Recipesheet = require "./recipesheet.coffee"
module.exports = class Menusheet
	constructor: ->
		@title = "さとしの素敵な晩御飯"
		@recipesheets = [ new Recipesheet(), new Recipesheet(), new Recipesheet() ]