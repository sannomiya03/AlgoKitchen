Recipesheet = require "./recipesheet.coffee"
module.exports = class Menusheet
	constructor: ->
		@title = "さとしの素敵な晩御飯"
		@recipesheets = [ new Recipesheet(), new Recipesheet(), new Recipesheet() ]

	calcTotalNutrients: ->
		totalNutrients =
			calorie: 0
			ash: 0
			cholesterol: 0
			protein: 0
			water: 0
			fiber: 0
			fat: 0
			carb: 0
		for recipesheet in @recipesheets
			totalNutrients.calorie += recipesheet.calcTotalNutrients().calorie
			totalNutrients.ash += recipesheet.calcTotalNutrients().ash
			totalNutrients.cholesterol += recipesheet.calcTotalNutrients().cholesterol
			totalNutrients.protein += recipesheet.calcTotalNutrients().protein
			totalNutrients.water += recipesheet.calcTotalNutrients().water
			totalNutrients.fiber += recipesheet.calcTotalNutrients().fiber
			totalNutrients.fat += recipesheet.calcTotalNutrients().fat
			totalNutrients.carb += recipesheet.calcTotalNutrients().carb
		return totalNutrients