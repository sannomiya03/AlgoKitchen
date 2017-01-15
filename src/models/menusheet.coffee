Recipesheet = require "./recipesheet.coffee"
module.exports = class Menusheet
	constructor: ->
		@title = "さとしの素敵な晩御飯"
		@recipesheets = []
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

	calcSumPrice: (sum=0) ->
		for recipesheet in @recipesheets then sum+=recipesheet.calcSumPrice()
		return sum

	calcSumPricePerOneServe: (sum=0) ->
		for recipesheet in @recipesheets then sum+=recipesheet.calcSumPricePerOneServe()
		return sum

	calcSumTime: (sum=0) ->
		for recipesheet in @recipesheets then sum+=recipesheet.calcSumTime()
		return sum

	addRecipe: (index)->
		@recipesheets.push this.recipes[index]
	
	deleteRecipe: (index) ->
		@recipesheets.splice(index,1)

	selectRecipe: (targetIndex, srcIndex) ->
		console.log "selected "+targetIndex+" to "+srcIndex
	loadRecipes: ->
		console.log "LOAD RECIPES.."
		# $.ajax({
		# 	url: 'http://52.199.193.52:3000/menus/0'
		# 	type: 'get'
		# 	dataType: 'json'
		# 	xhrFields: {
		# 		withCredentials: true
		# 	}
		# 	success: (result, textStatus, xhr) ->
		# 		console.log result
		# });
		## このdatas を getする
		datas = [{"title":"さとしのカレー","servings":2,"foods":[{"id":611,"title":"にんじん","option":"根","leather":true,"price":100,"num":1.0,"nutrients":{"calorie":36.0,"ash":0.6,"cholesterol":0.0,"protein":0.6,"water":90.2,"fiber":3.0,"carb":8.4,"fat":0.2}},{"id":190,"title":"じゃがいも","option":"塊茎","leather":false,"price":100,"num":3.0,"nutrients":{"calorie":73.0,"ash":0.6,"cholesterol":0.0,"protein":1.5,"water":81.0,"fiber":1.6,"carb":16.8,"fat":0.1}},{"id":1602,"title":"ぶた","option":"もも,皮下脂肪なし","leather":false,"price":100,"num":1.0,"nutrients":{"calorie":200.0,"ash":1.5,"cholesterol":88.0,"protein":30.2,"water":60.4,"fiber":0.0,"carb":0.3,"fat":7.6}},{"id":2130,"title":"カレールウ","option":"","leather":false,"price":100,"num":1.0,"nutrients":{"calorie":512.0,"ash":11.7,"cholesterol":20.0,"protein":6.5,"water":3.0,"fiber":3.7,"carb":44.7,"fat":34.1}}],"steps":[{"title":"切る","foods":["にんじん","じゃがいも","ぶた"],"time":5.0},{"title":"焼く","foods":["ぶた"],"time":15.0},{"title":"茹でる","foods":["にんじん","じゃがいも","ぶた","カレールウ"],"time":10.0}]},{"title":"さとしのサラダ","servings":2,"foods":[{"id":730,"title":"レタス","option":"土耕栽培,結球葉","leather":false,"price":100,"num":0.5,"nutrients":{"calorie":12.0,"ash":0.5,"cholesterol":0.0,"protein":0.6,"water":95.9,"fiber":1.1,"carb":2.8,"fat":0.1}},{"id":575,"title":"トマト","option":"果実","leather":false,"price":100,"num":2.0,"nutrients":{"calorie":19.0,"ash":0.5,"cholesterol":0.0,"protein":0.7,"water":94.0,"fiber":1.0,"carb":4.7,"fat":0.1}},{"id":455,"title":"きゅうり","option":"果実","leather":false,"price":100,"num":1.0,"nutrients":{"calorie":14.0,"ash":0.5,"cholesterol":0.0,"protein":1.0,"water":95.4,"fiber":1.1,"carb":3.0,"fat":0.1}},{"id":752,"title":"アボカド","option":"","leather":false,"price":100,"num":1.0,"nutrients":{"calorie":187.0,"ash":1.3,"cholesterol":0.0,"protein":2.5,"water":71.3,"fiber":5.3,"carb":6.2,"fat":18.7}},{"id":574,"title":"ヤングコーン","option":"幼雌穂","leather":false,"price":100,"num":2.0,"nutrients":{"calorie":29.0,"ash":0.6,"cholesterol":0.0,"protein":2.3,"water":90.9,"fiber":2.7,"carb":6.0,"fat":0.2}},{"id":670,"title":"ブロッコリー","option":"花序","leather":false,"price":100,"num":2.0,"nutrients":{"calorie":33.0,"ash":1.0,"cholesterol":0.0,"protein":4.3,"water":89.0,"fiber":4.4,"carb":5.2,"fat":0.5}}],"steps":[{"title":"切る","foods":["レタス","トマト","きゅうり","アボカド","ヤングコーン","ブロッコリー"],"time":5.0},{"title":"茹でる","foods":["ブロッコリー"],"time":10.0},{"title":"和える","foods":["和風ドレッシングタイプ調味料"],"time":0.5}]},{"title":"さとしの鍋","servings":2,"foods":[{"id":639,"title":"はくさい","option":"結球葉","leather":false,"price":100,"num":0.5,"nutrients":{"calorie":14.0,"ash":0.6,"cholesterol":0.0,"protein":0.8,"water":95.2,"fiber":1.3,"carb":3.2,"fat":0.1}},{"id":1694,"title":"とり","option":"もも","leather":true,"price":100,"num":1.0,"nutrients":{"calorie":253.0,"ash":0.7,"cholesterol":90.0,"protein":17.3,"water":62.9,"fiber":0.0,"carb":0.0,"fat":19.1}},{"id":289,"title":"木綿豆腐","option":"","leather":false,"price":100,"num":1.0,"nutrients":{"calorie":72.0,"ash":0.8,"cholesterol":0.0,"protein":6.6,"water":86.8,"fiber":0.4,"carb":1.6,"fat":4.2}},{"id":167,"title":"こんにゃく","option":"しらたき","leather":false,"price":100,"num":1.0,"nutrients":{"calorie":6.0,"ash":0.3,"cholesterol":0.0,"protein":0.2,"water":96.5,"fiber":2.9,"carb":3.0,"fat":0.0}},{"id":629,"title":"根深ねぎ","option":"葉,軟白","leather":false,"price":100,"num":0.5,"nutrients":{"calorie":34.0,"ash":0.5,"cholesterol":2.0,"protein":1.4,"water":89.6,"fiber":2.5,"carb":8.3,"fat":0.1}},{"id":920,"title":"えのきたけ","option":"","leather":false,"price":100,"num":1.0,"nutrients":{"calorie":22.0,"ash":0.9,"cholesterol":0.0,"protein":2.7,"water":88.6,"fiber":3.9,"carb":7.6,"fat":0.2}},{"id":2191,"title":"鍋キューブ","option":null,"leather":null,"price":100,"num":2.0,"nutrients":{"calorie":29.0,"ash":0.0,"cholesterol":55.0,"protein":1.2,"water":0.0,"fiber":3.7,"carb":0.0,"fat":0.7}}],"steps":[{"title":"切る","foods":["はくさい","とり","木綿豆腐","こんにゃく","根深ねぎ","えのきたけ","えのきたけ"],"time":5.0},{"title":"茹でる","foods":["鍋キューブ"],"time":10.0}]}]
		for data in datas
			recipe = new Recipesheet()
			recipe.title = data.title
			recipe.servings = data.servings
			for food in data.foods
				recipe.foods.push({
					title: food.title
					nutrients: food.nutrients
					price: food.price
					num: food.num
					use: true
				})
			for step in data.steps
				recipe.steps.push({
					title: step.title
					foods: step.foods
					time: step.time
					use: true
				})
			@recipes.push recipe
		console.log @recipes