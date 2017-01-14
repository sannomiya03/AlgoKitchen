Collection = require "./first_class/Collection.coffee"
Calc = require "./Calc.coffee"

module.exports = class Paper
	@collection = new Collection()
	@calc =
		needSize: (flow, size) -> return Calc.needSize({ flow:flow, size:size })
		paperNum: (flow, size, paper, cutVerDir) -> return Calc.paperNum({ flow:flow, size:size, paper:paper, cutVerDir: cutVerDir })
		cost: (flow, size, paper, cutVerDir) -> Calc.paperCost({ flow:flow, size:size, paper:paper, cutVerDir: cutVerDir })

	constructor: (source) ->
		@source = source if source?
		@title = if source?.title? then source.title else ""
		@width = if source?.width? then source.width else 0
		@height = if source?.height? then source.height else 0
		@price = if source?.price? then source.price else 0
		@cutVerDir = if source?.cutVerDir? then source.cutVerDir else true
		@use = if source?.use? then source.use else true

	toSource: ->
		return {
			title: @title
			width: @width
			height: @height
			price: @price
			cutVerDir: @cutVerDir
			use: @use
		}