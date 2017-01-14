Collection = require "./Collection.coffee"
Fork = require "./Fork.coffee"
Param = require "./Param.coffee"

module.exports = class Flow
	@collection = new Collection()
	getType: -> return "Flow"
	@collection.instanceConstructor = (source) -> return new Flow source

	constructor: (source) ->
		@source = source if source?
		@title = ""
		@tasks = []
		@forks = []
		@params = []
		@_init()

	_init: ->
		if not @source? then return
		@title = @source.title
		@forks = @_generateForks @source
		@params = @_exractParams @forks
		Flow.collection.add this
	
	_generateForks: (source, forks=[]) ->
		for forkTitle in source.forks
			fork = Fork.collection.getObject forkTitle
			if fork? then forks.push new Fork(fork.source)
		return forks

	_exractParams: (forks, params=[]) ->
		for fork in forks
			params = @_exractForkParam fork, params
			for output, outputsIndex in fork.outputs
				for object, objectIndex in output
					if object.getType() is "Fork" then params = @_exractForkParam object, params
		return params

	_exractForkParam: (fork, params=[]) ->
		for param, index in fork.params
			if not @_hasParam params, param then params.push fork.params[index]
			else for addedParam in params
				if param.key is addedParam.key then param = addedParam
		return params

	_hasParam: (params, target) ->
		for param in params
			if param.key is target.key then return true
		return false

	_overrideForksParam: ->
		for recipeParam in @params
			for fork, forkIndex in @forks
				@forks[forkIndex] = @_overrideForkParam @forks[forkIndex], recipeParam
				for output, outIndex in fork.outputs
					for object, objIndex in output
						if object.getType() is "Fork"
							@forks[forkIndex].outputs[outIndex][objIndex] =
								@_overrideForkParam @forks[forkIndex].outputs[outIndex][objIndex], recipeParam

	_overrideForkParam: (fork, newParam) ->
		for forkParam, index in fork.params
			if forkParam.key is newParam.key
				fork.params[index] = newParam
		return fork

	_sarchForksByParam: (fork, paramKey, result=[]) ->
		if fork.hasParam(paramKey) then result.push fork
		for output, outIndex in fork.outputs
			for object, objIndex in output
				if object.getType() is "Fork" then result = @_sarchForksByParam object, paramKey, result
		return result

	run: ->
		@_overrideForksParam()
		@tasks.length = 0
		for fork in @forks
			for task in fork.run()
				@tasks.push task
		return @tasks

	getParam: (title) ->
		for param in @params
			if param.key is title then return param
		return null

	getForksByParam: (paramKey, result=[]) ->
		for fork, index in @forks
			result = @_sarchForksByParam fork, paramKey, result
		return result

	getActiveParams: (forks=@forks, params=[]) ->
		@_overrideForksParam()
		for fork in forks
			for param in fork.params then if !@_hasParam( params, param ) then params.push param
			if fork.getOutputForks().length>0 then params = @getActiveParams fork.getOutputForks(), params
		return params

	toSource: (decodedForks=[])->
		for fork in @forks then decodedForks.push "#{fork.title}"
		return {
			title: @title
			forks: decodedForks
		}