module.exports = class Recipesheet
	constructor: ->
		@title = "no title"
		@servings = 1
		@foods = []
		@steps = []

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
			for food in step.foods
				for master_food in @foods
					if food is master_food.title
						if step.use then sumTime += step.time * master_food.num
		return sumTime

	calcSumPrice: (sumFoods=0) ->
		for food in @foods
			if food.use then sumFoods += food.num * food.price * @servings
		return sumFoods

	calcSumPricePerOneServe: ->
		return @calcSumPrice() / @servings