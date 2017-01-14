Collection = require "./first_class/Collection.coffee"
Calc = require "./Calc.coffee"

module.exports = class Option
	@collection = new Collection()
	getType: -> return "Option"
	@collection.instanceConstructor = (source) -> return new Option source
	@calc =
		cost: (option) -> return Calc.optionCost(option)
		sumCost : (options) -> return Calc.sumOptionCost(options)

	constructor: (source) ->
		@source = if source? then source else null
		@title = ""
		@price = 0
		@num = 0
		@active = 0
		@_init()

	_init: ->
		@title = @source.title
		@price = @source.price
		@num = @source.num
		@active = @source.active
		Option.collection.add this