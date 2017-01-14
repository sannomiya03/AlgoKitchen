Collection = require "./Collection.coffee"
ForkCompiler = require "./../compiler/ForkCompiler.coffee"
Task = require "./../Task.coffee"
Param = require "./Param.coffee"

module.exports = class Fork
	@collection = new Collection()
	@compiler = ForkCompiler
	getType: -> return "Fork"
	@collection.instanceConstructor = (source) -> return new Fork source

	constructor: (source, grobal=true) ->
		@source = if source? then source else null
		@title = ""
		@params = []
		@statements = []
		@outputs = []
		@_init() if source?.params?
		if grobal then Fork.collection.add this

	_init: ->
		@title = @source.title
		@_setParams()
		@_setStatement()
		@_setOutputs()

	_setParams: ->
		@params.length = 0
		for str in @source.params
			@params.push new Param({
				key: str.split(":")[0].trim(),
				value: str.split(":")[1].trim()
			})

	_setStatement: ->
		@statements.length = 0
		for statement in @source.statements
			values = Fork.compiler.splitValues Fork.compiler.getConditinalExp statement
			param = @_getParam @params, values[0]
			if param? then param.addAvailable values[1]
			@statements.push statement

	_setOutputs: ->
		for outputStrs in @source.outputs
			_outputs = []
			for str in outputStrs
				if str.indexOf("Task ") >= 0 then _outputs.push Task.collection.getObject str.slice ("Task ").length
				if str.indexOf("Fork ") >= 0 then _outputs.push Fork.collection.getObject str.slice ("Fork ").length
			@outputs.push _outputs

	_getParam: (inputs, key) ->
		for input in inputs then if input.key? and input.key is key then return input
		return null

	run: (results=[]) ->
		outputIndex = Fork.compiler.complieStatements(@params, @statements)
		if outputIndex is null then return []
		for object, index in @outputs[outputIndex]
			if object.getType() is "Task" then results.push object
			if object.getType() is "Fork"
				for result in object.run() then results.push result
		return results

	getOutputForks: (results=[]) ->
		outputIndex = Fork.compiler.complieStatements(@params, @statements)
		if outputIndex is null then return []
		for object, index in @outputs[outputIndex]
			if object.getType() is "Fork"
				results.push object
				for result in object.getOutputForks() then results.push result
		return results

	hasParam: (targetKey) ->
		for param in this.params then if param.key is targetKey then return true
		return false