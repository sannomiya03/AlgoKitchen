module.exports = class Param
	constructor: (args) ->
		@key = args.key
		@value = args.value
		@availableValues = if args.availableValues? then args.availableValues else []

	addAvailable: (value) ->
		if not(value in this.availableValues) then this.availableValues.push value