Recipesheet = require "./recipesheet.coffee"
module.exports = class Menusheet
	constructor: ->
		@title = "さとしの素敵な晩御飯"
		@recipesheets = [ new Recipesheet() ]
		@recipes = []

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

	addRecipe: ->
		@recipesheets.push new Recipesheet()
	
	deleteRecipe: (index) ->
		@recipesheets.splice(index,1)

	loadRecipes: ->
		console.log "LOAD RECIPES.."
		# $.get("http://52.199.193.52:3000/menus/0", (data)->
		# 	console.log data
		# )
		# {"title":"さとしのカレー","servings":2,"foods":[{"id":611,"title":"にんじん","option":"根","leather":true,"price":100,"num":1.0,"nutrients":{"calorie":36.0,"ash":0.6,"cholesterol":0.0,"protein":0.6,"water":90.2,"fiber":3.0,"carb":8.4}},{"id":190,"title":"じゃがいも","option":"塊茎","leather":false,"price":100,"num":3.0,"nutrients":{"calorie":73.0,"ash":0.6,"cholesterol":0.0,"protein":1.5,"water":81.0,"fiber":1.6,"carb":16.8}},{"id":1602,"title":"ぶた","option":"もも,皮下脂肪なし","leather":false,"price":100,"num":null,"nutrients":{"calorie":200.0,"ash":1.5,"cholesterol":88.0,"protein":30.2,"water":60.4,"fiber":0.0,"carb":0.3}},{"id":2130,"title":"カレールウ","option":"","leather":false,"price":100,"num":1.0,"nutrients":{"calorie":512.0,"ash":11.7,"cholesterol":20.0,"protein":6.5,"water":3.0,"fiber":3.7,"carb":44.7}}],"steps":[{"title":"切る","foods":["にんじん","じゃがいも","ぶた"],"time":5.0},{"title":"焼く","foods":["ぶた"],"time":15.0},{"title":"茹でる","foods":["にんじん","じゃがいも","ぶた","カレールウ"],"time":10.0}]}