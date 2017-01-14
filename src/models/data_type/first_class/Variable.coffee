Collection = require "./Collection.coffee"

module.exports = class Variable
	@collection = new Collection()
	getType: -> return "Variable"
	@collection.instanceConstructor = (source) -> return new Variable source
	
	constructor: (source) ->
		@source = if source? then source else null
		@name = if source?.name? then source.name else ""
		@value = if source?.value? then source.value else null
		@dataType = null
		this.init()

	init: ->
		if Variable.isNumber(this.value) then this.value = parseFloat(this.value)
		else if Variable.isBoolTrue(this.value) then this.value = true
		else if Variable.isBoolFalse(this.value) then this.value = false

	@booleanStrings = 
		true: ["true","yes","on","はい","する","真"]
		false: ["false","no","off","いいえ","しない","偽"]

	@isBoolTrue: (value) ->
		return Variable.value in Variable.booleanStrings.true

	@isBoolFalse: (value) ->
		return Variable.value in Variable.booleanStrings.false

	@isNumber: (value) ->
		return value[0].match(/[0-9]/) isnt null

