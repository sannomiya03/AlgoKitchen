module.exports = class ForkCompiler
	@trueCharacters = ["true", "yes", "on", "はい", "真"]
	@falseCharacters = ["false", "no", "off", "いいえ", "偽"]
	@recomileCharacters = ["はい", "真", "いいえ", "偽"]

	@complieStatements: (inputs, statements)->
		for statement in statements
			result = this.complieStatement(inputs, statement)
			if result isnt null
				return result
		return null
	
	@complieStatement: (inputs, statement)->
		condExp = this.getConditinalExp(statement)
		operator = this.getOperatorStr(condExp)
		values = this.splitValues(condExp)
		values = this.compileValues(inputs, values)
		calcResult = this.operation(values, operator)
		returnValue = if calcResult then statement.match("return .*")?[0].replace("return ","").trim() else null
		# console.log "#{statement} -> #{values[0]} #{operator} #{values[1]} = #{calcResult} ( return #{returnValue} )"
		return returnValue

	@getConditinalExp: (statement)->
		return statement.match("if .* then")?[0].replace("if ","").replace(" then","").trim()

	@getOperatorStr: (condExp)->
		return condExp.match(/ < | > | <= | >= | == | is /)?[0].trim()

	@splitValues: (condExp)->
		return [
			condExp.split(/ < | > | <= | >= | == | is /)[0].trim()
			condExp.split(/ < | > | <= | >= | == | is /)[1].trim()
		]

	@compileValues: (inputs, values)->
		for value, index in values
			values[index] = this.compileValue(inputs, value)
		return values

	@compileValue: (inputs, compilingValue)->
		compilingValue = compilingValue.replace(/\'/g,"").replace(/\"/g,"")
		matchedParam = this.getMachedParam(inputs, compilingValue)
		if matchedParam isnt false then compilingValue = matchedParam.value
		if compilingValue in this.trueCharacters then return true
		if compilingValue in this.falseCharacters then return false
		if compilingValue[0].match(/[0-9]/) isnt null then return parseFloat(compilingValue)
		return compilingValue

	@getMachedParam: (inputs, compilingValue, parent="" )->
		for param, index in inputs
			# console.log "#{param.key} is #{compilingValue} = #{param.key is compilingValue}"
			if param.key is compilingValue
				return param
		return false

	@operation: (values, operator)->
		switch operator
			when ">" then return values[0] > values[1]
			when "<" then return values[0] < values[1]
			when ">=" then return values[0] >= values[1]
			when "<=" then return values[0] <= values[1]
			when "==","is" then return values[0] == values[1]