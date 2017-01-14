Recipe = require "./Recipe.coffee"
Option = require "./Option.coffee"
Calc = require "./Calc.coffee"
Paper = require "./Paper.coffee"
Loader = require "../HacostaLoader.coffee"

module.exports = class OrderSheet
	@calc = 
		paperCosts: (ordersheet) -> Calc.paperCosts ordersheet
		totalPaperCost: (ordersheet) -> Calc.totalPaperCost ordersheet
		totalTaskCost: (ordersheet) -> Calc.totalTaskCost ordersheet
		prepateCost: (ordersheet) -> Calc.prepateCost ordersheet
		sumOptionCost: (ordersheet) -> Calc.sumOptionCost ordersheet.options
		totalCost: (ordersheet) -> Calc.totalCost ordersheet
		discountRate: (ordersheet) -> Calc.discountRate ordersheet
		price: (ordersheet) -> Calc.price ordersheet
		totalPrice: (ordersheet) -> Calc.totalPrice ordersheet

	constructor: (source) ->
		@params = 
			size:
				width: 100
				depth: 100
				height: 100
				lidHeight: 100
			lots: 100
			rate: 30
			prepareCostRate: 10
			equipmentCost: 0
		@options = []
		@papers = 
			body:
				base: new Paper({height:1100, width:800, price: 100})
				inside: new Paper({height:1100, width:800, price: 100})
				wrap: new Paper({height:1100, width:800, price: 100})
			lid:
				base: new Paper({height:1100, width:800, price: 100})
				inside: new Paper({height:1100, width:800, price: 100})
				wrap: new Paper({height:1100, width:800, price: 100})
		@recipes = 
			body: if Recipe.collection.objects[0]? then Recipe.collection.newObjects()[0] else new Recipe()
			lid: if Recipe.collection.objects[0]? then Recipe.collection.newObjects()[0] else new Recipe()
		@results = null

	load: (filePath) ->
		Loader.load filePath
		@init()

	init: ->
		console.log "ordersheet inited"
		@params = 
			size:
				width: 100
				depth: 30
				height: 50
				lidHeight: 25
			lots: 100
			rate: 30
			prepareCostRate: 10
			equipmentCost: 10
		@options = Option.collection.objects
		@papers = 
			body:
				base: new Paper({height:1100, width:800, price: 100})
				inside: new Paper({height:1100, width:800, price: 100})
				wrap: new Paper({height:1100, width:800, price: 100})
			lid:
				base: new Paper({height:1100, width:800, price: 100})
				inside: new Paper({height:1100, width:800, price: 100})
				wrap: new Paper({height:1100, width:800, price: 100})
		@recipes = 
			body: if Recipe.collection.objects[0]? then Recipe.collection.newObjects()[0] else new Recipe()
			lid: if Recipe.collection.objects[0]? then Recipe.collection.newObjects()[0] else new Recipe()
		@results = null