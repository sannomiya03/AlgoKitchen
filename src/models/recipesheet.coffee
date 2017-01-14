module.exports = class Recipesheet
	constructor: ->
		@title = "カレーライス"
		@servings = 2
		@foods = [
			{
				title: "じゃがいも"
				nutrients:
					calorie: 10
					ash: 20
					cholesterol: 5
					protein: 8
					water: 4
					fiber: 7
					fat: 12
					carb: 15
				num: 1
				price: 100
				use: true
			}
			{
				title: "にんじん"
				nutrients:
					calorie: 10
					ash: 20
					cholesterol: 5
					protein: 8
					water: 4
					fiber: 7
					fat: 12
					carb: 15
				num: 1
				price: 100
				use: true
			}
			{
				title: "たまねぎ"
				nutrients:
					calorie: 10
					ash: 20
					cholesterol: 5
					protein: 8
					water: 4
					fiber: 7
					fat: 12
					carb: 15
				num: 1
				price: 100
				use: true
			}
			{
				title: "カレールウ"
				nutrients:
					calorie: 10
					ash: 20
					cholesterol: 5
					protein: 8
					water: 4
					fiber: 7
					fat: 12
					carb: 15
				num: 1
				price: 100
				use: true
			}
		]
		@steps = [
			{
				title: "切る"
				foods: ["じゃがいも","にんじん","たまねぎ"]
				time: 5
			}
			{
				title: "炒める"
				time: 5
			}
			{
				title: "煮る"
				time: 10
			}
			{
				title: "煮込む"
				time: 15
			}
		]

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
		for food in @foods
			if food.use is false then continue
			totalNutrients.calorie += food.nutrients.calorie * food.num
			totalNutrients.ash += food.nutrients.ash
			totalNutrients.cholesterol += food.nutrients.cholesterol * food.num
			totalNutrients.protein += food.nutrients.protein * food.num
			totalNutrients.water += food.nutrients.water * food.num
			totalNutrients.fiber += food.nutrients.fiber * food.num
			totalNutrients.fat += food.nutrients.fat * food.num
			totalNutrients.carb += food.nutrients.carb * food.num
		return totalNutrients

	calcSumTime: (sumTime=0) ->
		for step in @steps
			sumTime+=step.time
		return sumTime

	calcSumPrice: (sumFoods=0) ->
		for food in @foods
			if food.use then sumFoods += food.num * food.price
		return sumFoods

	calcSumPricePerOneServe: ->
		return @calcSumPrice() / @servings