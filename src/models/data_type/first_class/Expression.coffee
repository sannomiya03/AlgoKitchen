module.exports = class Expression
	getType: -> return "Expression"

	constructor: (source) ->
		@source = if source? then source else null
		@title = if source?.title? then source.title else ""
		@variables = []
		@expression = if source?.expression? then source.expression else null
		Expression.setArgs(this)

	@setVariables: (expression) ->
		expression.variables.length = 0
		for str in expression.source.variables
			expression.variables.push {
				key: str.split(":")[0].trim()
				value: str.split(":")[1].trim()
			}

	compute: (args) ->
		return 