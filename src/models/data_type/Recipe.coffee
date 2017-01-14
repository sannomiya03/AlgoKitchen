Collection = require "./first_class/Collection.coffee"
Param = require "./first_class/Param.coffee"
Flow = require "./first_class/Flow.coffee"
Calc = require "./Calc.coffee"

module.exports = class Recipe
	@collection = new Collection()
	getType: -> return "Recipe"
	@collection.instanceConstructor = (source) -> return new Recipe source
	@calc =
		paperCost: (recipe, part, ordersheet) ->
			return Calc.sumRecipePaperCost recipe, part, ordersheet
		taskCost: (recipe) ->
			return Calc.sumTaskCost recipe.flow.run()

	constructor: (source) ->
		@source = source if source?
		@title = ""
		@flow = null
		@initParams = []
		@fixedParams = []
		@_init()

	_init: ->
		if not @source? then return
		@title = @source.title
		@flow = Flow.collection.new @source.flow
		@initParams = @_generateInitParams @source
		@_initFlowParams()
		@fixedParams = @_generateFiexedParams @source
		@_fixFlowParams()
		@flow.run()
		Recipe.collection.add this

	_generateInitParams: (source) ->
		if !source.initParams? then return []
		return @_parseParamsSource source.initParams

	_generateFiexedParams: (source) ->
		if !source.fixedParams? then return []
		return @_parseParamsSource source.fixedParams
	
	_parseParamsSource: (paramsSource, params=[])->
		for str in paramsSource
			params.push new Param({
				key: str.split(":")[0].trim()
				value: str.split(":")[1].trim()
				availableValues: [ str.split(":")[1].trim() ]
			})
		return params

	_initFlowParams: ->
		for param in @initParams
			for flowParam, index in @flow.params
				if flowParam.key is param.key
					@flow.params[index] = new Param({ key: flowParam.key, value: param.value, availableValues: flowParam.availableValues })

	_fixFlowParams: ->
		for param in @fixedParams
			for flowParam, index in @flow.params
				if flowParam.key is param.key
					@flow.params[index] = new Param({ key: flowParam.key, value: param.value, availableValues: [] })

	getActiveParams: ->
		return @flow.getActiveParams()

	run: ->
		@flow.run() if @flow?

	toSource: (decodedParams=[])->
		for param in @flow.params
			decodedParams.push "#{param.key}: #{param.value}"
		return {
			title: @title
			flow: @flow.title
			initParams: decodedParams
			fixedParams: @source.fixedParams
		}