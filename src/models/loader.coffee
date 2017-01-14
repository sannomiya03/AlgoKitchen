Task = require "./data_type/Task.coffee"
Fork = require "./data_type/first_class/Fork.coffee"
Flow = require "./data_type/first_class/Flow.coffee"
Recipe = require "./data_type/Recipe.coffee"
Option = require "./data_type/Option.coffee"

module.exports = class HacostaLoader
	@load: ->
		sources = HacostaLoader._loadSources()
		HacostaLoader._createObject sources
		return

	@_loadSources: ->
		return require "../hacostafiles/marushige.coffee"

	@_createObject: (sources) ->
		for data_type, dataGenerateSources of sources
			for dataGenerateSource in dataGenerateSources
				new Task dataGenerateSource if data_type is "task"
				new Fork dataGenerateSource if data_type is "fork"
				new Flow dataGenerateSource if data_type is "flow"
				new Recipe dataGenerateSource if data_type is "recipe"
				new Option dataGenerateSource if data_type is "option"